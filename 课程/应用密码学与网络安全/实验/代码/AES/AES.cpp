#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

typedef uint8_t byte;
typedef uint32_t word;

const int Nr = 10;  
const int Nk = 4;   

byte S_Box[16][16] = {
    { 0x63, 0x7C, 0x77, 0x7B, 0xF2, 0x6B, 0x6F, 0xC5, 0x30, 0x01, 0x67, 0x2B, 0xFE, 0xD7, 0xAB, 0x76 },
    { 0xCA, 0x82, 0xC9, 0x7D, 0xFA, 0x59, 0x47, 0xF0, 0xAD, 0xD4, 0xA2, 0xAF, 0x9C, 0xA4, 0x72, 0xC0 },
    { 0xB7, 0xFD, 0x93, 0x26, 0x36, 0x3F, 0xF7, 0xCC, 0x34, 0xA5, 0xE5, 0xF1, 0x71, 0xD8, 0x31, 0x15 },
    { 0x04, 0xC7, 0x23, 0xC3, 0x18, 0x96, 0x05, 0x9A, 0x07, 0x12, 0x80, 0xE2, 0xEB, 0x27, 0xB2, 0x75 },
    { 0x09, 0x83, 0x2C, 0x1A, 0x1B, 0x6E, 0x5A, 0xA0, 0x52, 0x3B, 0xD6, 0xB3, 0x29, 0xE3, 0x2F, 0x84 },
    { 0x53, 0xD1, 0x00, 0xED, 0x20, 0xFC, 0xB1, 0x5B, 0x6A, 0xCB, 0xBE, 0x39, 0x4A, 0x4C, 0x58, 0xCF },
    { 0xD0, 0xEF, 0xAA, 0xFB, 0x43, 0x4D, 0x33, 0x85, 0x45, 0xF9, 0x02, 0x7F, 0x50, 0x3C, 0x9F, 0xA8 },
    { 0x51, 0xA3, 0x40, 0x8F, 0x92, 0x9D, 0x38, 0xF5, 0xBC, 0xB6, 0xDA, 0x21, 0x10, 0xFF, 0xF3, 0xD2 },
    { 0xCD, 0x0C, 0x13, 0xEC, 0x5F, 0x97, 0x44, 0x17, 0xC4, 0xA7, 0x7E, 0x3D, 0x64, 0x5D, 0x19, 0x73 },
    { 0x60, 0x81, 0x4F, 0xDC, 0x22, 0x2A, 0x90, 0x88, 0x46, 0xEE, 0xB8, 0x14, 0xDE, 0x5E, 0x0B, 0xDB },
    { 0xE0, 0x32, 0x3A, 0x0A, 0x49, 0x06, 0x24, 0x5C, 0xC2, 0xD3, 0xAC, 0x62, 0x91, 0x95, 0xE4, 0x79 },
    { 0xE7, 0xC8, 0x37, 0x6D, 0x8D, 0xD5, 0x4E, 0xA9, 0x6C, 0x56, 0xF4, 0xEA, 0x65, 0x7A, 0xAE, 0x08 },
    { 0xBA, 0x78, 0x25, 0x2E, 0x1C, 0xA6, 0xB4, 0xC6, 0xE8, 0xDD, 0x74, 0x1F, 0x4B, 0xBD, 0x8B, 0x8A },
    { 0x70, 0x3E, 0xB5, 0x66, 0x48, 0x03, 0xF6, 0x0E, 0x61, 0x35, 0x57, 0xB9, 0x86, 0xC1, 0x1D, 0x9E },
    { 0xE1, 0xF8, 0x98, 0x11, 0x69, 0xD9, 0x8E, 0x94, 0x9B, 0x1E, 0x87, 0xE9, 0xCE, 0x55, 0x28, 0xDF },
    { 0x8C, 0xA1, 0x89, 0x0D, 0xBF, 0xE6, 0x42, 0x68, 0x41, 0x99, 0x2D, 0x0F, 0xB0, 0x54, 0xBB, 0x16 }
};

