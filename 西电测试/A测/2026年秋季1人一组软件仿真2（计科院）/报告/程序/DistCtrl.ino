/*
 * ==================================================================
 *  题目：距离测控仿真系统（A级达标测试）
 *  平台：Arduino UNO (ATmega328P) + Proteus 8 仿真
 *  学生：郑墨涵   学号：23009201247
 * ------------------------------------------------------------------
 *  功能：
 *   1. 通过串口(9600bps,经COMPIM与虚拟串口对接)与PC上位机双向通信：
 *      PC发送学号(以'\n'结尾) -> Arduino保存并计算阈值(30+学号末位)，
 *      应答 OK:ID=xxx，并每500ms向PC发送当前距离值 DIST:xx.x。
 *   2. LCD1602 第一行显示 ID:学号，第二行显示 DIST:距离值。
 *   3. GP2D12 红外测距传感器(手动调节)输出接 A0(IO14)。
 *   4. 距离值 高于 阈值(30+学号末位)cm 时启动直流电机(IO7->继电器)；
 *      距离值 低于(含等于) 阈值时电机停止。
 * ------------------------------------------------------------------
 *  GP2D12 测距原理（Proteus 模型特性方程）：
 *      V = 15.61824 * d^(-0.817) - 0.02869   (输出限幅 0.39V~2.6V)
 *  反变换：
 *      d = ((V + 0.02869) / 15.61824) ^ (-1.224)
 * ==================================================================
 */
#include <LiquidCrystal.h>

/* LCD1602：RS=12, E=11, D4=5, D5=4, D6=3, D7=2 (RW接地) */
LiquidCrystal lcd(12, 11, 5, 4, 3, 2);

const uint8_t SENSOR_PIN = A0;    /* GP2D12 VO 输出 -> A0(IO14)        */
const uint8_t MOTOR_PIN  = 7;     /* IO7 -> 4.7k -> NPN -> 继电器->电机 */

/* GP2D12 特性常数（见文件头说明） */
const float GP_K = 15.61824f;     /* 增益 K1*K2 = 15.312*1.02         */
const float GP_B = 0.02869f;      /* K3 - K2*K4*TEMP = 0.07-1.02*1.5e-3*27 */
const float GP_E = -1.224f;       /* 指数 -1/0.817                    */

const unsigned long SEND_MS = 500;  /* 距离值上传周期 */

String studentID = "";              /* 上位机发来的学号 */
bool   idOK = false;                /* 是否已收到学号   */
int    threshold = 30;              /* 距离阈值 = 30 + 学号末位数 */

char rx_buf[24];                    /* 串口接收缓冲 */
uint8_t rx_len = 0;
unsigned long t_last = 0;

/* 读取距离值(cm)：64次过采样抑制ADC量化误差，再按特性方程反变换 */
float readDistanceCM()
{
  unsigned int sum = 0;
  for (uint8_t i = 0; i < 64; i++) sum += analogRead(SENSOR_PIN);
  float v = sum * (5.0f / 64.0f / 1023.0f);          /* 平均电压    */
  float d = pow((v + GP_B) / GP_K, GP_E);            /* 反变换      */
  return constrain(d, 0.0f, 999.0f);
}

void setup()
{
  pinMode(MOTOR_PIN, OUTPUT);
  digitalWrite(MOTOR_PIN, LOW);            /* 上电电机默认停止 */
  lcd.begin(16, 2);
  lcd.print("Wait for ID...");
  lcd.setCursor(0, 1);
  lcd.print("DIST:--.-");
  Serial.begin(9600);
}

void loop()
{
  /* ---- 1. 接收上位机发来的学号（以回车换行结束） ---- */
  while (Serial.available()) {
    char c = Serial.read();
    if (c == '\n' || c == '\r') {
      if (rx_len > 0) {
        rx_buf[rx_len] = '\0';
        bool valid = true;
        for (uint8_t i = 0; i < rx_len; i++)
          if (!isDigit(rx_buf[i])) { valid = false; break; }
        if (valid) {
          studentID = String(rx_buf);
          /* 阈值 = 30 + 学号末位数，如末位为7则阈值为37cm */
          int last = studentID.charAt(studentID.length() - 1) - '0';
          threshold = 30 + last;
          idOK = true;
          lcd.clear();
          lcd.setCursor(0, 0);
          lcd.print("ID:");
          lcd.print(studentID);           /* 第一行显示 ID:学号 */
          Serial.print("OK:ID=");         /* 应答上位机 */
          Serial.println(studentID);
          t_last = 0;                     /* 促使立即发送一帧距离 */
        }
      }
      rx_len = 0;
    }
    else if (rx_len < sizeof(rx_buf) - 1) {
      rx_buf[rx_len++] = c;
    }
  }

  /* ---- 2. 采集距离并控制电机 ---- */
  float dist = readDistanceCM();

  /* 传感器以1cm步进设定距离，读数四舍五入到整数厘米，
     使LCD/上位机显示值与传感器面板显示值完全一致 */
  float dist_show = roundf(dist);

  /* 距离高于阈值 -> 电机转动；低于(含等于)阈值 -> 电机停止 */
  digitalWrite(MOTOR_PIN, (idOK && dist_show > threshold) ? HIGH : LOW);

  /* ---- 3. 实时上传距离值，并刷新LCD第二行 ---- */
  unsigned long now = millis();
  if (idOK && (now - t_last >= SEND_MS)) {
    t_last = now;
    char val[12];
    dtostrf(dist_show, 4, 1, val);        /* "50.0" 整数厘米+1位小数 */
    lcd.setCursor(0, 1);
    lcd.print("DIST:");
    lcd.print(val);
    lcd.print(" ");                       /* 清除残留字符 */
    Serial.print("DIST:");
    Serial.println(val);                  /* 上位机显示距离值 */
  }
}
