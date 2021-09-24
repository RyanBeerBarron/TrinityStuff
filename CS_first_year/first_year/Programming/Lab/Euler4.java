package euler;

public class Euler4 
{

	public static void main(String[] args)
	{
		int max=0;
		for(int i=1; i<1000; i++)
		{
			for(int j=1; j<1000; j++)
			{
				int total=j*i;
				if(isPalindromic(total)&&total>max)
					max=total;
			}
		}
		System.out.print(max);
	}
	public static boolean isPalindromic(int number)
	{
		return(number==reverseNumber(number));
	}
	public static int reverseNumber(int number)
	{
		int total=0;
		while(number!=0)
		{
			total=total*10;
			total+=number%10;
			number=number/10;
		}
		return total;
	}
}