byte Inv_S_Box[16][16] = {
    { 0x52, 0x09, 0x6A, 0xD5, 0x30, 0x36, 0xA5, 0x38, 0xBF, 0x40, 0xA3, 0x9E, 0x81, 0xF3, 0xD7, 0xFB },
    { 0x7C, 0xE3, 0x39, 0x82, 0x9B, 0x2F, 0xFF, 0x87, 0x34, 0x8E, 0x43, 0x44, 0xC4, 0xDE, 0xE9, 0xCB },
    { 0x54, 0x7B, 0x94, 0x32, 0xA6, 0xC2, 0x23, 0x3D, 0xEE, 0x4C, 0x95, 0x0B, 0x42, 0xFA, 0xC3, 0x4E },
    { 0x08, 0x2E, 0xA1, 0x66, 0x28, 0xD9, 0x24, 0xB2, 0x76, 0x5B, 0xA2, 0x49, 0x6D, 0x8B, 0xD1, 0x25 },
    { 0x72, 0xF8, 0xF6, 0x64, 0x86, 0x68, 0x98, 0x16, 0xD4, 0xA4, 0x5C, 0xCC, 0x5D, 0x65, 0xB6, 0x92 },
    { 0x6C, 0x70, 0x48, 0x50, 0xFD, 0xED, 0xB9, 0xDA, 0x5E, 0x15, 0x46, 0x57, 0xA7, 0x8D, 0x9D, 0x84 },
    { 0x90, 0xD8, 0xAB, 0x00, 0x8C, 0xBC, 0xD3, 0x0A, 0xF7, 0xE4, 0x58, 0x05, 0xB8, 0xB3, 0x45, 0x06 },
    { 0xD0, 0x2C, 0x1E, 0x8F, 0xCA, 0x3F, 0x0F, 0x02, 0xC1, 0xAF, 0xBD, 0x03, 0x01, 0x13, 0x8A, 0x6B },
    { 0x3A, 0x91, 0x11, 0x41, 0x4F, 0x67, 0xDC, 0xEA, 0x97, 0xF2, 0xCF, 0xCE, 0xF0, 0xB4, 0xE6, 0x73 },
    { 0x96, 0xAC, 0x74, 0x22, 0xE7, 0xAD, 0x35, 0x85, 0xE2, 0xF9, 0x37, 0xE8, 0x1C, 0x75, 0xDF, 0x6E },
    { 0x47, 0xF1, 0x1A, 0x71, 0x1D, 0x29, 0xC5, 0x89, 0x6F, 0xB7, 0x62, 0x0E, 0xAA, 0x18, 0xBE, 0x1B },
    { 0xFC, 0x56, 0x3E, 0x4B, 0xC6, 0xD2, 0x79, 0x20, 0x9A, 0xDB, 0xC0, 0xFE, 0x78, 0xCD, 0x5A, 0xF4 },
    { 0x1F, 0xDD, 0xA8, 0x33, 0x88, 0x07, 0xC7, 0x31, 0xB1, 0x12, 0x10, 0x59, 0x27, 0x80, 0xEC, 0x5F },
    { 0x60, 0x51, 0x7F, 0xA9, 0x19, 0xB5, 0x4A, 0x0D, 0x2D, 0xE5, 0x7A, 0x9F, 0x93, 0xC9, 0x9C, 0xEF },
    { 0xA0, 0xE0, 0x3B, 0x4D, 0xAE, 0x2A, 0xF5, 0xB0, 0xC8, 0xEB, 0xBB, 0x3C, 0x83, 0x53, 0x99, 0x61 },
    { 0x17, 0x2B, 0x04, 0x7E, 0xBA, 0x77, 0xD6, 0x26, 0xE1, 0x69, 0x14, 0x63, 0x55, 0x21, 0x0C, 0x7D }
};

word Rcon[10] = { 0x01000000, 0x02000000, 0x04000000, 0x08000000, 0x10000000,
                  0x20000000, 0x40000000, 0x80000000, 0x1b000000, 0x36000000 };


