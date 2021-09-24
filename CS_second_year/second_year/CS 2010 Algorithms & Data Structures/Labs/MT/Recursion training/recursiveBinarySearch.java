import java.util.Arrays;

public class recursiveBinarySearch 
{
	
	public static int recursionBinarySearch(int[] a, int x)
	{
		if ( a[(a.length/2)] == x ) return a.length/2;
		if ( a[(a.length/2)] > x ) return recursionBinarySearch(Arrays.copyOfRange(a, 0, a.length/2), x);
		else return (recursionBinarySearch(Arrays.copyOfRange(a, a.length/2+1, a.length), x)+1)*2;
	}
	
	
	
	
	
	
	public static void main(String[] args) 
	{
		int a[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
		System.out.println(recursionBinarySearch(a, 9));
	}

}
