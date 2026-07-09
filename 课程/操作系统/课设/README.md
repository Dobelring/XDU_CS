跟着前人的路走的，只做出来前两个。。。

使用Ubuntu虚拟机。

# 实验一操作步骤
**1.代码编写**

编写 kernel_module.c 文件，包含模块的初始化、两个线程的实现以及资源的清理。

**2. 使用vim将代码上传至虚拟机**

输入`vi 文件名`查看文件，按`ESC`进入编辑模式，而后输入`dd`删除光标当前行及以下的部分，转到本机编辑好的文件，复制，右击鼠标即可将当前剪贴板里的内容粘贴进去，按`ESC`，输入`:wq`保存并退出。

**3.编译内核模块**

使用`make`编译模块。

**4. 运行模块并查看日志**

使用`insmod`命令加载模块，使用`dmesg`查看模块的日志输出，确认线程1和线程2的运行情况。

```
sudo insmod kernel_module.ko
```

**5. 卸载模块**

使用`rmmod`卸载内核模块，卸载后再次查看dmesg，确认内核线程已安全停止，链表资源已释放，内存没有泄漏。

```
sudo rmmod kernel_module
```

**实验二的步骤和实验一类似。`deferred_work.c`代码中`247`改为自己学号后三位即可。**

```
  for (i = 0; i < 10; i++) {
        works[i].current_id = 247 + i;
        INIT_WORK(&works[i].work, work_queue_handler);
        schedule_work(&works[i].work);
    }
```
