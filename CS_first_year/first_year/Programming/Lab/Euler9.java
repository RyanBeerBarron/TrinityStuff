package euler;

public class Euler9 
{

	public static void main(String[] args)
	{
		int a=0;
		int b=0;
		double c=0;
		double total=0;
		for(a =1; a<400; a++)
		{
			for(b=a+1; b<499; b++)
			{
				total=Math.pow(a,2)+Math.pow(b,2);
				c=Math.sqrt(total);
				if(c==Math.floor(c))
				{
					total = c+a+b;
					if(total ==1000 || total == 12)
						System.out.println((int)(a*b*c));
				}
				
			}
		}
	}

}
