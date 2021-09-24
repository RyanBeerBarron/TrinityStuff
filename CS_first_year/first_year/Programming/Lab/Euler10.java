package euler;

public class Euler10 
{

	public static void main(String[] args) 
	{
		long total=0;
		for(int i =2; i<2000000; i++)
		{
			if(Euler3.isPrime(i))
				total+=i;
		}
		System.out.print(total);
	}

}
