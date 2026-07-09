import { DataManager, User, Train, Order } from '../model/DataManager';
import { promptAction, router } from '@kit.ArkUI';

@Entry
@Component
struct AdminPage {
  @State currentTab: number = 0;

  build() {
    Column() {
      // 顶部标题栏
      Row() {
        Text("后台管理系统").fontSize(20).fontWeight(FontWeight.Bold).fontColor(Color.White)
        Blank()
        Button("退出登录").fontSize(14).backgroundColor(Color.Red).onClick(() => {
          DataManager.getInstance().logout();
          router.replaceUrl({ url: 'pages/Index' });
        })
      }
      .width('100%').height(50).backgroundColor('#333333').padding(10)

      Tabs({ barPosition: BarPosition.Start }) {
        TabContent() { UserManageView() }.tabBar("用户维护")
        TabContent() { TrainManageView() }.tabBar("车票列表")
        TabContent() { OrderManageView() }.tabBar("订单列表")
      }
      .layoutWeight(1)
      .barWidth('100%')
    }
    .width('100%').height('100%')
  }
}

// 用户管理
@Component
struct UserManageView {
  @State users: User[] = DataManager.getInstance().getAllUsers();
  @State searchText: string = '';

  refresh() { this.users = DataManager.getInstance().searchUsers(this.searchText); }

  build() {
    Column() {
      Row() {
        TextInput({ placeholder: '搜索用户名' }).onChange(v => this.searchText = v).layoutWeight(1)
        Button("搜索").onClick(() => this.refresh()).margin({ left: 10 })
      }.padding(10)

      List() {
        ForEach(this.users, (item: User) => {
          ListItem() {
            Column() {
              Row() {
                Text(`ID: ${item.id}  ${item.username}`).fontWeight(FontWeight.Bold)
                Blank()
                Text(item.role).fontColor(Color.Gray)
              }.width('100%')
              Text(`手机: ${item.phone} | 创建: ${item.createTime}`).fontSize(12).fontColor(Color.Gray)
              Row() {
                Button("删除").fontSize(12).backgroundColor(Color.Red)
                  .onClick(() => {
                    DataManager.getInstance().deleteUser(item.id);
                    this.refresh();
                  })
              }.margin({ top: 5 }).justifyContent(FlexAlign.End).width('100%')
            }
            .padding(10).backgroundColor(Color.White).margin(5).borderRadius(8)
          }
        })
      }.layoutWeight(1).backgroundColor('#f0f0f0')
    }
  }
}

// 车票管理
@Component
struct TrainManageView {
  @State trains: Train[] = DataManager.getInstance().getAllTrains();
  @State showDialog: boolean = false;

  // 临时变量，包含所有字段
  @State tempTrain: Train = {
    id: 0, trainNo: '', price: 0, startStation: '', endStation: '',
    startDate: '', startTime: '', duration: '', gate: ''
  };

  refresh() { this.trains = DataManager.getInstance().getAllTrains(); }

