package introduction_programming;
import java.awt.Color;
import java.awt.Font;
import java.util.Scanner;
public class Sieve
{
	public static final Color[] COLOR_ARRAY = {Color.GRAY, Color.BLUE, Color.RED, Color.GREEN, Color.CYAN, 
			Color.ORANGE, Color.MAGENTA, Color.PINK, Color.YELLOW};
	public static final Font SANS_SHERIF_12_PTS = new Font("SansSerif", Font.PLAIN, 12);
	public static final int DELAY = 50;
	public static final double SQUARE_MATRICE_SIDE_LENGTH = 0.67;
	public static double spaceInBetween;
	public static double squareRadius;
	public static int primeCount=0;
	public static int numberOfSquareOnEachSide;
	
	public static void main(String[] args)
	{
		StdDraw.setFont(SANS_SHERIF_12_PTS);
		int userInput = 0;
		Scanner input = new Scanner(System.in);
		while(userInput<2)
		{
			input = new Scanner(System.in);
			System.out.println("Enter integer number higher or equal to 2, N=");
			if(input.hasNextInt())
				userInput = input.nextInt();
			else System.out.println("Invalid input, please enter integer number higher than 2.");
		}
		input.close();
		numberOfSquareOnEachSide=(int)Math.sqrt(userInput);
		spaceInBetween = SQUARE_MATRICE_SIDE_LENGTH/numberOfSquareOnEachSide;
		squareRadius = SQUARE_MATRICE_SIDE_LENGTH/numberOfSquareOnEachSide/2;
		boolean[] isPrime = sieve(userInput);
		String onlyPrimesToPrint = nonCrossedOutSubseqToString(isPrime);
		System.out.println(onlyPrimesToPrint);
	}
	public static boolean[] createSequence(int maxNumber)
	{
		boolean[] isPrime = new boolean[(maxNumber-1)];
		for(int index=0; index<isPrime.length; index++)
		{
			isPrime[index]=true;
		}
		String fullSequence=sequenceToString(isPrime);
		System.out.println(fullSequence);
		return isPrime;
	}
	public static void crossOutHigherMultiples(int prime, boolean[] isPrime)
	{
		if(isPrime!=null)
		{
			boolean colorTheSquare = false;
			for(int index=prime-2; index<isPrime.length; index+=prime)
			{
				if (isPrime[index]==true)
					displayComposite(index+2, isPrime.length+1);
				if ( colorTheSquare==true)
					isPrime[index] = false;
				colorTheSquare=true;
			}
			String allNumbersToPrint = sequenceToString(isPrime);
			System.out.println(allNumbersToPrint);
		}
	}
	public static boolean[] sieve(int maxNumber)
	{
		boolean[] isPrime=createSequence(maxNumber);
		displayNumbers2ToN(maxNumber);
		for(int index =0; index+2<=(Math.sqrt(maxNumber)+1); index++)
		{
			if(isPrime[index]==true)
			{	
				primeCount++;
				displayPrime(index+2, maxNumber);
				crossOutHigherMultiples(index+2, isPrime);
			}
		}
		for(int index = (int)Math.sqrt(maxNumber); index<isPrime.length; index++)
		{
			if(isPrime[index]==true)
			{
				primeCount++;
				displayPrime(index+2, maxNumber);
			}
		}
		return isPrime;
	}
	public static String sequenceToString(boolean[] primeCrossedOut)
	{
		if(primeCrossedOut!=null)
		{
			String primesAndNonPrimes ="2";
			for(int index=1; index<primeCrossedOut.length; index++)
			{
				if (primeCrossedOut[index]==false)
					primesAndNonPrimes = primesAndNonPrimes +", [" + (index+2) +"]";
				else primesAndNonPrimes = primesAndNonPrimes +", " + (index+2);
			}
			return primesAndNonPrimes;
		}
		return null;
	}
	public static String nonCrossedOutSubseqToString(boolean[] primeCrossedOut)
	{
		if(primeCrossedOut!=null)
		{
			String allPrimes ="The prime numbers are: 2";
			for(int index=1; index<primeCrossedOut.length; index++)
			{
				if (primeCrossedOut[index]==true)
					allPrimes = allPrimes +", "+ (index+2);
			}
			return allPrimes;
		}
		return null;
	}
	public static void displayNumber(int number, Color color, int maxNumber)
	{
		StdDraw.setPenColor(color);
		StdDraw.filledSquare(0+squareRadius+((number-1)%numberOfSquareOnEachSide*spaceInBetween),
				1.0-squareRadius-((number-1)/numberOfSquareOnEachSide*spaceInBetween), squareRadius);
		color = Color.BLACK;
		StdDraw.setPenColor(color);
		StdDraw.text(0+squareRadius+((number-1)%numberOfSquareOnEachSide*spaceInBetween),
				1.0-squareRadius-((number-1)/numberOfSquareOnEachSide*spaceInBetween), Integer.toString(number) );
	}
	public static void displayComposite(int compositeNumber, int maxNumber)
	{
		Color color = COLOR_ARRAY[primeCount%COLOR_ARRAY.length];
		StdDraw.setPenColor(color);
		StdDraw.filledSquare(0+squareRadius+((compositeNumber-1)%numberOfSquareOnEachSide*spaceInBetween),
				1.0-squareRadius-((compositeNumber-1)/numberOfSquareOnEachSide*spaceInBetween),
				squareRadius);
		color = Color.BLACK;
		StdDraw.setPenColor(color);
		StdDraw.text(0+squareRadius+((compositeNumber-1)%numberOfSquareOnEachSide*spaceInBetween),
				1.0-squareRadius-((compositeNumber-1)/numberOfSquareOnEachSide*spaceInBetween),
				Integer.toString(compositeNumber) );
		StdDraw.show(DELAY);
	}
	public static void displayPrime(int prime, int maxNumber)
	{
		StdDraw.setPenColor(Color.BLACK);
		StdDraw.text(0.85, 0.95, "Prime numbers:");
		int squareSideOfPrimes =(int) Math.sqrt(maxNumber/Math.log(maxNumber));
		StdDraw.text(0.7+((primeCount-1)%squareSideOfPrimes*spaceInBetween), 
				0.9-((primeCount-1)/squareSideOfPrimes*spaceInBetween), Integer.toString(prime));
		StdDraw.show(DELAY);
	}
	public static void displayNumbers2ToN(int maxNumber)
	{
		Color color = Color.DARK_GRAY;
		for (int number =2; number<=maxNumber; number++ )
		{
			displayNumber(number, color, maxNumber);
		}
	}
}
