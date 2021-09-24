package highlow;
import java.util.Scanner;
import java.util.Random;

public class Highlow 
{
	public static final int NUMBER_OF_CARDS_IN_DECK = 52;
	public static final int NUMBER_OF_WINS_IN_A_ROW = 4;
	public static final int ACE_VALUE = 1;
	public static final int TWO_VALUE = 2;
	public static final int THREE_VALUE = 3;
	public static final int FOUR_VALUE = 4;
	public static final int FIVE_VALUE = 5;
	public static final int SIX_VALUE = 6;
	public static final int SEVEN_VALUE = 7;
	public static final int EIGHT_VALUE = 8;
	public static final int NINE_VALUE = 9;
	public static final int TEN_VALUE = 10;
	public static final int JACK_VALUE = 11;
	public static final int QUEEN_VALUE = 12;
	public static final int KING_VALUE = 13;
	
	public static void main(String[] args) 
	{
		int winsInARow = 0;
		int currentCard = 0;
		int nextCard = 0;
		int currentCardValue = 0;
		int nextCardValue = 0;
		String currentCardName = "";
		String nextCardName = "";
		Random randomNumber = new Random();
		boolean finished = false;
		
		
		System.out.println("Welcome to Higher-Lower card game. Type 'Hi' for higher, 'Lo' for lower, 'Eq' for equal "
				+ "or type 'quit' if you want to stop playing.");
		
		
		currentCard = randomNumber.nextInt(NUMBER_OF_CARDS_IN_DECK + 1);
		if (currentCard <= 4)
		{
			currentCardValue = ACE_VALUE;
			currentCardName = "ace";
		}
		else if (currentCard <= 8)
		{
			currentCardValue = TWO_VALUE;
			currentCardName = "two";
		}
		else if (currentCard <= 12)
		{
			currentCardValue = THREE_VALUE;
			currentCardName = "three";
		}
		else if (currentCard <= 16)
		{
			currentCardName = "four";
			currentCardValue = FOUR_VALUE;
		}
		else if (currentCard <= 20)
		{
			currentCardName = "five";
			currentCardValue = FIVE_VALUE;
		}
		else if (currentCard <=24)
		{
			currentCardName = "six";
			currentCardValue = SIX_VALUE;
		}
		else if (currentCard <=28)
		{
			currentCardName = "seven";
			currentCardValue = SEVEN_VALUE;
		}
		else if (currentCard <= 32)
		{
			currentCardName = "eight";
			currentCardValue = EIGHT_VALUE;
		}
		else if (currentCard <=36)
		{
			currentCardName = "nine";
			currentCardValue = NINE_VALUE;
		}
		else if (currentCard <= 40)
		{
			currentCardName = "ten";
			currentCardValue = TEN_VALUE;
		}
		else if (currentCard <= 44)
		{
			currentCardName = "jack";
			currentCardValue = JACK_VALUE;
		}
		else if (currentCard <= 48)
		{
			currentCardName = "queen";
			currentCardValue = QUEEN_VALUE;
		}
		else
		{
			currentCardName = "king";
			currentCardValue = KING_VALUE;
		}
		if (currentCard % 4 == 0)
			currentCardName += " of hearts";
		else  if (currentCard % 4 == 1 )
			currentCardName += " of clubs";
		else if ( currentCard % 4 == 2 )
			currentCardName += " of spades";
		else if (currentCard % 4 == 3)
			currentCardName +=" of diamonds";
			
			
		while (!finished)
		{
			Scanner input = new Scanner(System.in);
			System.out.println("The current card is " + currentCardName + ".");
			System.out.println("What will the next card be, higher, lower or equal ?");
			
		do	
		{	
			nextCard = randomNumber.nextInt(NUMBER_OF_CARDS_IN_DECK + 1);
		}	while (nextCard == currentCard);
			if (nextCard <= 4)
			{
				nextCardName = "ace";
				nextCardValue = ACE_VALUE;
			}
			else if (nextCard <= 8)
			{
				nextCardName = "two";
				nextCardValue = TWO_VALUE;
			}
			else if (nextCard <= 12)
			{
				nextCardName = "three";
				nextCardValue = THREE_VALUE;
			}
			else if (nextCard <= 16)
			{
				nextCardName = "four";
				nextCardValue = FOUR_VALUE;
			}
			else if (nextCard <= 20)
			{
				nextCardName = "five";
				nextCardValue = FIVE_VALUE;
			}
			else if (nextCard <=24)
			{
				nextCardName = "six";
 				nextCardValue = SIX_VALUE;
			}
			else if (nextCard <=28)
			{
				nextCardName = "seven";
				nextCardValue = SEVEN_VALUE;
			}
			else if (nextCard <= 32)
			{
				nextCardName = "eight";
				nextCardValue = EIGHT_VALUE;
			}
			else if (nextCard <=36)
			{
				nextCardName = "nine";
				nextCardValue = NINE_VALUE;
			}
			else if (nextCard <= 40)
			{
				nextCardName = "ten";
				nextCardValue = TEN_VALUE;
			}
			else if (nextCard <= 44)
			{
				nextCardName = "jack";
				nextCardValue = JACK_VALUE;
			}
			else if (nextCard <= 48)
			{
				nextCardName = "queen";
				nextCardValue = QUEEN_VALUE;
			}
			else 
			{
				nextCardName = "king";
				nextCardValue = KING_VALUE;
			}
			if (nextCard % 4 == 0)
				nextCardName += " of hearts";
			else  if (nextCard % 4 == 1 )
				nextCardName += " of clubs";
			else if ( nextCard % 4 == 2 )
				nextCardName += " of spades";
			else if (nextCard % 4 == 3)
				nextCardName +=" of diamonds";
			
			
			if (nextCardValue > currentCardValue && input.hasNext("Hi"))
			{
				winsInARow++;
				if (winsInARow == NUMBER_OF_WINS_IN_A_ROW)
				{
					System.out.println("Good job, you've won.");
					finished = true;
				}
				else
				{	
					System.out.println("Good guess. The card was " + nextCardName + " and you have "
						+ winsInARow + " wins a row, you need 4 to win.\n");
					currentCard = nextCard;
					currentCardName = nextCardName;
					currentCardValue = nextCardValue;
				}	
			}
			else if (nextCardValue == currentCardValue && input.hasNext("Eq"))
			{
				winsInARow++;
				if (winsInARow == NUMBER_OF_WINS_IN_A_ROW)
				{
					System.out.println("Good job, you've won.");
					finished = true;
				}
				else
				{
					System.out.println("Good guess. The card was " + nextCardName + " and you have "
						+ winsInARow + " wins a row, you need 4 to win.\n");	
					currentCard = nextCard;
					currentCardName = nextCardName;
					currentCardValue = nextCardValue;
				}
			}
			else if (nextCardValue < currentCardValue && input.hasNext("Lo"))
			{
				winsInARow++;
				if (winsInARow == NUMBER_OF_WINS_IN_A_ROW)
				{	
					finished = true;
					System.out.println("Good job, you've won.");
				}
				else
				{
					System.out.println("Good guess. The card was " + nextCardName + " and you have "
						+ winsInARow + " wins a row, you need 4 to win.\n");		
					currentCard = nextCard;
					currentCardName = nextCardName;
					currentCardValue = nextCardValue;
				}
			}
			else if (input.hasNext("quit"))
			{
				finished = true;
				System.out.println("Goodbye, thanks for playing.\n");
			}
			else if (input.hasNext("Hi") || input.hasNext("Lo") || input.hasNext("Eq"))
			{
				System.out.println("Wrong guess, the card was " + nextCardName + " please try again.\n");
				winsInARow = 0;
				currentCard = nextCard;
				currentCardName = nextCardName;
				currentCardValue = nextCardValue;
			}
			else
				System.out.println("Wrong input, please try again.\n");
		}
	}

}
