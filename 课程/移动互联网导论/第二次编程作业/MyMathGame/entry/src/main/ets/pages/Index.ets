// 初始化持久化存储，用于保存历史最高分
PersistentStorage.persistProp('highScore', 0);

@Entry
@Component
struct Index {
  // --- 状态变量 ---
  @StorageLink('highScore') highScore: number = 0; // 历史最高分 (持久化)
  @State currentScore: number = 0;                 // 当前得分
  @State questionText: string = '点击开始生成题目';  // 题目显示文本
  @State userAnswer: string = '';                  // 用户输入的答案
  @State isGameRunning: boolean = false;           // 游戏状态
  @State feedbackMessage: string = '';             // 提示信息

  // 内部变量，不需要UI响应，用于存储当前题目的正确答案
  private currentAnswer: number = 0;

  build() {
    Column() {
      // 1. 顶部标题栏与分数板
      this.HeaderSection()

      Divider().strokeWidth(2).color('#F1F3F5').margin({ top: 10, bottom: 10 })

      // 2. 游戏主区域
      this.GameAreaSection()

      // 3. 底部控制区
      this.ControlSection()
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor('#FFFFFF')
  }

  // --- UI 组件拆分 ---

  @Builder
  HeaderSection() {
    Column({ space: 10 }) {
      Text('小学生四则运算练习')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')

      Row() {
        Text(`历史最高: ${this.highScore}`)
          .fontSize(16)
          .fontColor('#888888')
        Blank()
        Text(`当前得分: ${this.currentScore}`)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#007DFF')
      }
      .width('100%')
    }
  }

  @Builder
  GameAreaSection() {
    Column({ space: 20 }) {
      // 题目显示
      Text(this.questionText)
        .fontSize(32)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isGameRunning ? '#000000' : '#CCCCCC')
        .textAlign(TextAlign.Center)
        .margin({ top: 40 })

      // 提示信息
      Text(this.feedbackMessage)
        .fontSize(16)
        .fontColor(this.feedbackMessage.includes('结束') ? Color.Red : Color.Green)
        .height(20)

      // 输入框
      TextInput({ placeholder: '请输入答案', text: this.userAnswer })
        .type(InputType.Number) // 限制数字键盘
        .enabled(this.isGameRunning)
        .maxLength(10)
        .height(50)
        .fontSize(20)
        .onChange((value: string) => {
          this.userAnswer = value;
        })
        .onSubmit(() => {
          this.submitAnswer();
        })
        .margin({ top: 20 })

      // 提交按钮
      Button('提交答案')
        .width('80%')
        .height(50)
        .enabled(this.isGameRunning && this.userAnswer.length > 0)
        .onClick(() => {
          this.submitAnswer();
        })
    }
    .layoutWeight(1) // 占据剩余空间
  }

  @Builder
  ControlSection() {
    Row({ space: 20 }) {
      if (!this.isGameRunning) {
        Button('开始练习')
          .type(ButtonType.Capsule)
          .backgroundColor('#007DFF')
          .width('60%')
          .height(50)
          .onClick(() => {
            this.startGame();
          })
      } else {
        Button('停止')
          .type(ButtonType.Capsule)
          .backgroundColor('#FF4040')
          .width('60%')
          .height(50)
          .onClick(() => {
            this.stopGame();
          })
      }
    }
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .margin({ bottom: 30 })
  }

  // --- 业务逻辑 ---

  /**
   * 开始游戏
   */
  startGame(): void {
    this.isGameRunning = true;
    this.currentScore = 0;
    this.userAnswer = '';
    this.feedbackMessage = '';
    this.generateNextQuestion();
  }

  /**
   * 停止游戏（手动结束）
   */
  stopGame(): void {
    this.handleGameOver('练习已手动停止');
  }

