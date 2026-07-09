import sqlite3
import tkinter as tk
from tkinter import ttk, messagebox
from datetime import datetime


# ====================
# 1. 数据库后端逻辑 (Backend)
# ====================

class Database:
    def __init__(self, db_file="bus_data.db"):
        self.conn = sqlite3.connect(db_file)
        self.cur = self.conn.cursor()
        self.init_db()

    def init_db(self):
        """初始化数据库结构，创建表和视图"""
        # 开启外键支持
        self.cur.execute("PRAGMA foreign_keys = ON;")

        # 1. 车队表
        self.cur.execute("""
                         CREATE TABLE IF NOT EXISTS Team
                         (
                             team_id
                             INTEGER
                             PRIMARY
                             KEY,
                             team_name
                             TEXT
                             NOT
                             NULL
                         )
                         """)

        # 2. 线路表
        self.cur.execute("""
                         CREATE TABLE IF NOT EXISTS Route
                         (
                             route_id
                             INTEGER
                             PRIMARY
                             KEY,
                             team_id
                             INTEGER,
                             FOREIGN
                             KEY
                         (
                             team_id
                         ) REFERENCES Team
                         (
                             team_id
                         )
                             )
                         """)

        # 3. 车辆表
        self.cur.execute("""
                         CREATE TABLE IF NOT EXISTS Bus
                         (
                             plate_num
                             TEXT
                             PRIMARY
                             KEY,
                             seats
                             INTEGER,
                             route_id
                             INTEGER,
                             FOREIGN
                             KEY
                         (
                             route_id
                         ) REFERENCES Route
                         (
                             route_id
                         )
                             )
                         """)

        # 4. 员工表 (司机/队长)
        self.cur.execute("""
                         CREATE TABLE IF NOT EXISTS Driver
                         (
                             emp_id
                             TEXT
                             PRIMARY
                             KEY,
                             name
                             TEXT
                             NOT
                             NULL,
                             gender
                             TEXT
                             CHECK (
                             gender
                             IN
                         (
                             '男',
                             '女'
                         )),
                             role TEXT,
                             route_id INTEGER,
                             FOREIGN KEY
                         (
                             route_id
                         ) REFERENCES Route
                         (
                             route_id
                         )
                             )
                         """)

        # 5. 违章记录表
        self.cur.execute("""
                         CREATE TABLE IF NOT EXISTS Violation
                         (
                             v_id
                             INTEGER
                             PRIMARY
                             KEY
                             AUTOINCREMENT,
                             emp_id
                             TEXT,
                             plate_num
                             TEXT,
                             v_type
                             TEXT,
                             v_time
                             TEXT,
                             location
                             TEXT,
                             FOREIGN
                             KEY
                         (
                             emp_id
                         ) REFERENCES Driver
                         (
                             emp_id
                         ),
                             FOREIGN KEY
                         (
                             plate_num
                         ) REFERENCES Bus
                         (
                             plate_num
                         )
                             )
                         """)

        # 创建索引优化查询
        self.cur.execute("CREATE INDEX IF NOT EXISTS idx_v_time ON Violation(v_time);")

        # 预制一些基础数据（防止空库无法演示）
        self.preload_data()
        self.conn.commit()

    def preload_data(self):
        """预插入一些测试数据"""
        # 检查是否已有数据，无则插入
        self.cur.execute("SELECT count(*) FROM Team")
        if self.cur.fetchone()[0] == 0:
            self.cur.execute("INSERT INTO Team VALUES (1, '一车队'), (2, '二车队')")
            self.cur.execute("INSERT INTO Route VALUES (101, 1), (102, 1), (201, 2)")
            self.cur.execute("INSERT INTO Bus VALUES ('京A88888', 45, 101), ('京A12345', 30, 201)")
            self.cur.execute("INSERT INTO Driver VALUES ('D001', '张三', '男', '司机', 101)")
            self.cur.execute("INSERT INTO Driver VALUES ('D002', '李四', '女', '路队长', 201)")
            print("初始化测试数据完成。")

    def add_driver(self, emp_id, name, gender, role, route_id):
        try:
            self.cur.execute("INSERT INTO Driver VALUES (?, ?, ?, ?, ?)",
                             (emp_id, name, gender, role, route_id))
            self.conn.commit()
            return True, "添加成功"
        except sqlite3.IntegrityError as e:
            return False, f"添加失败: {e}"

    def add_bus(self, plate, seats, route_id):
        try:
            self.cur.execute("INSERT INTO Bus VALUES (?, ?, ?)", (plate, seats, route_id))
            self.conn.commit()
            return True, "添加成功"
        except sqlite3.Error as e:
            return False, str(e)

    def add_violation(self, emp_id, plate, v_type, v_time, location):
        try:
            self.cur.execute(
                "INSERT INTO Violation (emp_id, plate_num, v_type, v_time, location) VALUES (?, ?, ?, ?, ?)",
                (emp_id, plate, v_type, v_time, location))
            self.conn.commit()
            return True, "录入成功"
        except sqlite3.Error as e:
            return False, str(e)

    def query_drivers_by_team(self, team_id):
        # 多表连接查询：车队 -> 线路 -> 司机
        sql = """
              SELECT d.emp_id, d.name, d.gender, d.role, r.route_id, t.team_name
              FROM Driver d
                       JOIN Route r ON d.route_id = r.route_id
                       JOIN Team t ON r.team_id = t.team_id
              WHERE t.team_id = ? \
              """
        self.cur.execute(sql, (team_id,))
        return self.cur.fetchall()

    def query_violation_by_driver(self, emp_id, start_date, end_date):
        sql = """
              SELECT v.v_time, v.v_type, v.location, v.plate_num
              FROM Violation v
              WHERE v.emp_id = ? \
                AND v.v_time BETWEEN ? AND ?
              ORDER BY v.v_time DESC \
              """
        self.cur.execute(sql, (emp_id, start_date, end_date))
        return self.cur.fetchall()

    def stats_violation_by_team(self, team_id, start_date, end_date):
        # 统计查询
        sql = """
              SELECT v.v_type, COUNT(*)
              FROM Violation v
                       JOIN Driver d ON v.emp_id = d.emp_id
                       JOIN Route r ON d.route_id = r.route_id
              WHERE r.team_id = ? \
                AND v.v_time BETWEEN ? AND ?
              GROUP BY v.v_type \
              """
        self.cur.execute(sql, (team_id, start_date, end_date))
        return self.cur.fetchall()

    def __del__(self):
        self.conn.close()


