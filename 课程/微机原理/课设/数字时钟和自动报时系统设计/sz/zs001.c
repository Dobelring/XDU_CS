#define PA_Addr 0x270
#define PB_Addr 0x271
#define PC_Addr 0x272
#define CON_Addr 0x273
#define u8 unsigned char
#define u16 unsigned int

extern char inportb(unsigned int); // 读I/O
extern void outportb(unsigned int, char);
extern void cDisplay8(u8*);
extern u8 cGetKeyA();
extern u8 cGetKeyB();
extern void cInitKeyDisplay();

void delay(u16 ms, u8* a);

u8 kkk;
u8 AD[25] = {
    0x00, 0x04, 0x08, 0x0C, 0x10,
    0x14, 0x18, 0x1C, 0x20, 0x24,
    0x28, 0x2C, 0x30, 0x34, 0x38,
    0x3C, 0x40, 0x44, 0x48, 0x4C,
    0x50, 0x54, 0x58, 0x5C, 0x60
};

u8 a[] = {0x09, 0x05, 0x03, 0x02, 0x10, 0x10, 0x10, 0x10};
u8 b[] = {0x00, 0x00, 0x00, 0x00, 0x10, 0x10, 0x10, 0x10};
u8 c[] = {0x00, 0x00, 0x00, 0x00, 0x10, 0x10, 0x10, 0x10};

void delay1(u16 ms) {
    u16 i;
    while (ms--) {
        i = 100;
        do {
            ;
        } while (--i);
    }
}

u8 KeepMode; // 保存REC、PLAYE、PLAYL当前值

void initISD() {
    outportb(PC_Addr, 0x70); // 语音模块初始化，关闭录放音功能
    KeepMode = 0x70;
    outportb(PA_Addr, 0); // 允许手动录放音,当A6,A7为高时，无法手动放音
}

void Delay50ms() {
    u16 i = 6600;
    while (--i) {
        ;
    }
}

void Delay_025S() {
    u16 i = 16000;
    while (i--) {
        ;
    }
    i = 16000;
    while (i--) {
        ;
    }
}

void stopISD() {
    u8 i = (KeepMode & 0xbf);
    outportb(PC_Addr, i); // PLAYL:一个负脉冲停止放音
    i |= 0x40;
    outportb(PC_Addr, i);
    i |= 0x30;
    outportb(PC_Addr, i); // 1->REC,PLAYE, 关闭所有操作指令
    KeepMode = i;
    outportb(PA_Addr, 0); // 允许手动录放音,当A6,A7为高时，无法手动放音
    Delay50ms();
    Delay50ms();
    Delay50ms();
}

void recISD(u8 startadr) {
    u8 i;
    outportb(PA_Addr, startadr); // 设置录音起始地址
    i = KeepMode & 0xef;
    outportb(PC_Addr, i); // REC变低，即开始录音
    KeepMode = i;
}

void playISD(u8 startadr) {
    u8 i;
    stopISD(); // 暂停之前的录放音操作
    outportb(PA_Addr, startadr); // 设置放音起始地址
    i = KeepMode & 0xdf;
    outportb(PC_Addr, i); // 0->PLAYE 开始放音,边沿放音模式
    i |= 0x20;
    outportb(PC_Addr, i);
    KeepMode = i;
}

u8 KEY_REC(u8 startadr) {
    u16 count = 2; // 录音时间长度,0.5s
    recISD(startadr); // 调用录音子程序
    while (count--) {
        Delay_025S(); // 延时
    }
    stopISD(); // 停止录音
    return 0xff;
}

u8 KEY_PLAY(u8 startadr) {
    u16 count = 2;
    playISD(startadr); // 调用录音子程序
    while (count--) {
        Delay_025S(); // 延时
    }
    return 0xff;
}

void dowmtime() {
    u8 mykey;
    char p = 3; // 允许输入分十位、分个位、秒十位、秒个位

    // 每次进入倒计时前，先把前4位清零，防止残留上次的数字
    b[0] = 0; b[1] = 0; b[2] = 0; b[3] = 0; 
    CDisplay8(b);

    // 输入部分
    while (1) {
        mykey = CGetKeyB(); 
        if (mykey == 15) {  // 按下15号键确认，退出输入
            break;
        }
        if (p >= 0) {       // 防止按键超过4次导致内存崩溃越界
            b[p] = mykey;
            CDisplay8(b);
            p--;
        }
    }

    while (1) {
        delay(54, b);

        if (b[0] == 0 && b[1] == 0 && b[2] == 0 && b[3] == 0) {
            KEY_PLAY(AD[24]); 
            break;            
        }

        if (b[0] > 0) {
            b[0]--;
        } else {
            b[0] = 9; 
            if (b[1] > 0) {
                b[1]--;
            } else {
                b[1] = 5;
                if (b[2] > 0) {
                    b[2]--;
                } else {
                    b[2] = 9; 
                    if (b[3] > 0) {
                        b[3]--;
                    }
                }
            }
        }
    }
}


void calltime() {
    u8 mykey;
    u8 p = 3;
    cDisplay8(c);
    while (1) {
        mykey = cGetKeyB();
        if (mykey == 15) {
            break;
        }
        c[p] = mykey;
        cDisplay8(c);
        p--;
    }
}

void changetime() {
    u8 pp = a[3] * 10 + a[2];
    pp += 2;
    pp %= 24;
    a[3] = pp / 10;
    a[2] = pp % 10;
}

void delay(u16 ms, u8* a) {
    while (ms--) {
        cDisplay8(a);
        kkk = cGetKeyA();
        if (kkk != 0xff) {
            if (kkk == 0x01) {
                cDisplay8(b);
                dowmtime();
            } else if (kkk == 0x02) {
                calltime();
            } else if (kkk == 0x03) {
                changetime();
            }
        }
    }
}

void showtime() {
    u8 i;
    for (i = 0; i < 10; i++) {
        a[0] += 0x80;
        delay(5, a);
        a[0] -= 0x80;
        delay(5, a);
    }
    a[0]++;
    if (a[0] == 10) {
        a[0] = 0;
        a[1]++;
        if (a[1] == 6) {
            a[1] = 0;
            a[2]++;
        }
        if (a[2] == 10 || a[2] == 4) {
            if (a[2] == 10) {
                a[2] = 0;
                a[3]++;
            } else if (a[2] == 4) {
                if (a[3] == 2) {
                    a[2] = 0;
                    a[3]++;
                }
            }
        }
        if (a[3] == 3) {
            a[3] = 0;
        }
        if (a[0] == 0 && a[1] == 0) {
            KEY_PLAY(AD[a[3] * 10 + a[2]]);
        }
    }
    if (a[0] == c[0] && a[1] == c[1] && a[2] == c[2] && a[3] == c[3]) {
        KEY_PLAY(AD[24]);
    }
}

void main() {
	
	u8 k = 0;
    // PA、PB输出，PC低四位输出，PC高四位输入
    outportb(CON_Addr, 0x81);
    
    while (k != 25) {
        if (cGetKeyB() == 0x00) {
            KEY_REC(AD[k]);
            k++;
        }
    }
    
    
    while (1) {
        showtime();
    }
}

