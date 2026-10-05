# 距离测控仿真系统（A 级达标测试）— 参考资料包

学生：郑墨涵　学号：23009201247　完成日期：2026-09-25

## 文件说明

| 文件 | 说明 |
|------|------|
| `23009201247_郑墨涵_线上A测报告.docx / .pdf` | 测试报告（题目要求、阈值计算、仿真截图、参考文献、全部源码） |
| `DisDetectSys.pdsprj` | Proteus 8 工程原理图：Arduino UNO(ATmega328P) + LCD1602 + GP2D12 + 继电器驱动直流电机 + COMPIM 串口 |
| `程序/DistCtrl.ino` | Arduino 程序源代码（Arduino IDE 2.x 编译通过，UNO 板） |
| `程序/DistCtrl.ino.hex` | 已编译固件，直接在 Proteus 中加载到 ATmega328P 的 Program File |
| `程序/serial_host.py` | PC 上位机（Python 3 + pyserial + tkinter） |

## 功能与关键参数

- PC 上位机发送学号（`23009201247\n`），Arduino 回应 `OK:ID=xxx`，并每 500ms 上传 `DIST:xx.x`。
- 距离阈值 = 30 + 学号末位 = **37 cm**：距离 **高于 37cm 电机转动**，**低于（含等于）停止**（IO7 → 继电器）。
- LCD1602（RS=12, E=11, D4~D7=5/4/3/2）：第一行 `ID:学号`，第二行 `DIST:距离值`。
- GP2D12 输出接 A0（IO14），Proteus 模型特性方程 `V = 15.61824·d^-0.817 − 0.02869`（限幅 0.39~2.6V），
  程序内反变换 `d = ((V+0.02869)/15.61824)^(-1.224)`，64 次过采样后**四舍五入到整数厘米**显示（与传感器面板 1.0cm 步进严格一致）。

## 复现步骤

1. VSPD 创建虚拟串口对 **COM1 ↔ COM2**。
2. 打开 `DisDetectSys.pdsprj`，确认 COMPIM（P1）物理端口为 **COM1、9600、8N1**；
   ATmega328P 的 Program File 指向 `程序/DistCtrl.ino.hex`，Clock Frequency 为 16MHz。
3. 运行仿真；`python 程序/serial_host.py` 启动上位机，选择 **COM2**，打开串口，点击"发送学号"。
4. 点按传感器 U2 上的 −/+ 按钮手动调节距离：>37cm 电机转动，≤37cm 停止；LCD 与上位机同步显示。

运行结果截图见报告第二章节（图 1～图 6）。
