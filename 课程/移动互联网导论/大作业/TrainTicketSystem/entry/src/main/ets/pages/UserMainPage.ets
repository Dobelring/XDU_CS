import { DataManager, Train, Order } from '../model/DataManager';
import { router, promptAction } from '@kit.ArkUI';

@Entry
@Component
struct UserMainPage {
  @State currentIndex: number = 0;

  build() {
    Tabs({ barPosition: BarPosition.End }) {
      // Tab 1: 首页
      TabContent() { HomeView() }
      .tabBar(this.TabBuilder("首页", 0, $r('app.media.startIcon'))) // 假设有图标，没有可删参数

      // Tab 2: 动车
      TabContent() { TrainListView() }
      .tabBar(this.TabBuilder("动车", 1, null))

      // Tab 3: 我的 (传入 currentIndex 用于触发刷新)
      TabContent() { MineView({ currentTabIndex: this.currentIndex }) }
      .tabBar(this.TabBuilder("我的", 2, null))
    }
    .onChange((index) => {
      this.currentIndex = index;
    })
  }

  @Builder TabBuilder(title: string, index: number, icon: Resource | null) {
    Column() {
      // 简单起见，只显示文字，颜色区分选中状态
      Text(title)
        .fontColor(this.currentIndex === index ? '#007DFF' : Color.Gray)
        .fontWeight(this.currentIndex === index ? FontWeight.Bold : FontWeight.Normal)
    }
  }
}

// --- 首页视图 ---
@Component
struct HomeView {
  @State startStation: string = '北京';
  @State endStation: string = '上海';
  @State searchDate: string = '2024-01-01';
  @State resultTrains: Train[] = [];

  @State showBookDialog: boolean = false;
  @State selectedTrain: Train | null = null;
  @State bookPhone: string = '';
  @State bookIdCard: string = '';

  build() {
    Column() {
      // 1. 轮播图 (修改为加载图片)
      Swiper() {
        Image($r('app.media.banner1')).width('100%').height(200).objectFit(ImageFit.Cover)
        Image($r('app.media.banner2')).width('100%').height(200).objectFit(ImageFit.Cover)
        Image($r('app.media.banner3')).width('100%').height(200).objectFit(ImageFit.Cover)
      }
      .autoPlay(true)
      .height(200)
      .width('100%')

      // 2. 搜索框
      Column() {
        Row() {
          TextInput({ text: this.startStation, placeholder: '起始站' }).width('40%').onChange(v => this.startStation = v)
          Text("⇌").fontSize(20).fontWeight(FontWeight.Bold).fontColor(Color.Blue)
          TextInput({ text: this.endStation, placeholder: '终点站' }).width('40%').onChange(v => this.endStation = v)
        }.justifyContent(FlexAlign.SpaceAround).width('100%').padding(10)

        TextInput({ text: this.searchDate, placeholder: '日期 (YYYY-MM-DD)' }).width('90%').onChange(v => this.searchDate = v)

        Button("查询车票").width('90%').margin({ top: 10 }).onClick(() => {
          this.resultTrains = DataManager.getInstance().searchTrains(this.startStation, this.endStation, this.searchDate);
          if (this.resultTrains.length === 0) {
            promptAction.showToast({ message: '当天暂无车票' });
          }
        })
      }.backgroundColor(Color.White).padding(10).margin(10).borderRadius(10).shadow({radius: 5})

      // 3. 搜索结果
      List() {
        ForEach(this.resultTrains, (item: Train) => {
          ListItem() {
            TrainItemCard({ train: item, onBook: () => {
              this.selectedTrain = item;
              this.showBookDialog = true;
            }})
          }
        })
      }.layoutWeight(1)

      // 4. 预定弹窗
      if (this.showBookDialog) {
        BookDialog({
          train: this.selectedTrain,
          onCancel: () => this.showBookDialog = false,
          onConfirm: (phone, idCard) => {
            if(this.selectedTrain) {
              const success = DataManager.getInstance().addOrder(this.selectedTrain, phone, idCard);
              if(success) promptAction.showToast({ message: '下单成功！' });
              else promptAction.showToast({ message: '下单失败，请先登录' });
              this.showBookDialog = false;
            }
          }
        })
      }
    }.height('100%').backgroundColor('#f5f5f5')
  }
}

// --- 动车列表视图 ---
@Component
struct TrainListView {
  @State trains: Train[] = DataManager.getInstance().getAllTrains();
  @State searchStart: string = '';
  @State showBookDialog: boolean = false;
  @State selectedTrain: Train | null = null;

  build() {
    Column() {
      Row() {
        TextInput({ placeholder: '输入起始站筛选' }).onChange(v => this.searchStart = v).layoutWeight(1)
        Button("筛选").onClick(() => {
          this.trains = DataManager.getInstance().searchTrains(this.searchStart);
        }).margin({left: 10})
      }.padding(10).backgroundColor(Color.White)

      List() {
        ForEach(this.trains, (item: Train) => {
          ListItem() {
            TrainItemCard({ train: item, onBook: () => {
              this.selectedTrain = item;
              this.showBookDialog = true;
            }})
          }
        })
      }.layoutWeight(1)

      if (this.showBookDialog) {
        BookDialog({
          train: this.selectedTrain,
          onCancel: () => this.showBookDialog = false,
          onConfirm: (phone, idCard) => {
            if(this.selectedTrain) {
              DataManager.getInstance().addOrder(this.selectedTrain, phone, idCard);
              promptAction.showToast({ message: '下单成功！' });
              this.showBookDialog = false;
            }
          }
        })
      }
    }.height('100%').backgroundColor('#f5f5f5')
  }
}

