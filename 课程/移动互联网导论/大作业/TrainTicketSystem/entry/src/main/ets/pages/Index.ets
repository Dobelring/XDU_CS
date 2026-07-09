import { DataManager } from '../model/DataManager';
import { router, promptAction } from '@kit.ArkUI';

@Entry
@Component
struct LoginIndex {
  @State isLogin: boolean = true; // true为登录模式，false为注册
  @State username: string = '';
  @State password: string = '';
  @State phone: string = '';

  build() {
    Column() {
      Text(this.isLogin ? "火车订票系统登录" : "新用户注册")
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 40, top: 100 })

      TextInput({ placeholder: '用户名' })
        .width('80%')
        .margin({ bottom: 20 })
        .onChange((value) => this.username = value)

      TextInput({ placeholder: '密码' })
        .type(InputType.Password)
        .width('80%')
        .margin({ bottom: 20 })
        .onChange((value) => this.password = value)

      if (!this.isLogin) {
        TextInput({ placeholder: '手机号' })
          .type(InputType.PhoneNumber)
          .width('80%')
          .margin({ bottom: 20 })
          .onChange((value) => this.phone = value)
      }

      Button(this.isLogin ? "登录" : "注册")
        .width('80%')
        .onClick(() => {
          if (this.isLogin) {
            this.handleLogin();
          } else {
            this.handleRegister();
          }
        })

      Text(this.isLogin ? "没有账号？去注册" : "已有账号？去登录")
        .fontColor(Color.Blue)
        .margin({ top: 20 })
        .onClick(() => {
          this.isLogin = !this.isLogin;
        })
    }
    .width('100%')
    .height('100%')
  }

  handleLogin() {
    const user = DataManager.getInstance().login(this.username, this.password);
    if (user) {
      promptAction.showToast({ message: '登录成功' });
      if (user.role === 'admin') {
        router.replaceUrl({ url: 'pages/AdminPage' });
      } else {
        router.replaceUrl({ url: 'pages/UserMainPage' });
      }
    } else {
      promptAction.showToast({ message: '用户名或密码错误' });
    }
  }

  handleRegister() {
    if (this.username && this.password && this.phone) {
      const success = DataManager.getInstance().register(this.username, this.password, this.phone);
      if (success) {
        promptAction.showToast({ message: '注册成功，请登录' });
        this.isLogin = true;
      } else {
        promptAction.showToast({ message: '用户名已存在' });
      }
    } else {
      promptAction.showToast({ message: '请完善信息' });
    }
  }
}