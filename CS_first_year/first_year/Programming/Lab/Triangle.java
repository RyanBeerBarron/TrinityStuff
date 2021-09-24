package tutorial2;
import java.util.Scanner;
public class Triangle {
	
	public static void main(String[]args){
		
		System.out.print("Enter the coordinates of the three vertices of your triangle,"
				+ " in this order Ax Ay Bx By Cx Cy");
		Scanner inputScanner = new Scanner(System.in);
		double Ax = inputScanner.nextDouble();
		double Ay = inputScanner.nextDouble();
		double Bx = inputScanner.nextDouble();
		double By = inputScanner.nextDouble();
		double Cx = inputScanner.nextDouble();
		double Cy = inputScanner.nextDouble();
		double area =(Ax*(By-Cy)+Bx*(Cy-Ay)+Cx*(Ay-By)/2);
		System.out.print("Your triangle area is "+ area);
		inputScanner.close();
	}

}
