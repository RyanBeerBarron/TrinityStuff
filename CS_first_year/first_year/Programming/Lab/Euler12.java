package euler;

public class Euler12 
{

	public static void main(String[] args) 
	{
		long triangularNumber=0;
		boolean fiveHundredDivisors = false;
		for(int i =1; !fiveHundredDivisors; i++)
		{
			triangularNumber=triangularNumber(i);
			if(howManyDivisors(triangularNumber)>=500)
				fiveHundredDivisors=true;
		}
		System.out.print(triangularNumber);
	}
	public static int howManyDivisors(long number)
	{
		int divisorsCount=0;
		if (Math.sqrt(number)==Math.floor(Math.sqrt(number)))
		{
			for(int i=1; i<Math.sqrt(number);i++)
			{
				if(number%i==0)
					divisorsCount+=2;
			}
			return divisorsCount+1;
		}
		else
		{
			for(int i =1; i<=Math.sqrt(number); i++)
			{
			if(number%i==0)
				divisorsCount++;
			}
			return 2*divisorsCount;
		}	
	}
	public static long triangularNumber(int number)
	{
		return number*(number+1)/2;
	}
}
