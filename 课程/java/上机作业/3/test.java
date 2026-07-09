import java.util.ArrayList;
import java.util.Iterator;
import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class test {
    public static void main (String args[]){
        ArrayList<Book> book=new ArrayList<>();
        ArrayList<Student> student=new ArrayList<>();
        Scanner sc=new Scanner(System.in);
        Book bk1=new Book("平凡的世界","张三","A出版社",1);
        Book bk2=new Book("平凡的六便士","张三","A出版社",1);
        Book bk3=new Book("月亮与六便士","李四","B出版社",1);
        Book bk4=new Book("平凡的月亮","李四","B出版社",1);
        Book bk5=new Book("平凡的月亮","张三，李四","B出版社",1);
        Student stu1=new Student(1,0);
        Student stu2=new Student(2,0);
        Student stu3=new Student(3,0);
        book.add(bk1);
        book.add(bk2);
        book.add(bk3);
        book.add(bk4);
        book.add(bk5);
        student.add(stu1);
        student.add(stu2);
        student.add(stu3);
        loop1:while(true){
            System.out.println("图书管理系统：1.书籍管理功能；2.借阅归还功能；3.退出");
            int option= sc.nextInt();
            if(option==1){
                loop2:while(true){
                    System.out.println("请输入功能：1.查询书籍；2.添加书籍；3.删除书籍；4.退出");
                    int opt=sc.nextInt();
                    switch (opt){
                        case 1:search(book);break;
                        case 2:add(book);break;
                        case 3:delete(book);break;
                        case 4:break loop2;
                    }
                }
            }
            else if(option==2){
                loop3:while (true){
                    System.out.println("请输入功能:1.借阅书籍；2.归还书籍；3.查询借阅情况；4.退出");
                    int opt= sc.nextInt();
                    switch (opt){
                        case 1:borrow(book,student);break;
                        case 2:back(book,student);break;
                        case 3:inquire(student);break;
                        case 4:break loop3;
                    }
                }
            }
            else if(option==3){
                break loop1;
            }
        }
    }
    public static void search(ArrayList<Book> book){
        Scanner sc=new Scanner(System.in);
        String searchContent;
        System.out.println("请输入需要查询的内容：1.查询书名；2.查询作者；3.查询出版社");
        int opt= sc.nextInt();
        if(opt==1){
            System.out.println("请输入需要查询的书名");
            searchContent=sc.next();
            //采用模糊查找
            Pattern pattern = Pattern.compile(searchContent);
            //bk用于储存查找的书籍
            ArrayList<Book> bk=new ArrayList<>();
            for(int i=0;i<book.size();i++){
                Matcher matcher = pattern.matcher(book.get(i).getBookName());
                if(matcher.find()){
                    //bkAdd用于记录需要添加到bk中的书籍
                    Book bkAdd=new Book(book.get(i).getBookName(),book.get(i).getEditor(),book.get(i).getPublisher(),1);
                    bk.add(bkAdd);
                }
            }
            System.out.println("查询完毕，查找到的书籍为：");
            for (int i = 0; i < bk.size(); i++) {
                System.out.println(bk.get(i).getBookName()+" "+bk.get(i).getEditor()+" "+bk.get(i).getPublisher());
            }
            if(bk.size()==0){
                System.out.println("未查询到书籍，请重新输入");
            }
        }
        if(opt==2){
            System.out.println("请输入需要查询的作者，作者为多人时请用逗号分隔作者名");
            searchContent=sc.next();
            //bk用于储存查找的书籍
            ArrayList<Book> bk=new ArrayList<>();
            //使用迭代器
            Iterator<Book> it= book.iterator();
            while(it.hasNext()){
                Book bkAdd=(Book)it.next();
                if(bkAdd.getEditor().equals(searchContent)){
                    bk.add(bkAdd);
                }
            }
            /*for (int i = 0; i < book.size(); i++) {
                if(book.get(i).getEditor().equals(searchContent)){
                    //bkAdd用于记录需要添加到bk中的书籍
                    Book bkAdd=new Book(book.get(i).getBookName(),book.get(i).getEditor(),book.get(i).getPublisher(),1);
                    bk.add(bkAdd);
                }
            }*/
            System.out.println("查询完毕，查找到的书籍为：");
            for (int i = 0; i < bk.size(); i++) {
                System.out.println(bk.get(i).getBookName()+" "+bk.get(i).getEditor()+" "+bk.get(i).getPublisher());
            }
            if(bk.size()==0){
                System.out.println("未查询到作者，请重新输入");
            }
        }
        if(opt==3){
            System.out.println("请输入需要查询的出版社");
            searchContent=sc.next();
            //bk用于储存查找的书籍
            ArrayList<Book> bk=new ArrayList<>();
            //使用迭代器
            Iterator<Book> it= book.iterator();
            while(it.hasNext()){
                Book bkAdd=(Book)it.next();
                if(bkAdd.getPublisher().equals(searchContent)){
                    bk.add(bkAdd);
                }
            }
            /*for (int i = 0; i < book.size(); i++) {
                if(book.get(i).getPublisher().equals(searchContent)){
                    //bkAdd用于记录需要添加到bk中的书籍
                    Book bkAdd=new Book(book.get(i).getBookName(),book.get(i).getEditor(),book.get(i).getPublisher(),1);
                    bk.add(bkAdd);
                }
            }*/
            System.out.println("查询完毕，查找到的书籍为：");
            for (int i = 0; i < bk.size(); i++) {
                System.out.println(bk.get(i).getBookName()+" "+bk.get(i).getEditor()+" "+bk.get(i).getPublisher());
            }
            if(bk.size()==0){
                System.out.println("未查询到出版社，请重新输入");
            }
        }
    }
    public static void add(ArrayList<Book> book){
        Scanner sc=new Scanner(System.in);
        String bookName,editor,publisher;
        int index,number;
        Boolean flag;
        System.out.println("请输入书籍的书名：");
        bookName= sc.next();
        System.out.println("请输入书籍的作者，作者为多人时请用逗号分隔作者名");
        editor= sc.next();
        System.out.println("请输入书籍的出版社");
        publisher= sc.next();
        System.out.println("请输入书籍的数量");
        number= sc.nextInt();
        flag=judgeExist(book,bookName);
        index=getIndex(book,bookName);
        if(flag){
            System.out.println("书籍已存在，数量已增加"+number+"本");
            book.get(index).addNumber(number);
        }
        else{
            System.out.println("书籍信息已增添");
            Book bk=new Book(bookName,editor,publisher,number);
            book.add(bk);
        }
    }
    public static void delete(ArrayList<Book> book){
        Scanner sc=new Scanner(System.in);
        String bookName;
        int index;
        System.out.println("请输入需要删除的书籍的名称");
        bookName= sc.next();
        index=getIndex(book,bookName);
        System.out.println("书籍已成功删除");
        book.remove(index);
    }
    public static void borrow(ArrayList<Book> book,ArrayList<Student> student){
        Scanner sc=new Scanner(System.in);
        System.out.println("请输入学号");
        int id=sc.nextInt();
        System.out.println("请输入需要借阅的书名");
        String bookName= sc.next();
        for (int i = 0; i < book.size(); i++) {
            if(book.get(i).getBookName().equals(bookName)){
                if(book.get(i).getNumber()>0){
                    if(student.get(id).borrowNumber<=3){
                        book.get(i).subtractNumber();
                        student.get(id).addBorrowNumber();
                        student.get(id).setBookName(bookName);
                        System.out.println("借阅成功,"+book.get(i).getBookName()+"还剩"+book.get(i).getNumber()+"本");
                        System.out.println("你还能借"+(3-student.get(id).getBorrowNumber())+"本书");
                    }
                    else{
                        System.out.println("借阅数量已到上限，无法借阅");
                    }
                }
                else{
                    System.out.println("书已被借完，无法借阅");
                }
            }
        }
    }
    public static void inquire(ArrayList<Student> student){
        Scanner sc=new Scanner(System.in);
        System.out.println("请输入需要查询的学生的学号");
        int id=sc.nextInt();
        Student stu=student.get(id);
        System.out.println("学号"+id+"已借阅"+stu.getBorrowNumber()+"本书");
        int n=1;
        for (int i = 0; i < stu.bookName.length; i++) {
            if(!stu.bookName[i].equals("none")){
                System.out.println("借阅的第"+(n++)+"本书："+stu.bookName[i]);
            }
        }
    }
    public static void back(ArrayList<Book> book,ArrayList<Student> student){
        Scanner sc=new Scanner(System.in);
        System.out.println("请输入学号");
        int id=sc.nextInt();
        System.out.println("请输入需要归还的书名");
        String bookName= sc.next();
        for (int i = 0; i < book.size(); i++){
            if(book.get(i).getBookName().equals(bookName)){
                book.get(i).add();
                student.get(id).subtractBorrowNumber();
                student.get(id).deleteBookName(bookName);
                System.out.println("归还成功,"+book.get(i).getBookName()+"还剩"+book.get(i).getNumber()+"本");
                System.out.println("你还能借"+(3-student.get(id).getBorrowNumber())+"本书");
            }
        }
    }
    //查询书籍是否存在,存在则返回true
    public static Boolean judgeExist(ArrayList<Book> book,String bookName){
        Iterator<Book> it=book.iterator();
        while(it.hasNext()){
            if(it.next().getBookName().equals(bookName)){
                return true;
            }
        }
        return false;
    }
    //获取存储书籍的序列号
    public static int getIndex(ArrayList<Book> book,String bookName){
        Iterator<Book> it=book.iterator();
        int index=-1;
        while(it.hasNext()){
            index++;
            if(it.next().getBookName().equals(bookName)){
                return index;
            }
        }
        return -1;
    }
}