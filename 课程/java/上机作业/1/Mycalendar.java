package homework;
import java.util.Calendar;             //使用Calendar类获取和设置日期
import java.util.Scanner;
public class Mycalendar{
	Calendar cal=Calendar.getInstance();
	static Scanner sc=new Scanner(System.in);
	
	
	private void func_1() {            //功能1
		System.out.println("输入年份：");
		int year=sc.nextInt();      	//输入年份
		int month=0;
		int day=0;		
		for(month=0;month<12;month++) {	          //循环输出12个月
			System.out.println("\t"+"\t"+"\t"+(month+1)+"月");    //标题居中
			System.out.println("Sun\tMON\tTue\tWed\tTur\tFri\tSat\t");   //表头，用制表符隔开
			cal.set(year,month,1);			
			int n=cal.get(Calendar.DAY_OF_WEEK)-1;   //算出每个月一号之前有几个制表符
			for(int i=0;i<n;i++) {
				System.out.print("\t");			
			}								
			cal.set(year,month+1,0);			
			int m=cal.get(Calendar.DAY_OF_MONTH );   //一个月的天数
			for(day=1;day<m+1;day++) {
				cal.set(year,month,day);				
				System.out.print(cal.get(Calendar.DAY_OF_MONTH)+"\t");
				if(cal.get(Calendar.DAY_OF_WEEK )%7==0) {
					System.out.print("\n");	
				}								
			}
			System.out.println("\n");			
			System.out.println("------------------------------------------------------");
		}

	}	
	private void func_2() {			   //功能2
		System.out.println("输入日期的年份");
		int year=sc.nextInt();
		System.out.println("输入日期的月份");
		int month=sc.nextInt();
		System.out.println("输入日期的日期");
		int day=sc.nextInt();		
		cal.set(year,month-1,day);
		int n=cal.get(Calendar.DAY_OF_WEEK)-1;
		if(n==0) {
			System.out.println("该天为星期日");
		}else {
			System.out.println("该天为星期"+n);
		}		
	}	
		
	public static void main(String[] args) {              //通过main方法参数传递给程序
		Mycalendar mc=new Mycalendar();
			System.out.println("输入“1”，输出该年份的全年日历；输入“2”，查询输入日期的星期");
			int n=sc.nextInt();
			if(n==1) {		
			mc.func_1();
			}
			else if(n==2) {
				mc.func_2();
			}else {
				System.out.println("输入形式错误，请重新输入");
			}
	}		
}
