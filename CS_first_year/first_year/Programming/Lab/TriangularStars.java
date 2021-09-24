package assignment;

public class TriangularStars
{

	public static void main(String[] args)
	{
	 int triangularNumber=0;
		for ( int n = 1; triangularNumber >= 0; n++)
		{
			triangularNumber = determineTriangularNumber(n, triangularNumber);
			if (isStarNumber(triangularNumber))
				System.out.println(triangularNumber);
		}
	}

	
	public static int determineTriangularNumber (int n, int previousTriangularNumber)
	{
		if (previousTriangularNumber > Integer.MAX_VALUE-n)
			return -1;
		return (n+previousTriangularNumber);
	}
	
	public static boolean isStarNumber(int triangularNumber)
	{
		int isStarNumber = triangularNumber;
		int result=0;
		for (int n = 0; result < isStarNumber; n++)
		{
			result = 6*n*(n-1)+1;
		}
		return (result == isStarNumber);
	}
	
	
}
