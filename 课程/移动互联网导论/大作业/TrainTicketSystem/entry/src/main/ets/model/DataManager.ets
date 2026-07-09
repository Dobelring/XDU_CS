// --- 数据接口定义 ---
export interface User {
  id: number;
  username: string;
  password?: string;
  phone: string;
  createTime: string;
  role: 'admin' | 'user';
}

export interface Train {
  id: number;
  trainNo: string; // 车次
  price: number;
  startStation: string;
  endStation: string;
  startDate: string; // YYYY-MM-DD
  startTime: string; // HH:mm
  duration: string;
  gate: string;
}

export interface Order {
  id: number;
  username: string; // 下单用户名
  phone: string; // 乘车人电话
  idCard: string; // 身份证
  orderNo: string;
  trainInfo: Train; // 关联的车次详情
  createTime: string;
}

// 模拟后端
export class DataManager {
  private static instance: DataManager;

  // 初始模拟数据：包含几条默认车票
  private trains: Train[] = [
    { id: 1, trainNo: 'G101', price: 500, startStation: '北京', endStation: '上海', startDate: '2024-01-01', startTime: '09:00', duration: '4小时', gate: '12A' },
    { id: 2, trainNo: 'D202', price: 300, startStation: '上海', endStation: '南京', startDate: '2024-01-01', startTime: '14:00', duration: '2小时', gate: '5B' },
    { id: 3, trainNo: 'K303', price: 150, startStation: '西安', endStation: '成都', startDate: '2024-01-02', startTime: '08:00', duration: '10小时', gate: '3C' }
  ];

  private users: User[] = [
    { id: 1, username: 'admin', password: '123', phone: '13800000000', createTime: '2023-01-01', role: 'admin' },
    { id: 2, username: 'test', password: '123', phone: '13900000000', createTime: '2023-12-29', role: 'user' }
  ];

  private orders: Order[] = [];
  private currentUser: User | null = null;

  public static getInstance(): DataManager {
    if (!DataManager.instance) {
      DataManager.instance = new DataManager();
    }
    return DataManager.instance;
  }

  // 用户相关
  login(name: string, pass: string): User | null {
    const user = this.users.find(u => u.username === name && u.password === pass);
    if (user) {
      this.currentUser = user;
      return user;
    }
    return null;
  }

  // 退出登录
  logout() {
    this.currentUser = null;
  }

  register(name: string, pass: string, phone: string): boolean {
    if (this.users.find(u => u.username === name)) return false;
    this.users.push({
      id: Date.now(),
      username: name,
      password: pass,
      phone: phone,
      createTime: new Date().toLocaleString(),
      role: 'user'
    });
    return true;
  }

  getCurrentUser(): User | null { return this.currentUser; }
  getAllUsers(): User[] { return this.users; }
  searchUsers(name: string): User[] { return this.users.filter(u => u.username.includes(name)); }
  deleteUser(id: number) { this.users = this.users.filter(u => u.id !== id); }

  // 车票相关
  getAllTrains(): Train[] { return this.trains; }

  searchTrains(start: string, end?: string, date?: string): Train[] {
    return this.trains.filter(t => {
      // 简单的包含搜索，如果输入为空字符串则视为匹配
      let match = t.startStation.includes(start);
      if (end && end.trim() !== '') match = match && t.endStation.includes(end);
      if (date && date.trim() !== '') match = match && t.startDate === date;
      return match;
    });
  }

  addTrain(t: Train) { this.trains.push(t); }

  deleteTrain(id: number) {
    this.trains = this.trains.filter(t => t.id !== id);
  }

  updateTrain(t: Train) {
    const idx = this.trains.findIndex(item => item.id === t.id);
    if(idx !== -1) this.trains[idx] = t;
  }

  // 订单相关
  addOrder(train: Train, phone: string, idCard: string): boolean {
    if (!this.currentUser) return false;
    this.orders.push({
      id: Date.now(),
      username: this.currentUser.username,
      phone: phone,
      idCard: idCard,
      orderNo: 'ORD' + Date.now(),
      trainInfo: train,
      createTime: new Date().toLocaleString()
    });
    return true;
  }

  getOrdersByUser(username: string): Order[] {
    return this.orders.filter(o => o.username === username);
  }

  getAllOrders(): Order[] { return this.orders; }

  searchOrders(username: string): Order[] {
    if(!username) return this.orders;
    return this.orders.filter(o => o.username.includes(username));
  }

  deleteOrder(id: number) { this.orders = this.orders.filter(o => o.id !== id); }
}