  /**
   * 提交答案并验证
   */
  submitAnswer(): void {
    if (!this.isGameRunning) {
      return;
    }

    const inputNum: number = parseFloat(this.userAnswer);

    // 简单的浮点数精度处理，判断是否相等
    if (Math.abs(inputNum - this.currentAnswer) < 0.01) {
      // 答案正确
      this.currentScore++;
      this.feedbackMessage = '回答正确！';
      this.userAnswer = ''; // 清空输入框
      this.generateNextQuestion();
    } else {
      // 答案错误
      this.handleGameOver(`回答错误！正确答案是: ${this.currentAnswer}`);
    }
  }

  /**
   * 游戏结束处理
   */
  handleGameOver(reason: string): void {
    this.isGameRunning = false;
    this.feedbackMessage = reason;

    // 更新历史最高分
    if (this.currentScore > this.highScore) {
      this.highScore = this.currentScore; // AppStorage 自动持久化
    }

    this.questionText = `最终得分: ${this.currentScore}`;
  }

  /**
   * 生成下一道题目
   * 核心逻辑：生成符合“小学生”难度的题目
   */
  generateNextQuestion(): void {
    let isValid: boolean = false;

    // 循环生成直到找到一个结果合理的题目（避免过于复杂的无限小数或过大数值）
    while (!isValid) {
      const opsCount: number = Math.floor(Math.random() * 3) + 3; // 随机 3-5 个运算符
      const numbers: number[] = [];
      const operators: string[] = [];
      const opTypes: string[] = ['+', '-', '*', '/'];

      // 1. 生成数字 (0-100)
      for (let i = 0; i <= opsCount; i++) {
        numbers.push(Math.floor(Math.random() * 101));
      }

      // 2. 生成运算符
      const usedOpTypes: Set<string> = new Set();
      for (let i = 0; i < opsCount; i++) {
        const opIndex: number = Math.floor(Math.random() * 4);
        const op: string = opTypes[opIndex];
        operators.push(op);
        usedOpTypes.add(op);
      }

      // 3. 验证：至少包含两种不同运算符
      if (usedOpTypes.size < 2) {
        continue;
      }

      // 4. 构建表达式字符串
      let expression: string = `${numbers[0]}`;
      for (let i = 0; i < operators.length; i++) {
        expression += ` ${operators[i]} ${numbers[i + 1]}`;
      }

      // 5. 计算结果 (避免使用 eval，手动实现简单的优先级计算)
      const result: number | null = this.calculateExpression(numbers, operators);

      // 6. 验证结果合理性 (小学生题目：结果应为整数，且不为负数，分母不为0)
      if (result !== null && result >= 0 && Number.isInteger(result)) {
        this.questionText = expression + ' = ?';
        this.currentAnswer = result;
        isValid = true;
      }
    }
  }

  /**
   * 计算表达式结果（处理乘除优先级）
   * @param nums 操作数数组
   * @param ops 运算符数组
   * @returns 计算结果，如果除数为0返回 null
   */
  calculateExpression(nums: number[], ops: string[]): number | null {
    // 复制数组以防修改原数据
    const tempNums: number[] = [...nums];
    const tempOps: string[] = [...ops];

    // 第一轮：处理乘除
    for (let i = 0; i < tempOps.length; i++) {
      if (tempOps[i] === '*' || tempOps[i] === '/') {
        const n1: number = tempNums[i];
        const n2: number = tempNums[i + 1];
        let res: number = 0;

        if (tempOps[i] === '*') {
          res = n1 * n2;
        } else {
          if (n2 === 0) return null; // 除数不能为0
          res = n1 / n2;
        }

        // 更新数组：删除运算过的数字和符号，插入结果
        tempNums.splice(i, 2, res);
        tempOps.splice(i, 1);
        i--; // 索引回退，继续检查当前位置
      }
    }

    // 第二轮：处理加减
    let finalResult: number = tempNums[0];
    for (let i = 0; i < tempOps.length; i++) {
      const nextNum: number = tempNums[i + 1];
      if (tempOps[i] === '+') {
        finalResult += nextNum;
      } else {
        finalResult -= nextNum;
      }
    }

    return finalResult;
  }
}