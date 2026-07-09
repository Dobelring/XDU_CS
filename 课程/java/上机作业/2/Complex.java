import java.util.Scanner;

public class Complex {

    private double real;   //实部
    private double image;   //虚部

    //无参构造函数
    Complex()
    {
        Scanner input = new Scanner(System.in);
        real = input.nextDouble();
        image = input.nextDouble();
    }

    //有参构造函数
    Complex(double m_real,double m_image)
    {
        real = m_real;
        image = m_image;
    }

    //实部和虚部的getter和setter方法
    public double getReal()
    {
        return real;
    }

    public double getImage()
    {
        return image;
    }

    public void setReal(double m_real)
    {
        this.real = m_real;
    }

    public void setImage(double m_image)
    {
        this.image = m_image;
    }

    public Complex Add(Complex a)
    {
        double a_real = a.getReal();
        double a_image = a.getImage();
        double b_real = this.real;
        double b_image = this.image;
        double c_real = a_real+b_real;
        double c_image = a_image+b_image;
        Complex result = new Complex(c_real,c_image);
        return result;
    }

    public Complex Sub(Complex a)
    {
        double a_real = a.getReal();
        double a_image = a.getImage();
        double b_real = this.real;
        double b_image = this.image;
        double c_real = b_real-a_real;
        double c_image = b_image-a_image;
        Complex result = new Complex(c_real,c_image);
        return result;
    }

    public Complex Mul(Complex a)
    {
        double a_real = a.getReal();
        double a_image = a.getImage();
        double b_real = this.real;
        double b_image = this.image;
        double c_real = (a_real*b_real) - (a_image*b_image);
        double c_image = (a_real*b_image) + (a_image*b_real);
        Complex result = new Complex(c_real,c_image);
        return result;
    }

    public Complex Div(Complex a)
    {
        double a_real = a.getReal();
        double a_image = a.getImage();
        double b_real = this.real;
        double b_image = this.image;
        double c_real = ((a_real*b_real)+(a_image*b_image))/(a_real*a_real+a_image*a_image);
        double c_image = ((b_image*a_real)-(b_real*a_image))/(a_real*a_real+a_image*a_image);
        Complex result = new Complex(c_real,c_image);
        return result;
    }

    public void print()//当复数的虚部为负数时，避免多打印出一个"+"
    {
        if(image>0)
        {
            System.out.println(real+"+"+image+"i");
        }
        else if(image<0)
        {
            System.out.println(real+""+image+"i");
        }
        else
        {
            System.out.println(real);
        }
    }

    public static void main(String[] args)
    {
        Scanner input = new Scanner(System.in);
        System.out.println("请输入第一个复数的实部和虚部:");
        Complex a = new Complex();
        System.out.println("请输入第二个复数的实部和虚部:");
        Complex b = new Complex();
        System.out.print("第一个复数:");
        a.print();
        System.out.print("第二个复数:");
        b.print();
        System.out.println("请选择要进行的运算");
        System.out.println("1:加法");
        System.out.println("2:减法");
        System.out.println("3:乘法");
        System.out.println("4:除法");
        int n = input.nextInt();

            switch(n) {
                case 1:
                    Complex result = a.Add(b);
                    System.out.print("加法的结果为:");
                    result.print();
                    break;
                case 2:
                    result = a.Sub(b);
                    System.out.print("减法的结果为:");
                    result.print();
                    break;
                case 3:
                    result = a.Mul(b);
                    System.out.print("乘法的结果为:");
                    result.print();
                    break;
                case 4:
                    result = a.Div(b);
                    System.out.print("除法的结果为:");
                    result.print();
                    break;
                default:
                    System.out.print("请重新输入");
            }
    }
}


