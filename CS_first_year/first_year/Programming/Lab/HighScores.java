
package assignment;
import java.util.Scanner;

public class HighScores
{
	public static final int MINIMUM_SCORE = 0;
	public static void main(String[] args)
	{
		boolean finished = false;
		int length=0;
		while (!finished)
		{
			System.out.println("Please enter the integer number ( greater than zero ) of scores you want to maintain."
					+ "\nOr type 'quit' to end the program");
			Scanner input = new Scanner(System.in);
			if (input.hasNextInt())
			{
				length = input.nextInt();
				if ( length > 0)
					finished = true;
				else System.out.println("Invalid number, please enter integer number greater than zero.");
			}
			else if (input.hasNext("quit"))
				finished = true;
			else System.out.println("Wrong input, try again.");
		}
		double[] scores = new double[length];
		initialiseHighScores(scores);
		finished = false;
		while (!finished)
		{
			System.out.println("Enter new score. Type 'reset' to initialise all the scores back to 0."
					+ " Type 'print' to print out all the scores. Type 'quit' to end the program.");
			Scanner input = new Scanner(System.in);
			if (input.hasNext("reset"))
				initialiseHighScores(scores);
			else if (input.hasNextDouble())
			{
				double newScore = input.nextDouble();
				if (higherThan(scores, newScore))
					insertScore(scores, newScore);
			}
			else if (input.hasNext("print"))
				printHighScores(scores);
			else if (input.hasNext("quit"))
				finished = true;
			else System.out.println("Sorry, wrong input.");
			
		}
	}
	public static void initialiseHighScores(double[] scores)
	{
		for ( int index = 0; index<scores.length; index++)
		{
			scores[index]= MINIMUM_SCORE;
		}
	}
	public static void printHighScores(double[] scores)
	{
		for ( int index = 0; index<scores.length; index++)
		{
			System.out.println(scores[index]);
		}
	}
	public static boolean higherThan(double[] scores, double newScore)
	{
		boolean higherThan = false;
		for ( int index = 0; index<scores.length && !higherThan; index++)
		{
			if ( newScore > scores[index])
				higherThan = true;
		}
		return higherThan;
	}
	public static void insertScore(double[] scores, double newScore)
	{
		int index = 0;
		for ( index=0; newScore<scores[index]; index++)
		{
		}
		double temp[]= new double[scores.length];
		temp[index]=scores[index];
		scores[index]=newScore;
		index++;
		while (index<scores.length)
		{
			temp[index]=scores[index];
			scores[index]=temp[index-1];
			index++;
		}
	}
}
