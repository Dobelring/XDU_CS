import java.util.Random;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class TicketWindow extends Thread {
    private static int ticketCount = 100; // 总票数
    private static final Lock lock = new ReentrantLock(); // 锁，用于保证线程安全
    private final String windowName; // 窗口名

    public TicketWindow(String windowName) {
        this.windowName = windowName;
    }

    @Override
    public void run() {
        Random rand = new Random();
        while (true) {
            lock.lock();
            try {
                if (ticketCount > 0) {
                    System.out.println("窗口" + windowName + "出售编号" + ticketCount-- + "的电影票");
                    try {
                        Thread.sleep(rand.nextInt(500)); // 随机暂停0-500毫秒，模拟出票间隔
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                } else {
                    break;
                }
            } finally {
                lock.unlock();
            }
        }
    }

    public static void main(String[] args) {
        // 提示用户功能及开始信息
        System.out.println("欢迎使用电影院售票系统！程序将模拟三个窗口出售电影票。");

        TicketWindow window1 = new TicketWindow("1");
        TicketWindow window2 = new TicketWindow("2");
        TicketWindow window3 = new TicketWindow("3");

        window1.start();
        window2.start();
        window3.start();

        try {
            window1.join();
            window2.join();
            window3.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        // 提示售票结束
        System.out.println("所有电影票售完，谢谢光临！");
    }
}