void MatrixTranspose(byte state[16]) {
    byte temp[16];
    int i, j;
    for (i = 0; i < 4; i++) {
        for (j = 0; j < 4; j++) {
            temp[i * 4 + j] = state[j * 4 + i];
        }
    }
    for (i = 0; i < 16; i++) state[i] = temp[i];
}

void SubBytes(byte mtx[16]) {
    int i;
    for (i = 0; i < 16; ++i) mtx[i] = S_Box[(mtx[i] >> 4) & 0x0F][mtx[i] & 0x0F];
}

void ShiftRows(byte mtx[16]) {
    int i; byte temp;
    temp = mtx[4]; for (i = 0; i < 3; ++i) mtx[i + 4] = mtx[i + 5]; mtx[7] = temp;
    for (i = 0; i < 2; ++i) { temp = mtx[i + 8]; mtx[i + 8] = mtx[i + 10]; mtx[i + 10] = temp; }
    temp = mtx[15]; for (i = 3; i > 0; --i) mtx[i + 12] = mtx[i + 11]; mtx[12] = temp;
}

byte GFMul(byte a, byte b) {
    byte p = 0, hi_bit_set; int counter;
    for (counter = 0; counter < 8; counter++) {
        if ((b & 1) != 0) p ^= a;
        hi_bit_set = (a & 0x80); a <<= 1;
        if (hi_bit_set != 0) a ^= 0x1b; 
        b >>= 1;
    }
    return p;
}

void MixColumns(byte mtx[16]) {
    int i, j; byte arr[4];
    for (i = 0; i < 4; ++i) {
        for (j = 0; j < 4; ++j) arr[j] = mtx[i + j * 4];
        mtx[i]      = GFMul(0x02, arr[0]) ^ GFMul(0x03, arr[1]) ^ arr[2] ^ arr[3];
        mtx[i + 4]  = arr[0] ^ GFMul(0x02, arr[1]) ^ GFMul(0x03, arr[2]) ^ arr[3];
        mtx[i + 8]  = arr[0] ^ arr[1] ^ GFMul(0x02, arr[2]) ^ GFMul(0x03, arr[3]);
        mtx[i + 12] = GFMul(0x03, arr[0]) ^ arr[1] ^ arr[2] ^ GFMul(0x02, arr[3]);
    }
}

void AddRoundKey(byte mtx[16], word k[4]) {
    int i;
    for (i = 0; i < 4; ++i) {
        mtx[i]      ^= (k[i] >> 24) & 0xFF; mtx[i + 4]  ^= (k[i] >> 16) & 0xFF;
        mtx[i + 8]  ^= (k[i] >> 8) & 0xFF;  mtx[i + 12] ^= k[i] & 0xFF;
    }
}

void InvSubBytes(byte mtx[16]) {
    int i;
    for (i = 0; i < 16; ++i) mtx[i] = Inv_S_Box[(mtx[i] >> 4) & 0x0F][mtx[i] & 0x0F];
}

void InvShiftRows(byte mtx[16]) {
    int i; byte temp;
    temp = mtx[7]; for (i = 3; i > 0; --i) mtx[i + 4] = mtx[i + 3]; mtx[4] = temp;
    for (i = 0; i < 2; ++i) { temp = mtx[i + 8]; mtx[i + 8] = mtx[i + 10]; mtx[i + 10] = temp; }
    temp = mtx[12]; for (i = 0; i < 3; ++i) mtx[i + 12] = mtx[i + 13]; mtx[15] = temp;
}

void InvMixColumns(byte mtx[16]) {
    int i, j; byte arr[4];
    for (i = 0; i < 4; ++i) {
        for (j = 0; j < 4; ++j) arr[j] = mtx[i + j * 4];
        mtx[i]      = GFMul(0x0e, arr[0]) ^ GFMul(0x0b, arr[1]) ^ GFMul(0x0d, arr[2]) ^ GFMul(0x09, arr[3]);
        mtx[i + 4]  = GFMul(0x09, arr[0]) ^ GFMul(0x0e, arr[1]) ^ GFMul(0x0b, arr[2]) ^ GFMul(0x0d, arr[3]);
        mtx[i + 8]  = GFMul(0x0d, arr[0]) ^ GFMul(0x09, arr[1]) ^ GFMul(0x0e, arr[2]) ^ GFMul(0x0b, arr[3]);
        mtx[i + 12] = GFMul(0x0b, arr[0]) ^ GFMul(0x0d, arr[1]) ^ GFMul(0x09, arr[2]) ^ GFMul(0x0e, arr[3]);
    }
}

