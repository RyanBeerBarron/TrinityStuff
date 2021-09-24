package euler;

public class Euler6 
{

	public static void main(String[] args) 
	{
		int total1=0;
		int total2=0;
		for(int i = 1; i<101;i++)
		{
			total1+=Math.pow(i,2);
		}
		for(int i=0;i<101;i++)
		{
			total2+=i;
		}
		total2=(int)Math.pow(total2,2);
		System.out.print(total2-total1
				);
	}

}
