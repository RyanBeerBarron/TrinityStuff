package euler;

public class Euler17
{
	public static final int ONE_STRING_LENGTH = 3;
	public static final int TWO_STRING_LENGTH = 3;
	public static final int THREE_STRING_LENGTH = 5;
	public static final int FOUR_STRING_LENGTH = 4;
	public static final int FIVE_STRING_LENGTH = 4;
	public static final int SIX_STRING_LENGTH = 3;
	public static final int SEVEN_STRING_LENGTH = 5;
	public static final int EIGHT_STRING_LENGTH = 5;
	public static final int NINE_STRING_LENGTH = 4;
	public static final int TEN_STRING_LENGTH = 3;
	public static final int ELEVEN_STRING_LENGTH = 6;
	public static final int TWELVE_STRING_LENGTH = 6;
	public static final int THIRTEEN_STRING_LENGTH = 8;
	public static final int FOURTEEN_STRING_LENGTH = 8;
	public static final int FIFTEEN_STRING_LENGTH = 7;
	public static final int SIXTEEN_STRING_LENGTH = 7;
	public static final int SEVENTEEN_STRING_LENGTH = 9;
	public static final int EIGHTEEN_STRING_LENGTH = 8;
	public static final int NINETEEN_STRING_LENGTH = 8;
	public static final int TWENTY_STRING_LENGTH = 6;
	public static final int THIRTY_STRING_LENGTH = 6;
	public static final int FORTY_STRING_LENGTH = 5;
	public static final int FIFTY_STRING_LENGTH = 5;
	public static final int SIXTY_STRING_LENGTH = 5;
	public static final int SEVENTY_STRING_LENGTH = 7;
	public static final int EIGHTY_STRING_LENGTH = 6;
	public static final int NINETY_STRING_LENGTH = 6;
	public static final int HUNDRED_STRING_LENGTH = 7;
	public static final int AND_STRING_LENGTH = 3;
	public static final int THOUSAND_STRING_LENGTH = 8;
	public static void main(String[] args)
	{
		int temp = 0;
		int sum =0;
		int powerOfTen = 0;
		boolean leadingZero=true;
		for(int i=1000; i>0; i--)
		{
			leadingZero = true;
			powerOfTen=0;
			if(i>999)
				powerOfTen=3;
			else if(i>99)
				powerOfTen=2;
			else if(i>9)
				powerOfTen=1;
			else powerOfTen=0;
			do
			{
				temp = (int)Math.pow(10,powerOfTen);
				if(powerOfTen==3)
				{	
					
				}	
				powerOfTen--;
			}while(powerOfTen>0);
		}
	}
	public static int digitStringLength(int digit, int powerOfTen )
	{
		return 10;
	}

}