word Word(byte k1, byte k2, byte k3, byte k4) { return ((word)k1 << 24) | ((word)k2 << 16) | ((word)k3 << 8) | (word)k4; }
word RotWord(word rw) { return (rw << 8) | (rw >> 24); }

word SubWord(word sw) {
    int i; byte b, sb; word result = 0;
    for (i = 0; i < 4; ++i) {
        b = (sw >> (24 - i * 8)) & 0xFF;
        sb = S_Box[(b >> 4) & 0x0F][b & 0x0F];
        result |= ((word)sb << (24 - i * 8));
    }
    return result;
}

void KeyExpansion(byte key[16], word w[44]) {
    word temp_word; int i = 0;
    while (i < Nk) { w[i] = Word(key[4 * i], key[4 * i + 1], key[4 * i + 2], key[4 * i + 3]); ++i; }
    i = Nk;
    while (i < 4 * (Nr + 1)) {
        temp_word = w[i - 1]; 
        if (i % Nk == 0) w[i] = w[i - Nk] ^ SubWord(RotWord(temp_word)) ^ Rcon[i / Nk - 1];
        else w[i] = w[i - Nk] ^ temp_word;
        ++i;
    }
}

void AesEncryptBlock(byte in[16], word w[44]) {
    int i, round; word key[4];
    MatrixTranspose(in);
    for (i = 0; i < 4; ++i) key[i] = w[i];
    AddRoundKey(in, key);
    for (round = 1; round < Nr; ++round) {
        SubBytes(in); ShiftRows(in); MixColumns(in);
        for (i = 0; i < 4; ++i) key[i] = w[4 * round + i];
        AddRoundKey(in, key);
    }
    SubBytes(in); ShiftRows(in);
    for (i = 0; i < 4; ++i) key[i] = w[4 * Nr + i];
    AddRoundKey(in, key);
    MatrixTranspose(in);
}

void AesDecryptBlock(byte in[16], word w[44]) {
    int i, round; word key[4];
    MatrixTranspose(in);
    for (i = 0; i < 4; ++i) key[i] = w[4 * Nr + i];
    AddRoundKey(in, key);
    for (round = Nr - 1; round > 0; --round) {
        InvShiftRows(in); InvSubBytes(in);
        for (i = 0; i < 4; ++i) key[i] = w[4 * round + i];
        AddRoundKey(in, key);
        InvMixColumns(in);
    }
    InvShiftRows(in); InvSubBytes(in);
    for (i = 0; i < 4; ++i) key[i] = w[i];
    AddRoundKey(in, key);
    MatrixTranspose(in);
}


// 安全读取控制台字符串
void get_safe_string(char *str, int size) {
    if (fgets(str, size, stdin) != NULL) {
        str[strcspn(str, "\r\n")] = 0; 
    }
}

// 获取并验证 16 字节密钥文件
int get_key_from_file(const char* filename, byte key[16]) {
    FILE* fp = fopen(filename, "rb");
    if (!fp) {
        printf("[-] 无法打开密钥文件: %s\n", filename);
        return 0;
    }
    memset(key, 0, 16);
    size_t bytes_read = fread(key, 1, 16, fp);
    fclose(fp);
    if (bytes_read < 16) {
        printf("[!] 警告: 密钥文件不足16字节，系统已自动用0填充尾部。\n");
    }
    return 1;
}