  build() {
    Column() {
      Row() {
        TextInput({ placeholder: '搜索车次/车站' }).layoutWeight(1)
        Button("新增车票").onClick(() => {
          // 初始化默认值
          this.tempTrain = {
            id: 0, trainNo: '', price: 0, startStation: '', endStation: '',
            startDate: '2024-01-01', startTime: '08:00', duration: '2小时', gate: '1A'
          };
          this.showDialog = true;
        }).margin({left: 10})
      }.padding(10).width('100%')

      // 新增弹窗
      if (this.showDialog) {
        Column() {
          Text("新增车票").fontWeight(FontWeight.Bold).margin({bottom: 10})

          Scroll() {
            Column({space: 10}) {
              TextInput({ placeholder: '车次 (如 G101)', text: this.tempTrain.trainNo }).onChange(v => this.tempTrain.trainNo = v)
              TextInput({ placeholder: '价格', text: this.tempTrain.price == 0 ? '' : this.tempTrain.price.toString() }).onChange(v => this.tempTrain.price = parseFloat(v))
              TextInput({ placeholder: '起始站', text: this.tempTrain.startStation }).onChange(v => this.tempTrain.startStation = v)
              TextInput({ placeholder: '终点站', text: this.tempTrain.endStation }).onChange(v => this.tempTrain.endStation = v)
              TextInput({ placeholder: '发车日期 (2024-01-01)', text: this.tempTrain.startDate }).onChange(v => this.tempTrain.startDate = v)
              TextInput({ placeholder: '发车时间 (09:00)', text: this.tempTrain.startTime }).onChange(v => this.tempTrain.startTime = v)
              TextInput({ placeholder: '历经时间 (4小时)', text: this.tempTrain.duration }).onChange(v => this.tempTrain.duration = v)
              TextInput({ placeholder: '检票口 (5A)', text: this.tempTrain.gate }).onChange(v => this.tempTrain.gate = v)
            }
          }.height(200) // 限制高度可滚动

          Row() {
            Button("取消").onClick(() => this.showDialog = false).backgroundColor(Color.Gray).margin(5)
            Button("保存").onClick(() => {
              if(this.tempTrain.id === 0) {
                this.tempTrain.id = Date.now();
                DataManager.getInstance().addTrain(this.tempTrain);
              }
              this.showDialog = false;
              this.refresh();
            }).margin(5)
          }.margin({top: 10})
        }
        .padding(20).backgroundColor(Color.White).borderRadius(10)
        .shadow({radius: 10}).position({x: '10%', y: '10%'}).width('80%').zIndex(100)
      }

      List() {
        ForEach(this.trains, (item: Train) => {
          ListItem() {
            Column() {
              Row() {
                Text(item.trainNo).fontWeight(FontWeight.Bold).fontSize(18)
                Text(`¥${item.price}`).fontColor(Color.Red).fontSize(18)
              }.width('100%').justifyContent(FlexAlign.SpaceBetween)
              Text(`${item.startStation} -> ${item.endStation}`).margin({top: 5})
              Text(`日期: ${item.startDate} ${item.startTime}`).fontColor(Color.Gray)
              Text(`检票口: ${item.gate} | 时长: ${item.duration}`).fontColor(Color.Gray).fontSize(12)
              Row() {
                Button("删除").fontSize(12).backgroundColor(Color.Red).onClick(() => {
                  DataManager.getInstance().deleteTrain(item.id);
                  this.refresh();
                })
              }.width('100%').justifyContent(FlexAlign.End).margin({top: 5})
            }.padding(10).backgroundColor(Color.White).margin(5).borderRadius(8)
          }
        })
      }.layoutWeight(1).backgroundColor('#f0f0f0')
    }
  }
}

// 订单管理
@Component
struct OrderManageView {
  @State orders: Order[] = DataManager.getInstance().getAllOrders();
  @State searchUser: string = '';

  refresh() { this.orders = DataManager.getInstance().searchOrders(this.searchUser); }

  aboutToAppear() {
    this.refresh(); // 进入时刷新
  }

  build() {
    Column() {
      Row() {
        TextInput({ placeholder: '搜索下单用户名' }).onChange(v => this.searchUser = v).layoutWeight(1)
        Button("搜索").onClick(() => this.refresh()).margin({ left: 10 })
      }.padding(10)

      List() {
        ForEach(this.orders, (item: Order) => {
          ListItem() {
            Column({space: 5}) {
              Text(`订单号: ${item.orderNo}`).fontSize(12).fontColor(Color.Gray)
              Row() {
                Text(`用户: ${item.username}`).fontWeight(FontWeight.Bold)
                Text(item.phone)
              }.width('100%').justifyContent(FlexAlign.SpaceBetween)
              Divider()
              Text(`车次: ${item.trainInfo.trainNo} | ${item.trainInfo.startStation} -> ${item.trainInfo.endStation}`)
              Text(`发车: ${item.trainInfo.startDate} ${item.trainInfo.startTime} | 检票: ${item.trainInfo.gate}`)
              Button("删除订单").width('100%').backgroundColor(Color.Red).margin({top: 5})
                .onClick(() => {
                  DataManager.getInstance().deleteOrder(item.id);
                  this.refresh();
                })
            }.padding(10).backgroundColor(Color.White).margin(5).borderRadius(8)
          }
        })
      }.layoutWeight(1).backgroundColor('#f0f0f0')
    }
  }
}