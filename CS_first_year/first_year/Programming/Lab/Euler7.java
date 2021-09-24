package euler;

public class Euler7 
{

	public static void main(String[] args) 
	{
		int primeCount=0;
		int number=0;
		for(int i=1;primeCount<10001;i++)
		{
			if(Euler3.isPrime(i))
			{
				primeCount++;
				number=i;
			}
		}
		System.out.print(number);
	}

}
