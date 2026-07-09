# 文件安全传输流程

**RSA**

A：选择 p=61，q=53，e=17 

得到公钥（e，n）=（17，3233） 

私钥（d，n）=（2753，3233）

B: 选择 p=47，q=59，e=63 

得到公钥（e，n）=（63，2773） 

私钥（d，n）=（847，2773）

**明文**: zhengmohan2303013

**AES 秘钥**: 12345678KJNMLSDG

**加密过程(A)**:

**AES 密文**: 胺 肓?l?忩褰'↑vl+&钱?T?

**用 B 的公钥对 AES 秘钥进行 RSA 加密**：

RSA_AES_miyao : 1775 895 685 1542 307 946 1395 2589 1149 2405 164 2689 2441 1518 2409 2743  

**对明文计算 MD5 摘要**：

MD5_miwen: f6ea0c4a95a54f2fd7ccac9b3c062c55

**A 的私钥对 MD5_miwen 加密**：

RSA_MD5_miwen: 967 3128 32 2750 2576 333 1589 2750 2584 3074 2750 3074 1589 967 3039 967 415 26 333 333 2750 333 2584 709 1776 333 2576 3128 3039 333 3074 3074 2487 2189

**最后把加密生成的文件 AES_miwen.txt、RSA_AES_miyao.txt、
RSA_MD5_miwen.txt 打包发给终端 B**


**解密过程(B)**:

终端 B 的私钥对 RSA_AES_miyao.txt 进行 RSA 解密, 得到:AES_miyao

对 AES_miwen 解密，得到明文 AES_mingwen.txt

用 MD5 算法对所得明文 AES_mingwen.txt 进行加密生成解密后的明文摘要。得到： AES_mingwen_MD5.txt

RSA 算法用终端 A 的公钥对 RSA_MD5_miwen.txt 进行解密，得到:
RSA_MD5_mingwen.txt

比较 RSA_MD5_mingwen.txt 和 AES_mingwen_MD5.txt 是否相同

