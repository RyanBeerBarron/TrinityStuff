// -------------------------------------------------------------------------
/**
 *  This class contains only two static methods that search for points on the
 *  same line in three arrays of integers. 
 *
 *  @author  
 *  @version 03/10/16 17:10:35
 */
class Collinear
{

   // ----------------------------------------------------------
    /**
     * Counts for the number of non-hoizontal lines that go through 3 points in arrays a1, a2, a3.
     * This method is static, thus it can be called as Collinear.countCollinear(a1,a2,a3)
     * @param a1: An UNSORTED array of integers. Each integer a1[i] represents the point (a1[i], 1) on the plain.
     * @param a2: An UNSORTED array of integers. Each integer a2[i] represents the point (a2[i], 2) on the plain.
     * @param a3: An UNSORTED array of integers. Each integer a3[i] represents the point (a3[i], 3) on the plain.
     * @return the number of points which are collinear and do not lie on a horizontal line.
     *
     * Array a1, a2 and a3 contain points on the horizontal line y=1, y=2 and y=3, respectively.
     * A non-horizontal line will have to cross all three of these lines. Thus
     * we are looking for 3 points, each in a1, a2, a3 which lie on the same
     * line.
     *
     * Three points (x1, y1), (x2, y2), (x3, y3) are collinear (i.e., they are on the same line) if
     * 
     * x1(y2−y3)+x2(y3−y1)+x3(y1−y2)=0 
     *
     * In our case y1=1, y2=2, y3=3.
     *
     * You should implement this using a BRUTE FORCE approach (check all possible combinations of numbers from a1, a2, a3)
     *
     * ----------------------------------------------------------
     *
     * Experimental Performance:
     * -------------------------
     *  Write the running time of the algorithm when run with the following input sizes
     *  
     *  Input Size N      Running Time (sec)
     *  ------------------------------------
     *  1000              0.274
     *  2000              2.126
     *  4000              16.909
     *
     *  Assuming that the running time of your algorithm is of the form aN^b,
     *  estimate 'b' and 'a' by fitting a line to the experimental points:
     *
     *  b = 2.974
     *  a = 2^(-31.509)
     *
     *  What running time do you predict using your results for input size 5000?
     *  What is the actual running time you get with such an input?
     *  What is the error in percentage?
     *
     *  Error = ( (Actual time) - (Predicted time) ) * 100 / (Predicted time)
     *
     *  Input Size N      Predicted Running Time (sec)        Actual Running Time (sec)       Error (%)
     *  ------------------------------------------------------------------------------------------------
     *  5000              2^(-31.509)*5000^3 = 32.697  			32.921						 Error = (32.921-32.697)/32.697 = 0.6%
     * 
     *  Order of Growth
     *  -------------------------
     *
     *  Caclulate and write down the order of growth of your algorithm. You can use the asymptotic notation.
     *  You should adequately explain your answer. Answers without adequate explanation will not be counted.
     *
     *  Order of growth: O(N^3)
     *
     *  Explanation: There are 3 nested for loops and inside them is executed a constant operation.
     */
    static int countCollinear(int[] a1, int[] a2, int[] a3)
    {
    	int total = 0;
    	for ( int i = 0; i<a1.length;i++)
    	{
    		for( int j = 0; j<a2.length;j++)
    		{
    			for( int k = 0; k<a3.length;k++)
    			{
    				if((a1[i]*(2-3)+a2[j]*(3-1)+a3[k]*(1-2))==0)
    					total++;
    			}
    		}
    	}
      return total;
    }