# ====================
# 2. 前端界面 (Frontend - Tkinter)
# ====================

class App:
    def __init__(self, root):
        self.db = Database()
        self.root = root
        self.root.title("公交安全管理系统")
        self.root.geometry("800x600")

        # 选项卡控件
        self.notebook = ttk.Notebook(root)
        self.notebook.pack(expand=True, fill='both')

        # 创建各个页面
        self.create_input_tab()
        self.create_query_tab()
        self.create_stats_tab()

    def create_input_tab(self):
        frame = ttk.Frame(self.notebook)
        self.notebook.add(frame, text="数据录入")

        # --- 区域1: 录入司机 ---
        lf1 = ttk.LabelFrame(frame, text="录入司机信息")
        lf1.pack(pady=10, padx=10, fill="x")

        ttk.Label(lf1, text="工号:").grid(row=0, column=0, padx=5)
        self.e_uid = ttk.Entry(lf1)
        self.e_uid.grid(row=0, column=1)

        ttk.Label(lf1, text="姓名:").grid(row=0, column=2, padx=5)
        self.e_name = ttk.Entry(lf1)
        self.e_name.grid(row=0, column=3)

        ttk.Label(lf1, text="性别:").grid(row=0, column=4, padx=5)
        self.e_gender = ttk.Combobox(lf1, values=["男", "女"], width=5)
        self.e_gender.grid(row=0, column=5)

        ttk.Label(lf1, text="线路ID:").grid(row=1, column=0, padx=5)
        self.e_route = ttk.Entry(lf1)
        self.e_route.grid(row=1, column=1)

        btn_add_driver = ttk.Button(lf1, text="添加司机", command=self.action_add_driver)
        btn_add_driver.grid(row=1, column=4, columnspan=2, pady=5)

        # --- 区域2: 录入违章 ---
        lf2 = ttk.LabelFrame(frame, text="录入违章信息")
        lf2.pack(pady=10, padx=10, fill="x")

        ttk.Label(lf2, text="司机工号:").grid(row=0, column=0)
        self.v_uid = ttk.Entry(lf2)
        self.v_uid.grid(row=0, column=1)

        ttk.Label(lf2, text="车牌号:").grid(row=0, column=2)
        self.v_plate = ttk.Entry(lf2)
        self.v_plate.grid(row=0, column=3)

        ttk.Label(lf2, text="违章类型:").grid(row=1, column=0)
        self.v_type = ttk.Combobox(lf2, values=["闯红灯", "未礼让斑马线", "压线", "违章停车"])
        self.v_type.grid(row=1, column=1)

        ttk.Label(lf2, text="时间(Y-M-D):").grid(row=1, column=2)
        self.v_time = ttk.Entry(lf2)
        self.v_time.insert(0, datetime.now().strftime("%Y-%m-%d"))  # 默认当天
        self.v_time.grid(row=1, column=3)

        btn_add_v = ttk.Button(lf2, text="提交违章", command=self.action_add_violation)
        btn_add_v.grid(row=2, column=1, pady=10)

    def create_query_tab(self):
        frame = ttk.Frame(self.notebook)
        self.notebook.add(frame, text="查询功能")

        # 查询车队司机
        lf1 = ttk.LabelFrame(frame, text="查询车队下的司机")
        lf1.pack(fill="x", padx=10, pady=5)

        ttk.Label(lf1, text="车队ID (1, 2...):").pack(side="left", padx=5)
        self.q_team_id = ttk.Entry(lf1, width=5)
        self.q_team_id.pack(side="left")
        ttk.Button(lf1, text="查询", command=self.action_query_team).pack(side="left", padx=10)

        self.tree_driver = ttk.Treeview(frame, columns=("ID", "Name", "Gender", "Role", "Route"), show="headings",
                                        height=5)
        self.tree_driver.heading("ID", text="工号")
        self.tree_driver.heading("Name", text="姓名")
        self.tree_driver.heading("Gender", text="性别")
        self.tree_driver.heading("Role", text="职位")
        self.tree_driver.heading("Route", text="线路")
        self.tree_driver.pack(fill="x", padx=10)

        # 查询个人违章
        lf2 = ttk.LabelFrame(frame, text="查询司机违章明细")
        lf2.pack(fill="x", padx=10, pady=5)
        ttk.Label(lf2, text="工号:").pack(side="left")
        self.q_v_uid = ttk.Entry(lf2, width=10)
        self.q_v_uid.pack(side="left")
        ttk.Button(lf2, text="查询 (本月)", command=self.action_query_driver_v).pack(side="left", padx=10)

        self.tree_v = ttk.Treeview(frame, columns=("Time", "Type", "Loc", "Plate"), show="headings", height=5)
        self.tree_v.heading("Time", text="时间")
        self.tree_v.heading("Type", text="违章类型")
        self.tree_v.heading("Loc", text="地点")
        self.tree_v.heading("Plate", text="车牌")
        self.tree_v.pack(fill="x", padx=10)

    def create_stats_tab(self):
        frame = ttk.Frame(self.notebook)
        self.notebook.add(frame, text="统计报表")

        lf = ttk.LabelFrame(frame, text="车队违章统计")
        lf.pack(pady=10)

        ttk.Label(lf, text="车队ID:").grid(row=0, column=0)
        self.s_team = ttk.Entry(lf, width=5)
        self.s_team.grid(row=0, column=1)

        ttk.Button(lf, text="生成统计", command=self.action_stats).grid(row=0, column=2, padx=10)

        self.txt_stats = tk.Text(frame, height=10)
        self.txt_stats.pack(padx=10, pady=10, fill="both")

    # --- 事件处理函数 ---

    def action_add_driver(self):
        # 简单获取数据，实际需更严格校验
        success, msg = self.db.add_driver(self.e_uid.get(), self.e_name.get(),
                                          self.e_gender.get(), "司机", self.e_route.get())
        messagebox.showinfo("结果", msg)

    def action_add_violation(self):
        success, msg = self.db.add_violation(self.v_uid.get(), self.v_plate.get(),
                                             self.v_type.get(), self.v_time.get(), "市区道路")
        messagebox.showinfo("结果", msg)

    def action_query_team(self):
        # 清空表格
        for row in self.tree_driver.get_children():
            self.tree_driver.delete(row)

        tid = self.q_team_id.get()
        if not tid: return
        res = self.db.query_drivers_by_team(tid)
        for r in res:
            self.tree_driver.insert("", "end", values=r)

    def action_query_driver_v(self):
        for row in self.tree_v.get_children():
            self.tree_v.delete(row)

        uid = self.q_v_uid.get()
        # 简化处理，默认查询 2020年到2030年
        res = self.db.query_violation_by_driver(uid, "2020-01-01", "2030-12-31")
        for r in res:
            self.tree_v.insert("", "end", values=r)

    def action_stats(self):
        tid = self.s_team.get()
        if not tid: return
        res = self.db.stats_violation_by_team(tid, "2020-01-01", "2030-12-31")

        self.txt_stats.delete(1.0, "end")
        self.txt_stats.insert("end", f"车队 {tid} 违章统计 (2020-2030):\n")
        self.txt_stats.insert("end", "-" * 30 + "\n")
        if not res:
            self.txt_stats.insert("end", "无记录")
        for r in res:
            self.txt_stats.insert("end", f"类型: {r[0]} \t 次数: {r[1]}\n")


if __name__ == "__main__":
    root = tk.Tk()
    app = App(root)
    root.mainloop()