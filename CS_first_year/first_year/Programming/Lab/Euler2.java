package euler;

public class Euler2
{
	public static void main(String[] args)
	{
		int fib1=1;
		int fib2=1;
		int temp;
		int sum=0;
		
		while(fib2+fib1<4000000)
		{
			temp = fib2;
			fib2+=fib1;
			fib1=temp;
			if(fib2%2==0)
				sum+=fib2;
		}
		System.out.print(sum);
	}

}
