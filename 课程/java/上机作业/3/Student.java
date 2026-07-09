public class Student {
    int id;
    int borrowNumber;
    String[] bookName={"none","none","none"};
    int n=0;

    public Student(int id, int borrowNumber) {
        this.id = id;
        this.borrowNumber = borrowNumber;
    }

    public Student() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getBorrowNumber() {
        return borrowNumber;
    }

    public void setBorrowNumber(int borrowNumber) {
        this.borrowNumber = borrowNumber;
    }
    //以下为借阅归还时方法
    public void addBorrowNumber(){
        this.borrowNumber++;
    }
    public void subtractBorrowNumber(){
        this.borrowNumber--;
    }
    public void setBookName(String name){
        bookName[n++]=name;
    }
    public void deleteBookName(String name){
        for (int i = 0; i < bookName.length; i++) {
            if(bookName[i].equals(name)){
                bookName[i]="none";
            }
        }
    }
}