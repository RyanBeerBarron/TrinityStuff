package incrementalStatistics;
import java.util.Scanner;

public class IncrementalStatistics
{

	public static void main(String[] args) 
	{
		boolean finished = false;
		double average = 0;
		double variance = 0;
		int numberCounter = 0;
		Scanner input = new Scanner(System.in);
		while (!finished)
		{
			System.out.print("Enter a number (or type 'exit'): ");
			if (input.hasNextInt())
			{
				int number = input.nextInt();
				numberCounter = numberCounter + 1;
				double temporaryAverage = average;		
				average = average + (number - average ) / numberCounter;
				variance = ((variance * (numberCounter - 1)) + 
						(number - temporaryAverage) * (number - average))/numberCounter;
				System.out.println("So far the average is " + average + " and the variance is " + variance +".");
			}
			else if (input.hasNext("exit"))
				finished = true;
			else System.out.println("Not a valid number. Please try again. Type 'exit' to quit.");
		}
		input.close();
		System.out.println("Goodbye.");
	}

}
