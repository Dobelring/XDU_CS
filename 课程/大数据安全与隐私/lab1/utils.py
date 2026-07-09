import socket
import sys
import threading
import time
import random
from pathlib import Path
from hashlib import sha256
from Crypto.Cipher import AES
from Crypto.Util.Padding import pad, unpad
from loguru import logger


logger.remove()

logger_id = logger.add(
    sys.stdout,
    level=0,
    diagnose=False,
)

def recv_exact(sock: socket.socket, length: int) -> bytes:
    """确保从 socket 中接收精确长度的字节流"""
    data = b''
    while len(data) < length:
        packet = sock.recv(length - len(data))
        if not packet:
            break
        data += packet
    return data


def dh_key_exchange(sock: socket.socket, prime: int, base: int) -> bytes:
    """DH 密钥交换"""
    private_key = random.randint(2, prime - 2)
    public_key = pow(base, private_key, prime)
    sock.sendall(str(public_key).encode())
    peer_public_key = int(sock.recv(1024).decode())
    shared_secret = pow(peer_public_key, private_key, prime)
    return sha256(str(shared_secret).encode()).digest()


def encrypt_data(data: bytes, key: bytes) -> bytes:
    """加密数据
    返回(时间戳, 随机数, iv, 加密数据)
    """
    timestamp = int(time.time()).to_bytes(8, "big")
    random_nonce = random.randint(0, 2**64 - 1).to_bytes(8, "big")
    iv = sha256(timestamp + random_nonce).digest()[:16]
    cipher = AES.new(key, AES.MODE_CBC, iv)
    encrypted_data = cipher.encrypt(pad(data, AES.block_size))
    return timestamp + random_nonce + iv + encrypted_data


def decrypt_data(data: bytes, key: bytes) -> bytes:
    """解密数据"""
    timestamp, random_nonce, iv, encrypted_data = (
        data[:8],
        data[8:16],
        data[16:32],
        data[32:],
    )
    cipher = AES.new(key, AES.MODE_CBC, iv)
    return unpad(cipher.decrypt(encrypted_data), AES.block_size)


def send_file(sock: socket.socket, filepath: Path, key) -> None:
    """发送文件 filepath 到已经连接的 socket"""
    with open(str(filepath), "rb") as f:
        while chunk := f.read(1024):
            encrypted_chunk = encrypt_data(chunk, key)
            sock.sendall(len(encrypted_chunk).to_bytes(4, "big") + encrypted_chunk)
    sock.sendall(int(0).to_bytes(4, "big"))


def receive_file(sock: socket.socket, save_path: str, key) -> None:
    """接受文件 并保存到 save_path"""
    with open(save_path, "wb") as f:
        while True:
            chunk_size = sock.recv(4)
            if not chunk_size:
                break
            chunk_size = int.from_bytes(chunk_size, "big")
            if chunk_size == 0:
                break
            encrypted_chunk = recv_exact(sock, chunk_size)
            logger.debug(f"本轮接受块密文：{encrypted_chunk}")
            decrypted_chunk = decrypt_data(encrypted_chunk, key)
            logger.debug(f"本轮接受块明文：{decrypted_chunk}")
            f.write(decrypted_chunk)


def server_task(conn: socket.socket) -> None:
    """服务函数"""
    # 使用 1024 位的大素数
    prime = int("FFFFFFFFFFFFFFFFC90FDAA22168C234C4C6628B80DC1CD1"
                "29024E088A67CC74020BBEA63B139B22514A08798E3404DD"
                "EF9519B3CD3A431B302B0A6DF25F14374FE1356D6D51C245"
                "E485B576625E7EC6F44C42E9A637ED6B0BFF5CB6F406B7ED"
                "EE386BFB5A899FA5AE9F24117C4B1FE649286651ECE45B3D"
                "C2007CB8A163BF0598DA48361C55D39A69163FA8FD24CF5F"
                "83655D23DCA3AD961C62F356208552BB9ED529077096966D"
                "670C354E4ABC9804F1746C08CA18217C32905E462E36CE3B"
                "E39E772C180E86039B2783A2EC07A28FB5C55DF06F4C52C9"
                "DE2BCBF6955817183995497CEA956AE515D2261898FA0510"
                "15728E5A8AACAA68FFFFFFFFFFFFFFFF", 16)
    base = 2
    key = dh_key_exchange(conn, prime, base)
    logger.info(f"密钥交换成功！key={key}")
    while True:
        filename = conn.recv(1024).decode()
        if not filename:
            break
        receive_file(conn, f"received_{filename}", key)
    conn.close()


def server():
    """服务端入口"""
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        logger.info("开始启动服务端...")
        s.bind(("0.0.0.0", 12345))
        s.listen()
        logger.info("服务端开始监听 0.0.0.0:12345")
        while True:
            try:
                conn, addr = s.accept()
                logger.info(f"接受客户端连接：connect={conn}; address={addr}")
                threading.Thread(target=server_task, args=(conn,)).start()
            except Exception as e:
                logger.error(f"发生异常！{e}")


def client(filepath: str, host: str = "127.0.0.1", port: int = 12345) -> None:
    """客户端入口"""
    filepath = Path(filepath)
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.connect((host, port))
        # 使用 1024 位的大素数
        prime = int("FFFFFFFFFFFFFFFFC90FDAA22168C234C4C6628B80DC1CD1"
                    "29024E088A67CC74020BBEA63B139B22514A08798E3404DD"
                    "EF9519B3CD3A431B302B0A6DF25F14374FE1356D6D51C245"
                    "E485B576625E7EC6F44C42E9A637ED6B0BFF5CB6F406B7ED"
                    "EE386BFB5A899FA5AE9F24117C4B1FE649286651ECE45B3D"
                    "C2007CB8A163BF0598DA48361C55D39A69163FA8FD24CF5F"
                    "83655D23DCA3AD961C62F356208552BB9ED529077096966D"
                    "670C354E4ABC9804F1746C08CA18217C32905E462E36CE3B"
                    "E39E772C180E86039B2783A2EC07A28FB5C55DF06F4C52C9"
                    "DE2BCBF6955817183995497CEA956AE515D2261898FA0510"
                    "15728E5A8AACAA68FFFFFFFFFFFFFFFF", 16)
        base = 2
        key = dh_key_exchange(s, prime, base)
        logger.info(f"密钥交换：key={key}")
        s.sendall(filepath.name.encode())
        send_file(s, filepath, key)
        s.close()
