/**
 * 
 */

/**
 * @author barronry
 *
 */
import java.util.Scanner;

public class BodyMassIndex {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Scanner input = new Scanner(System.in);
		System.out.print("What is your weight? (in kilograms) ");
		double weight = input.nextDouble();
		System.out.print("What is your height? (in meters) ");		
		double height = input.nextDouble();
		double BMI = weight / height / height;
		System.out.print("Your body mass index is "+ BMI);
		input.close();
	}

}