// 加密文件 (包含 PKCS#7 填充)
void EncryptFile(const char* fin_name, const char* fout_name, byte key[16]) {
    FILE *fin = fopen(fin_name, "rb");
    FILE *fout = fopen(fout_name, "wb");
    if (!fin || !fout) {
        printf("[-] 文件打开失败，请检查路径是否正确。\n");
        if (fin) fclose(fin);
        if (fout) fclose(fout);
        return;
    }

    word w[44];
    KeyExpansion(key, w);
    byte buffer[16];
    size_t bytes_read;

    while (1) {
        bytes_read = fread(buffer, 1, 16, fin);
        if (bytes_read < 16) {
            // PKCS#7 填充
            byte pad_val = 16 - bytes_read;
            for(int i = bytes_read; i < 16; i++) {
                buffer[i] = pad_val;
            }
            AesEncryptBlock(buffer, w);
            fwrite(buffer, 1, 16, fout);
            break;
        } else {
            AesEncryptBlock(buffer, w);
            fwrite(buffer, 1, 16, fout);
        }
    }
    fclose(fin); fclose(fout);
    printf("[+] 加密成功！文件已保存为: %s\n", fout_name);
}

// 解密文件 (包含去除 PKCS#7 填充)
void DecryptFile(const char* fin_name, const char* fout_name, byte key[16]) {
    FILE *fin = fopen(fin_name, "rb");
    FILE *fout = fopen(fout_name, "wb");
    if (!fin || !fout) {
        printf("[-] 文件打开失败，请检查路径是否正确。\n");
        if (fin) fclose(fin);
        if (fout) fclose(fout);
        return;
    }

    word w[44];
    KeyExpansion(key, w);
    byte prev_buf[16], curr_buf[16];
    size_t bytes_read = fread(curr_buf, 1, 16, fin);
    
    if (bytes_read == 0) {
        printf("[-] 文件为空！\n");
        fclose(fin); fclose(fout);
        return;
    }

    while (1) {
        memcpy(prev_buf, curr_buf, 16);
        bytes_read = fread(curr_buf, 1, 16, fin);
        
        if (bytes_read == 0) {
            // prev_buf 是最后一个数据块
            AesDecryptBlock(prev_buf, w);
            byte pad_val = prev_buf[15]; // 获取填充的字节数
            if (pad_val > 16 || pad_val == 0) {
                printf("[!] 警告：解密可能失败，填充数据异常（密钥错误或文件损坏）。\n");
                pad_val = 0; // 强制不去除数据，防止报错
            }
            fwrite(prev_buf, 1, 16 - pad_val, fout);
            break;
        } else {
            // 不是最后一个数据块
            AesDecryptBlock(prev_buf, w);
            fwrite(prev_buf, 1, 16, fout);
        }
    }
    fclose(fin); fclose(fout);
    printf("[+] 解密成功！文件已保存为: %s\n", fout_name);
}

int main() {
    int choice;
    char file_in[256], file_key[256], file_out[256];
    byte key[16];

    while(1) {

        printf(" 1. 加密文件\n");
        printf(" 2. 解密文件\n");
        printf(" 3. 退出程序\n");
        
        if (scanf("%d", &choice) != 1) {
            while(getchar() != '\n'); // 清理错误输入
            continue;
        }
        while(getchar() != '\n'); // 清理缓冲区里的回车符

        if (choice == 3) break;

        if (choice == 1) {

            printf("请输入需要加密的明文文件名: ");
            get_safe_string(file_in, sizeof(file_in));
            printf("请输入包含密钥的文件名: ");
            get_safe_string(file_key, sizeof(file_key));
            printf("请输入加密后输出的文件名: ");
            get_safe_string(file_out, sizeof(file_out));

            if (get_key_from_file(file_key, key)) {
                EncryptFile(file_in, file_out, key);
            }
        } 
        else if (choice == 2) {

            printf("请输入需要解密的密文文件名: ");
            get_safe_string(file_in, sizeof(file_in));
            printf("请输入包含密钥的文件名: ");
            get_safe_string(file_key, sizeof(file_key));
            printf("请输入解密后输出的文件名: ");
            get_safe_string(file_out, sizeof(file_out));

            if (get_key_from_file(file_key, key)) {
                DecryptFile(file_in, file_out, key);
            }
        } else {
            printf("[-] 输入有误，请重新输入。\n");
        }
    }
    
    printf("程序已退出。\n");
    return 0;
}
