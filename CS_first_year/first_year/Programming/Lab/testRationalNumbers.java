import java.util.Scanner;
public class testRationalNumbers
{

	public static void main(String[] args) 
	{
		int numerator1=0;
		int numerator2=0;
		int denominator1=1;
		int denominator2=1;
		boolean userInput = false;
		Scanner input = new Scanner(System.in);
		System.out.println("Please enter the numerators.");
		while(!userInput)
		{	
			input = new Scanner(System.in);
			if(input.hasNextInt())
			{
				if(input.hasNextInt())
				{
					numerator1 = input.nextInt();
					numerator2 = input.nextInt();
					userInput = true;
				}
				else System.out.println("Sorry need 2 numerators, please enter 2 numerators");
			}
			else System.out.println("Wrong input, please enter two integer value numerators.");
		}	
		System.out.println("Please enter the denominators.");
		userInput = false;
		while(!userInput)
		{	
			input = new Scanner(System.in);
			if(input.hasNextInt())
			{
				if(input.hasNextInt())
				{
					denominator1 = input.nextInt();
					denominator2 = input.nextInt();
					userInput = true;
				}
				else System.out.println("Sorry need 2 denominators, please enter 2 denominators");
			}
			else System.out.println("Wrong input, please enter two integer value denominators.");
		}
		RationalNumbers number1 = new RationalNumbers(numerator1, denominator1);
		RationalNumbers number2 = new RationalNumbers(numerator2, denominator2);
		input.close();
		System.out.println("Original numbers are: "+ number1.toString() + " " + number2.toString());
		RationalNumbers number3;
		number3 = number1.add(number2);
		System.out.println("Sum is equal to: " + number3.toString() + " "+number1.toString() + " "+ number2.toString());
		System.out.println("Difference is equal to: " + number1.subtract(number2));
		System.out.println("Product is equal to: " + number1.multiply(number2));
		System.out.println("Division is equal to: " + number1.divide(number2));
		if(number1.equal(number2))
			System.out.println("Your two rational numbers are equal.");
		else if (number1.isLessThan(number2))
			System.out.println(number1.toString()+" is less than "+number2.toString());
		else System.out.println(number1.toString()+" is greater than "+number2.toString());
		System.out.println("The irreducible form of your fraction are: "+number1.simplify() + " "+ number2.simplify());
	
	
	
	
	
	
	
	
	
	
	
	}
}
