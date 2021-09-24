package cointoss;
import java.util.Random;

public class CoinToss 
{
	public static final int MAX_TOSSES = 10000;
	public static final int HEADS = 1;
	
	public static void main(String[] args) 
	{
		Random generator = new Random();
		int countTosses;
		int countHeads = 0;
		int countTails = 0;
		int coinFlip = 0;
		
		for ( countTosses = 0; countTosses < MAX_TOSSES; countTosses++)
		{
			coinFlip = generator.nextInt(2);
			if (coinFlip==HEADS)
				countHeads++;
			else countTails++;
		}
		System.out.println(countHeads + " heads were tossed and " + countTails + " tails were tossed.");
		System.out.println("The last toss was " + ((coinFlip == HEADS) ? "heads." : "tails."));
	}

}