    // ----------------------------------------------------------
    /**
     * Counts for the number of non-hoizontal lines that go through 3 points in arrays a1, a2, a3.
     * This method is static, thus it can be called as Collinear.countCollinearFast(a1,a2,a3)
     * @param a1: An UNSORTED array of integers. Each integer a1[i] represents the point (a1[i], 1) on the plain.
     * @param a2: An UNSORTED array of integers. Each integer a2[i] represents the point (a2[i], 2) on the plain.
     * @param a3: An UNSORTED array of integers. Each integer a3[i] represents the point (a3[i], 3) on the plain.
     * @return the number of points which are collinear and do not lie on a horizontal line.
     *
     * In this implementation you should make non-trivial use of InsertionSort and Binary Search.
     * The performance of this method should be much better than that of the above method.
     *
     * Experimental Performance:
     * -------------------------
     *  Measure the running time of the algorithm when run with the following input sizes
     *  
     *  Input Size N      Running Time (sec)
     *  ------------------------------------
     *  1000              0.035
     *  2000              0.155
     *  4000              0.646
     *  5000              1.057
     *
     *
     *  Compare Implementations:
     *  ------------------------
     *  Show the speedup achieved by this method, using the times you got from your experiments.
     *
     *  Input Size N      Speedup = (time of countCollinear)/(time of countCollinearFast)
     *  ---------------------------------------------------------------------------------
     *  1000              Speedup = 0.262/0.035 = 7.48
     *  2000              Speedup = 2.143/0.155 = 13.82
     *  4000              Speedup = 16.957/0.646 = 26.249
     *  5000              Speedup = 32.889/1.057 = 31.115
     *
     *
     *  Order of Growth
     *  -------------------------
     *
     *  Calculate and write down the order of growth of your algorithm. You can use the asymptotic notation.
     *  You should adequately explain your answer. Answers without adequate explanation will not be counted.
     *
     *  Order of Growth: O(N^2*log(N))
     *
     *  Explanation: There are 2 nested for loops and inside of that is executed the binary search algorithm which has a log(n) order of growth. 
     *  Therefore the binary search algorithm is executed N^2, so the order of growth is N^2logN. Also the insertion sort algorithm is O(N^2) in the worst case.
     *  It is a lower order of growth and since it is added to that of loops, it doesn't matter,
     *
     *
     */
    static int countCollinearFast(int[] a1, int[] a2, int[] a3)
    {
    	int total = 0;
    	sort(a3);
    	for(int i = 0;i<a1.length;i++)
    	{
    		for(int j = 0;j<a2.length;j++)
    		{
    			if(binarySearch(a3, (-a1[i]*(2-3)-a2[j]*(3-1))/(1-2)))
    			{
    				total++;
    			}
    		}
    	}
      return total;
    }

    // ----------------------------------------------------------
    /**
     * Sorts an array of integers according to InsertionSort.
     * This method is static, thus it can be called as Collinear.sort(a)
     * @param a: An UNSORTED array of integers. 
     * @return after the method returns, the array must be in ascending sorted order.
     *
     * ----------------------------------------------------------
     *
     * Approximate Mathematical Performance:
     * -------------------------------------
     *  Using an appropriate cost model, give the performance of your algorithm.
     *  Explain your answer.
     *
     *  Performance: O(N^2)
     *
     *  Explanation: In the worst case scenario, a[i]>a[i+1] is always true, so the algorithm is just two nested loops and the order of growth for that is N^2.
     *
     */
    static void sort(int[] a)
    {
    	for ( int j = 1; j<a.length; j++)
    	{
    		int i = j - 1;
    		while(i>=0 && a[i]>a[i+1])
    		{
    			int temp = a[i];
    			a[i] = a[i+1];
    			a[i+1] = temp;
    			i--;
    		}
    	}
    }

    // ----------------------------------------------------------
    /**
     * Searches for an integer inside an array of integers.
     * This method is static, thus it can be called as Collinear.binarySearch(a,x)
     * @param a: A array of integers SORTED in ascending order.
     * @param x: An integer.
     * @return true if 'x' is contained in 'a'; false otherwise.
     *
     * ----------------------------------------------------------
     *
     * Approximate Mathematical Performance:
     * -------------------------------------
     *  Using an appropriate cost model, give the performance of your algorithm.
     *  Explain your answer.
     *
     *  Performance: O(log(N))
     *
     *  Explanation: In the worst case scenario, the algorithm has to divide by 2 mid every time and the condition of the while loop, hi and low, are redefined
     *  based on mid. So every iteration of the loop, the condition are divided by 2.
     *
     */
    static boolean binarySearch(int[] a, int x)
    {
    	int low = 0;
    	int hi = a.length-1;
    	while (low <=hi)
    	{
    		int mid = (hi+low)/2;
    		if(a[mid]>x)
    			hi = mid-1;
    		else if(a[mid]<x)
    			low = mid+1;
    		else return true;
    	}
      return false;
    }
}
