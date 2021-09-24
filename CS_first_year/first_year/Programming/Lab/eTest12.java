package eTest12;
import java.util.Scanner;

public class eTest12 
{

	public static void main(String[] args)
	{
		System.out.println("Please enter integer number. Type 'quit' to end the program.");
		boolean finished = false;
		while (!finished)
		{
			Scanner input = new Scanner(System.in);
			System.out.print("Enter number:");
			if (input.hasNextInt())
			{	
				int number = input.nextInt();
				String binaryNumber = convertToBinaryString(number);
				if (isBinaryPalindromic(number))
					System.out.println("The number " + number + " in binary is " 
				+ binaryNumber + " which is palindromic");
				else
				System.out.println("The number " + number + " in binary is " + binaryNumber);
			}
			else if (input.hasNext("quit"))
				finished = true;
			else System.out.println("Sorry wrong input.");
		}
	}
	public static String convertToBinaryString(int number)
	{
		if (number == 0)
			return "0";
		boolean positiveNumber=true;
		String binaryNumber="";
		if (number<0)
		{
			number = Math.abs(number);
			positiveNumber=false;
		}
		while (number>0)
		{
			binaryNumber = (number%2) + "" + binaryNumber;
			number = number/2;
		}
		if (!positiveNumber)
			binaryNumber = "-"+binaryNumber;
		return binaryNumber;
	}
	public static int reverseBinaryNumber(int number)
	{
		int reverseBinaryNumber = 0;
		String binaryNumber="";
		if (number<0)
			number = Math.abs(number);
		while (number>0)
		{
			binaryNumber = (number%2) + " " + binaryNumber;
			number = number/2;
		}
		Scanner input = new Scanner(binaryNumber);
		int i = 0;
		while(input.hasNextInt())
		{
			int tempNumber = input.nextInt();
			reverseBinaryNumber += tempNumber * Math.pow(2,i);
			i++;
		}
		input.close();
		return reverseBinaryNumber;
	}
	public static boolean isBinaryPalindromic(int number)
	{
		return (number == reverseBinaryNumber(number));
	}
}
