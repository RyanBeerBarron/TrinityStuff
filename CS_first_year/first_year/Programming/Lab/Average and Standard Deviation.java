package tutorial2;
import java.util.Scanner;


public class tutorial2 {

	public static void main(String[]args){
		
		Scanner inputScanner = new Scanner (System.in);
		System.out.print("Write 3 decimal numbers ");
		double numberOne = inputScanner.nextDouble();
		double numberTwo = inputScanner.nextDouble();
		double numberThree = inputScanner.nextDouble();
		double average = (numberOne+numberTwo+numberThree)/3.0;
		double standardDeviation =
				Math.sqrt(
							((numberOne-average)*(numberOne-average)
							+(numberTwo-average)*(numberTwo-average)
							+(numberThree-average)*(numberThree-average))
																		/3.0);
		inputScanner.close();
		System.out.print("The average of your three numbers is "+average +
				" and the standard deviation is "+standardDeviation);
	}
	
}
