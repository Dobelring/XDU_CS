# -*- coding: utf-8 -*-
"""
====================================================================
 题目：距离测控仿真系统 —— PC 上位机软件
 学生：郑墨涵    学号：23009201247
--------------------------------------------------------------------
 功能：
  1. 串口打开/关闭功能（与 VSPD 虚拟串口、Proteus COMPIM 对接）；
  2. 发送窗口：向 Arduino 发送学号并显示已发送内容；
  3. 接收窗口：显示 Arduino 返回的应答(OK:ID=xxx)与实时距离值(DIST:xx.x)；
  4. 实时显示当前距离、距离阈值(30+学号末位)与电机运行状态。
 运行环境：Python 3.x + pyserial（pip install pyserial）
====================================================================
"""
import serial
import serial.tools.list_ports
import threading
import queue
import datetime
import tkinter as tk
from tkinter import ttk, messagebox

STUDENT_ID = "23009201247"
STUDENT_NAME = "郑墨涵"
BAUD = 9600


class HostApp:
    def __init__(self, root: tk.Tk):
        self.root = root
        self.ser = None
        self.rx_thread = None
        self.rx_queue = queue.Queue()
        self.rx_stop = threading.Event()
        self.sent_id = ""

        root.title(f"{STUDENT_ID} {STUDENT_NAME} - 距离测控仿真系统上位机")
        root.geometry("860x600")
        root.minsize(760, 520)
        self._build_ui()
        self._refresh_ports()
        self.root.after(80, self._poll_rx_queue)

    # ---------------- UI ----------------
    def _build_ui(self):
        style = ttk.Style(self.root)
        try:
            style.theme_use("vista")
        except tk.TclError:
            pass

        top = ttk.Frame(self.root, padding=(8, 6))
        top.pack(side=tk.TOP, fill=tk.X)
        ttk.Label(top, text="串口:").pack(side=tk.LEFT)
        self.port_var = tk.StringVar()
        self.port_combo = ttk.Combobox(top, textvariable=self.port_var,
                                       width=10, state="readonly")
        self.port_combo.pack(side=tk.LEFT, padx=(2, 8))
        ttk.Button(top, text="刷新", width=6,
                   command=self._refresh_ports).pack(side=tk.LEFT)
        ttk.Label(top, text="波特率:").pack(side=tk.LEFT, padx=(10, 0))
        self.baud_var = tk.StringVar(value=str(BAUD))
        ttk.Combobox(top, textvariable=self.baud_var, width=8,
                     values=["9600", "19200", "38400", "57600", "115200"],
                     state="readonly").pack(side=tk.LEFT, padx=(2, 10))
        self.btn_open = ttk.Button(top, text="打开串口", command=self._open_port)
        self.btn_open.pack(side=tk.LEFT, padx=4)
        self.btn_close = ttk.Button(top, text="关闭串口", command=self._close_port,
                                    state=tk.DISABLED)
        self.btn_close.pack(side=tk.LEFT, padx=4)
        self.status_var = tk.StringVar(value="● 串口已关闭")
        self.status_label = tk.Label(top, textvariable=self.status_var, fg="gray",
                                     font=("Microsoft YaHei", 10, "bold"))
        self.status_label.pack(side=tk.LEFT, padx=12)

        body = ttk.Frame(self.root, padding=(8, 2))
        body.pack(fill=tk.BOTH, expand=True)

        # ---- 发送窗口 ----
        send_box = ttk.LabelFrame(body, text=" 发送窗口（发送学生学号） ", padding=6)
        send_box.pack(side=tk.LEFT, fill=tk.BOTH, expand=True, padx=(0, 6))
        row = ttk.Frame(send_box)
        row.pack(fill=tk.X)
        ttk.Label(row, text="学号:").pack(side=tk.LEFT)
        self.id_var = tk.StringVar(value=STUDENT_ID)
        self.id_entry = ttk.Entry(row, textvariable=self.id_var, width=18)
        self.id_entry.pack(side=tk.LEFT, padx=6)
        self.btn_send = ttk.Button(row, text="发送学号", command=self._send_id,
                                   state=tk.DISABLED)
        self.btn_send.pack(side=tk.LEFT)
        self.send_log = tk.Text(send_box, height=12, width=34, state=tk.DISABLED,
                                font=("Consolas", 11), bg="#FBFBF0")
        self.send_log.pack(fill=tk.BOTH, expand=True, pady=(6, 0))

        # ---- 接收窗口 ----
        recv_box = ttk.LabelFrame(body, text=" 接收窗口（接收距离值） ", padding=6)
        recv_box.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        self.recv_log = tk.Text(recv_box, height=16, state=tk.DISABLED,
                                font=("Consolas", 11), bg="#F0FBF4")
        self.recv_log.pack(fill=tk.BOTH, expand=True)
        recv_row = ttk.Frame(recv_box)
        recv_row.pack(fill=tk.X, pady=(6, 0))
        ttk.Button(recv_row, text="清空接收区",
                   command=self._clear_recv).pack(side=tk.RIGHT)

        # ---- 底部状态栏 ----
        bottom = ttk.LabelFrame(self.root, text=" 实时状态 ", padding=(8, 4))
        bottom.pack(side=tk.BOTTOM, fill=tk.X, padx=8, pady=(0, 8))
        self.dist_var = tk.StringVar(value="--.-")
        self.thr_var = tk.StringVar(value="--")
        self.motor_var = tk.StringVar(value="—")
        ttk.Label(bottom, text="当前距离:").pack(side=tk.LEFT)
        tk.Label(bottom, textvariable=self.dist_var, fg="#0066CC",
                 font=("Consolas", 14, "bold")).pack(side=tk.LEFT, padx=(4, 0))
        ttk.Label(bottom, text="cm").pack(side=tk.LEFT, padx=(2, 16))
        ttk.Label(bottom, text="距离阈值:").pack(side=tk.LEFT)
        tk.Label(bottom, textvariable=self.thr_var, fg="#333333",
                 font=("Consolas", 14, "bold")).pack(side=tk.LEFT, padx=(4, 0))
        ttk.Label(bottom, text="cm").pack(side=tk.LEFT, padx=(2, 16))
        ttk.Label(bottom, text="直流电机:").pack(side=tk.LEFT)
        self.motor_label = tk.Label(bottom, textvariable=self.motor_var,
                                    font=("Microsoft YaHei", 12, "bold"))
        self.motor_label.pack(side=tk.LEFT, padx=6)

    # ---------------- 串口 ----------------
    def _refresh_ports(self):
        ports = [p.device for p in serial.tools.list_ports.comports()]
        self.port_combo["values"] = ports
        if ports and not self.port_var.get():
            self.port_var.set(ports[0])

    def _open_port(self):
        port = self.port_var.get()
        if not port:
            messagebox.showwarning("提示", "请先选择串口！")
            return
        try:
            self.ser = serial.Serial(port, int(self.baud_var.get()),
                                     timeout=0.2)
        except serial.SerialException as e:
            messagebox.showerror("串口错误", f"无法打开 {port}:\n{e}")
            self.ser = None
            return
        self.rx_stop.clear()
        self.rx_thread = threading.Thread(target=self._reader, daemon=True)
        self.rx_thread.start()
        self.btn_open["state"] = tk.DISABLED
        self.btn_close["state"] = tk.NORMAL
        self.btn_send["state"] = tk.NORMAL
        self.status_var.set(f"● 串口已打开 {port} @{self.baud_var.get()}")
        self.status_label.config(fg="green")

    def _close_port(self):
        self.rx_stop.set()
        if self.rx_thread:
            self.rx_thread.join(timeout=1)
        if self.ser and self.ser.is_open:
            self.ser.close()
        self.ser = None
        self.btn_open["state"] = tk.NORMAL
        self.btn_close["state"] = tk.DISABLED
        self.btn_send["state"] = tk.DISABLED
        self.status_var.set("● 串口已关闭")
        self.status_label.config(fg="gray")

    # ---------------- 发送/接收 ----------------
    def _send_id(self):
        if not (self.ser and self.ser.is_open):
            messagebox.showwarning("提示", "请先打开串口！")
            return
        sid = self.id_var.get().strip()
        if not sid.isdigit():
            messagebox.showwarning("提示", "学号必须为数字！")
            return
        self.ser.write((sid + "\n").encode("ascii"))
        self.sent_id = sid
        self._log(self.send_log, f"→ 已发送学号: {sid}")
        thr = 30 + int(sid[-1])
        self.thr_var.set(str(thr))
        self._append_recv(f"[本地] 已发送学号 {sid}，阈值={thr}cm，等待距离数据…")

    def _reader(self):
        buf = b""
        while not self.rx_stop.is_set():
            try:
                data = self.ser.read(128)
            except serial.SerialException:
                break
            if data:
                buf += data
                while b"\n" in buf:
                    line, buf = buf.split(b"\n", 1)
                    text = line.decode("ascii", "replace").strip()
                    if text:
                        self.rx_queue.put(text)

    def _poll_rx_queue(self):
        try:
            while True:
                text = self.rx_queue.get_nowait()
                self._append_recv(f"← {text}")
                if text.startswith("DIST:"):
                    try:
                        dist = float(text[5:].strip())
                        self.dist_var.set(f"{dist:.1f}")
                        if self.sent_id:
                            thr = 30 + int(self.sent_id[-1])
                            if dist > thr:
                                self.motor_var.set("运转中 ▶▶")
                                self.motor_label.config(fg="#CC2200")
                            else:
                                self.motor_var.set("停止 ■")
                                self.motor_label.config(fg="#007700")
                    except ValueError:
                        pass
        except queue.Empty:
            pass
        self.root.after(80, self._poll_rx_queue)

    # ---------------- 工具 ----------------
    def _log(self, widget: tk.Text, msg: str):
        widget.config(state=tk.NORMAL)
        widget.insert(tk.END, msg + "\n")
        widget.see(tk.END)
        widget.config(state=tk.DISABLED)

    def _append_recv(self, msg: str):
        ts = datetime.datetime.now().strftime("%H:%M:%S")
        self._log(self.recv_log, f"[{ts}] {msg}")

    def _clear_recv(self):
        self.recv_log.config(state=tk.NORMAL)
        self.recv_log.delete("1.0", tk.END)
        self.recv_log.config(state=tk.DISABLED)


def main():
    root = tk.Tk()
    HostApp(root)
    root.mainloop()


if __name__ == "__main__":
    main()
