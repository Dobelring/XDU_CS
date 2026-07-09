public class Book {
    String bookName;
    String editor;
    String publisher;
    int number;


    public Book(){

    }

    public Book(String bookName,String editor,String publisher,int number){
        this.bookName = bookName;
        this.editor = editor;
        this.publisher = publisher;
        this.number = number;
    }

    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public String getEditor() {
        return editor;
    }

    public void setEditor(String editor) {
        this.editor = editor;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }
    public void addNumber(int number){
        this.number=this.number+number;
    }
    //以下为借阅归还时方法
    public void subtractNumber(){
        this.number--;
    }
    public void add(){
        this.number++;
    }
}