// --- 我的视图 (核心修改：数据刷新) ---
@Component
struct MineView {
  @Prop @Watch('onTabChange') currentTabIndex: number; // 监听父组件Tab变化
  @State myOrders: Order[] = [];
  @State currentUser: string = '';

  // 当 Tab 切换到 "我的" (index == 2) 时，重新加载数据
  onTabChange() {
    if (this.currentTabIndex === 2) {
      this.loadData();
    }
  }

  aboutToAppear() {
    this.loadData();
  }

  loadData() {
    const user = DataManager.getInstance().getCurrentUser();
    if(user) {
      this.currentUser = user.username;
      // 重新从 DataManager 获取最新数据
      this.myOrders = DataManager.getInstance().getOrdersByUser(user.username);
    }
  }

  build() {
    Column() {
      // 头部用户信息
      Column() {
        // 头像部分
        Image($r('app.media.app_icon')) // 确保有这个图，或者用 Text 替代
          .width(60).height(60).borderRadius(30).backgroundColor(Color.Gray)

        Text(this.currentUser).fontSize(20).fontWeight(FontWeight.Bold).margin({top: 10})
      }.width('100%').padding(20).backgroundColor(Color.White).alignItems(HorizontalAlign.Center)

      Text("我的订单").fontSize(16).fontWeight(FontWeight.Bold).padding(10).width('100%')

      List() {
        ForEach(this.myOrders, (item: Order) => {
          ListItem() {
            Column() {
              Row() {
                Text(item.trainInfo.trainNo).fontSize(18).fontWeight(FontWeight.Bold)
                Text(`¥${item.trainInfo.price}`).fontColor(Color.Red)
              }.width('100%').justifyContent(FlexAlign.SpaceBetween)
              Divider().margin({top:5, bottom:5})
              Row() {
                Column() {
                  Text(item.trainInfo.startStation).fontSize(16)
                  Text(item.trainInfo.startTime).fontSize(12).fontColor(Color.Gray)
                }
                Text("→").margin({left: 10, right: 10})
                Column() {
                  Text(item.trainInfo.endStation).fontSize(16)
                  Text(item.trainInfo.duration).fontSize(12).fontColor(Color.Gray)
                }
              }.width('100%').justifyContent(FlexAlign.Center)
              Text(`日期: ${item.trainInfo.startDate} | 检票口: ${item.trainInfo.gate}`)
                .fontSize(12).fontColor(Color.Gray).margin({top:5})
            }.padding(15).backgroundColor(Color.White).margin(10).borderRadius(10)
          }
        })
      }.layoutWeight(1)

      // 退出登录按钮
      Button("退出登录")
        .width('90%')
        .backgroundColor(Color.Red)
        .margin({ bottom: 20 })
        .onClick(() => {
          DataManager.getInstance().logout();
          router.replaceUrl({ url: 'pages/Index' });
        })

    }.height('100%').backgroundColor('#f5f5f5')
  }
}

// --- 提取公共弹窗组件 ---
@Component
struct BookDialog {
  train: Train | null = null;
  onCancel: () => void = () => {};
  onConfirm: (phone: string, id: string) => void = () => {};
  @State phone: string = '';
  @State idCard: string = '';

  build() {
    Column() {
      Text(`预定 ${this.train?.trainNo}`).fontWeight(FontWeight.Bold).fontSize(18).margin({bottom:10})
      TextInput({ placeholder: '请输入手机号' }).onChange(v => this.phone = v).margin(5)
      TextInput({ placeholder: '请输入身份证号' }).onChange(v => this.idCard = v).margin(5)
      Row() {
        Button("取消").backgroundColor(Color.Gray).onClick(this.onCancel)
        Button("确认购买").onClick(() => this.onConfirm(this.phone, this.idCard))
      }.margin({top: 10}).width('100%').justifyContent(FlexAlign.SpaceAround)
    }
    .width('80%').padding(20).backgroundColor(Color.White).borderRadius(10).shadow({radius: 20})
    .position({x: '10%', y: '30%'})
  }
}

// --- 提取公共车票卡片组件 ---
@Component
struct TrainItemCard {
  train: Train = {} as Train;
  onBook: () => void = () => {};

  build() {
    Column() {
      Row() {
        Text(this.train.trainNo).fontWeight(FontWeight.Bold).fontSize(20)
        Text(`¥${this.train.price}`).fontSize(20).fontColor(Color.Red)
      }.width('100%').justifyContent(FlexAlign.SpaceBetween)

      Row() {
        Column() {
          Text(this.train.startStation).fontSize(18)
          Text(this.train.startTime).fontSize(24).fontWeight(FontWeight.Bold).fontColor(Color.Blue)
        }
        Column() {
          Text(this.train.duration).fontSize(12).fontColor(Color.Gray)
          Text("-----").fontColor(Color.Gray)
        }
        Column() {
          Text(this.train.endStation).fontSize(18)
          Text("检票:" + this.train.gate).fontSize(12).fontColor(Color.Gray)
        }
      }.width('100%').justifyContent(FlexAlign.SpaceAround).margin({ top: 10, bottom: 10 })

      Button("预定").width('100%').onClick(this.onBook)
    }
    .padding(15)
    .margin(10)
    .backgroundColor(Color.White)
    .borderRadius(10)
  }
}