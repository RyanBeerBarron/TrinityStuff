package euler;

public class Euler3 
{

	public static void main(String[] args)
	{
		long number= 600851475143L;
		int max=0;
		for(int i=2; i<=number; i++)
		{
			if(isPrime(i) || i==2)
			{
				while(number%i==0)
				{
					number=number/i;
					if(max<i)
						max=i;
				}
			}
			;
		}
		System.out.print(max);
	}
	public static boolean isPrime(int number)
	{
		boolean isPrime = true;
		if(number==2)
			return true;
		for(int i=2; i<Math.sqrt(number)+1&&isPrime; i++)
		{
			if(number%i==0)
			{
				isPrime=false;
			}
		}
		return isPrime;
	}
}
