#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

// 安全读取控制台字符串
void get_safe_string(char *str, int size) {
    if (fgets(str, size, stdin) != NULL) {
        str[strcspn(str, "\r\n")] = 0; 
    }
}

// 判断是否为素数
int Prime(long long m) {    
    long long i, k;
    if (m < 2) return 0;
    k = sqrt(m);
    for (i = 2; i <= k; i++)
        if (m % i == 0) return 0;
    return 1;                  
}

// 判断两数是否互素
long long husu(long long x, long long y) {   
    long long t;
    while (y) {
        t = x; x = y; y = t % y;
    }
    if (x == 1) return 0; else return 1;   
}

// 快速模幂运算 (base^exp % mod)
long long modExp(long long base, long long exp, long long mod) {
    long long r = 1;
    base = base % mod;
    while (exp > 0) {
        if (exp % 2 == 1) r = (r * base) % mod; 
        base = (base * base) % mod; 
        exp = exp / 2;
    }
    return r;
}


void GenerateKeys() {
    long long p, q, n, t, e, d = 1;
    char pub_file[256], priv_file[256];


    printf("请输入两个素数 p, q (用空格隔开): ");
    while (1) {
        if (scanf("%lld %lld", &p, &q) != 2) {
            while(getchar() != '\n'); continue;
        }
        if (Prime(p) && Prime(q) && (p * q > 255)) {  
            n = p * q;
            break;
        } else {
            printf("[-] 错误！必须是素数，且 p*q 必须大于255。请重试: ");
        }
    }
    
    t = (p - 1) * (q - 1);      
    printf("[+] 欧拉函数 φ(n) = %lld\n", t);
    printf("请输入公钥 e (1 < e < %lld，且与 %lld 互质): ", t, t);
    
    while (1) {
        scanf("%lld", &e);
        if (e > 1 && e < t && husu(e, t) == 0) break;
        printf("[-] e 不符合要求！请重新输入: ");
    }

    while ((e * d) % t != 1) d++;     
    while(getchar() != '\n'); // 清理缓冲区

    printf("请输入要保存的公钥文件名: ");
    get_safe_string(pub_file, sizeof(pub_file));
    FILE *fpub = fopen(pub_file, "w");
    fprintf(fpub, "%lld %lld", e, n);
    fclose(fpub);

    printf("请输入要保存的私钥文件名: ");
    get_safe_string(priv_file, sizeof(priv_file));
    FILE *fpriv = fopen(priv_file, "w");
    fprintf(fpriv, "%lld %lld", d, n);
    fclose(fpriv);

    printf("[+] 密钥生成完毕！\n");
    printf("公钥(e, n) 已保存至: %s\n", pub_file);
    printf("私钥(d, n) 已保存至: %s\n", priv_file);
}


void EncryptFile() {
    char key_file[256], in_file[256], out_file[256];
    long long exp, mod;

    printf("请输入密钥文件名: ");
    get_safe_string(key_file, sizeof(key_file));
    
    FILE *fk = fopen(key_file, "r");
    if (!fk) { printf("[-] 无法打开密钥文件！\n"); return; }
    fscanf(fk, "%lld %lld", &exp, &mod);
    fclose(fk);

    printf("请输入需要加密的明文文件名: ");
    get_safe_string(in_file, sizeof(in_file));
    printf("请输入加密后输出的密文文件名: ");
    get_safe_string(out_file, sizeof(out_file));

    FILE *fin = fopen(in_file, "rb");
    FILE *fout = fopen(out_file, "w"); // 密文存为可读的文本数字序列
    if (!fin || !fout) {
        printf("[-] 读写文件打开失败！\n");
        if(fin) fclose(fin); if(fout) fclose(fout);
        return;
    }

    int ch;
    while ((ch = fgetc(fin)) != EOF) {
        long long cipher = modExp((long long)ch, exp, mod);
        fprintf(fout, "%lld ", cipher); // 密文用空格隔开
    }

    fclose(fin); fclose(fout);
    printf("[+] RSA 处理成功！结果已写入: %s\n", out_file);
}


void DecryptFile() {
    char key_file[256], in_file[256], out_file[256];
    long long exp, mod;


    printf("请输入密钥文件名: ");
    get_safe_string(key_file, sizeof(key_file));
    
    FILE *fk = fopen(key_file, "r");
    if (!fk) { printf("[-] 无法打开密钥文件！\n"); return; }
    fscanf(fk, "%lld %lld", &exp, &mod);
    fclose(fk);

    printf("请输入需要解密的密文文件名: ");
    get_safe_string(in_file, sizeof(in_file));
    printf("请输入解密后输出的明文文件名: ");
    get_safe_string(out_file, sizeof(out_file));

    FILE *fin = fopen(in_file, "r"); // 密文是文本格式的数字
    FILE *fout = fopen(out_file, "wb");
    if (!fin || !fout) {
        printf("[-] 读写文件打开失败！\n");
        if(fin) fclose(fin); if(fout) fclose(fout);
        return;
    }

    long long cipher;
    while (fscanf(fin, "%lld", &cipher) == 1) {
        long long plain = modExp(cipher, exp, mod);
        fputc((char)plain, fout); // 还原为字符
    }

    fclose(fin); fclose(fout);
    printf("[+] RSA 处理成功！结果已写入: %s\n", out_file);
}


int main() {
    int choice;
    while(1) {

        printf(" 1. 生成 RSA 公私钥对文件\n");
        printf(" 2. 使用密钥加密\n");
        printf(" 3. 使用密钥解密\n");
        printf(" 4. 退出程序\n");

        
        if (scanf("%d", &choice) != 1) {
            while(getchar() != '\n'); continue;
        }
        while(getchar() != '\n'); 

        switch(choice) {
            case 1: GenerateKeys(); break;
            case 2: EncryptFile(); break;
            case 3: DecryptFile(); break;
            case 4: printf("程序已退出。\n"); system("pause"); return 0;
            default: printf("[-] 输入有误，请重新输入。\n");
        }
    }
}
