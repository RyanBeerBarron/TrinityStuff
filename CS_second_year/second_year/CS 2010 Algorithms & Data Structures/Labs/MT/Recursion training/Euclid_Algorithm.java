
public class Euclid_Algorithm 
{
	public static int iterativeGCD(int x, int y)
	{
		while( x != 0 && y != 0 )
		{
			if( x > y )
				x = x % y;
			else y = y % x;
		}
		return ((x == 0) ? y : x);
	}
	
	public static int recursiveGCD(int x, int y)
	{
		if (x == 0) return y;
		if (y == 0) return x;
		if (x > y) return recursiveGCD(x%y, y);
		else return recursiveGCD(x, y%x);
	}
	
	
	public static void main(String[] args)
	{
		System.out.println(iterativeGCD(36, 48));
		System.out.println(iterativeGCD(36, 48));
	}
}	