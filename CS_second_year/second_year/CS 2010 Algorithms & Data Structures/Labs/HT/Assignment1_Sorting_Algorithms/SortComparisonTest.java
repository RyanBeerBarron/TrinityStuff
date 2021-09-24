import static org.junit.Assert.*;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;
import java.util.Arrays;

//-------------------------------------------------------------------------
/**
 * Timing done using System.nanoTime()
 * 					|Insert 	|	Quick median pivot  | Quick random pivot|Merge top down	| Merge bottom up	| Shell 	| Selection | Bubble
10 random			|9124		|		29366			|	227512			|	7698		|		9123		| 7128		| 5702* 	| 5702			
100 random			|223520		|		74127			|	312472			|	75267		|		76122		| 62153*	| 156522	| 244617			
1000 random			|8455845	|		676263			|	689377			|	624944		|		212971*		| 767209	| 3759071	| 6077807		
10000 random		|79016911	|		2691649			|	2802269			|	2107760*	|		2200704		| 5628201	| 42602812	| 115457525
100000 random		|5196215270	|		23722493		|	13699443*		|	13885900	|		15422885	| 20295565	| 3540944800| 13183729221
1000 few unique		|5142957	|		620667			|	674267			|	603562		|		211831*		| 721023	| 3733697	| 6791703								
10000 few unique	|60205302	|		5577738			|	8072952			|	2675114		|		2108901*	| 4679951	| 41682502	| 116595653
1000 nearly ordered	|2679960	|		600425			|	637488			|	510904		|		448181*		| 573341	| 4047025	| 5672677							
1000 reverse order	|6358348	|		531715			|	797431			|	517461		|		174198*		| 455878	| 3691503	| 6739244
10000 reverse order	|130138574	|		2427930			|	3215667			|	2728712		|		3056580		| 4407679	| 46216481	| 87695990
1000 sorted			|40770		|		410262			|	1676115			|	163934*		|		612970		| 202137	| 3743961	| 3962635
10000 sorted		|362935		|		112071*			|	3684090			|	511474		|		1981460		| 2613246	| 41977297	| 26544434
 * 
 * 	1. The size of the input file has an impact on insertion sort, selection sort and on bubble sort because they growth order are bigger, N^2 and not n*log(n)
 * 	2. Insertion sort has the biggest difference between the best and worst case. Insertion has linear time when the list is almost sorted but reverts to N^2 in the worst case scenario.
 *  Test class for SortComparison.java
 *  3. Quick sort and merge sort have the best scalability, bubble sort has the worst scalability.
 *  4. 
 *  @author
 *  @version HT 2018
 */
@RunWith(JUnit4.class)
public class SortComparisonTest
{
	//public static final String S = "numbers10000.txt";
    //~ Constructor ........................................................
    @Test
    public void testConstructor()
    {
        new SortComparison();
    }

    //~ Public Methods ........................................................

    // ----------------------------------------------------------
    /**
     * Check that the methods work for empty arrays
     */
    @Test
    public void testEmpty()
    {
    }

    @Test
    public void testInsertionSort()
    {
    		double[] a = new double[100];
    		SortComparison.generateNumber(a);
            double[] b = a.clone();
            Arrays.sort(a);
            assertEquals("Array b should be sorted like array a.", Arrays.toString(a), Arrays.toString(SortComparison.insertionSort(b)));
    }

    @Test
    public void testQuickSort()
    {
		double[] a = new double[100];
		SortComparison.generateNumber(a);      
		double[] b = a.clone();
        double[] c = a.clone();
        Arrays.sort(a);
        assertEquals("Array b should be sorted like array a.", Arrays.toString(a), Arrays.toString(SortComparison.quickSort(b, true)));
        assertEquals("Array c should be sorted like array a.", Arrays.toString(a), Arrays.toString(SortComparison.quickSort(c, false)));
    }

    @Test
    public void testMergeSort()
    {
		double[] a = new double[100];
		SortComparison.generateNumber(a);
		double[] b = a.clone();
        double[] c = a.clone();
        Arrays.sort(a);

        assertEquals("Array b should be sorted like array a.", Arrays.toString(a), Arrays.toString(SortComparison.mergeSort(b, true)));
        assertEquals("Array c should be sorted like array a.", Arrays.toString(a), Arrays.toString(SortComparison.mergeSort(c, false)));
    }

    @Test
    public void testShellSort()
    {
		double[] a = new double[100];
		SortComparison.generateNumber(a);
		double[] b = a.clone();
        Arrays.sort(a);
        assertEquals("Array b should be sorted like array a.", Arrays.toString(a), Arrays.toString(SortComparison.shellSort(b)));   
    }

    @Test
    public void testBadShellSort()
    {
		double[] a = new double[100];
		SortComparison.generateNumber(a);
		double[] b = a.clone();
        Arrays.sort(a);
        assertEquals("Array b should be sorted like array a.", Arrays.toString(a), Arrays.toString(SortComparison.badShellSort(b)));
    }

    @Test
    public void testSelectionSort()
    {
		double[] a = new double[100];
		SortComparison.generateNumber(a);
		double[] b = a.clone();
        Arrays.sort(a);
        assertEquals("Array b should be sorted like array a.", Arrays.toString(a), Arrays.toString(SortComparison.selectionSort(b)));   
    }

    @Test
    public void testBubbleSort()
    {
		double[] a = new double[100];
		SortComparison.generateNumber(a);
		double[] b = a.clone();
        Arrays.sort(a);
        assertEquals("Array b should be sorted like array a.", Arrays.toString(a), Arrays.toString(SortComparison.bubbleSort(b)));
    }

    
    @Test
    public void testMedian()
    {
    	assertEquals("Median should be 2", "2", Integer.toString(SortComparison.median(1,2,3)));
    	assertEquals("Median should be 2", "2", Integer.toString(SortComparison.median(3,1,2)));
    	assertEquals("Median should be 2", "2", Integer.toString(SortComparison.median(2,1,3)));
    	assertEquals("Median should be 2", "2", Integer.toString(SortComparison.median(1,3,2)));
    	assertEquals("Median should be 2", "2", Integer.toString(SortComparison.median(3,2,1)));
    	assertEquals("Median should be 2", "2", Integer.toString(SortComparison.median(2,3,1)));
    }

    // TODO: add more tests here. Each line of code and ech decision in Collinear.java should
    // be executed at least once from at least one test.

    // ----------------------------------------------------------
    /**
     *  Main Method.
     *  Use this main method to create the experiments needed to answer the experimental performance questions of this assignment.
     *
     *
    public static void main(String[] args)
    {
    	
    	long startTime;
    	long endTime;
    	In in = new In(S);
    	double[] a = in.readAllDoubles();
    	
    			SortComparison.resetCounters();
	    		startTime = System.nanoTime();
	        	SortComparison.insertionSort(a);
	        	endTime = System.nanoTime();
	        	StdOut.printf("The time for insertion sort on %s is: %d\nThe number of swaps is: %d    And the number of comparisons is: %d\n\n"
	        			, S, (endTime-startTime), SortComparison.swaps, SortComparison.comparisons);
	        	
	        	SortComparison.resetCounters();
	        	startTime = new Long(System.nanoTime());
	        	SortComparison.quickSort(a, true);
	        	endTime = new Long(System.nanoTime());
	        	StdOut.printf("The time for quicksort with median pivot and cutoff to insertion sort on %s is: %d\nThe number of swaps is: %d    And the number of comparisons is: %d\n\n"
	        			, S, (endTime-startTime), SortComparison.swaps, SortComparison.comparisons);
	        	
	        	SortComparison.resetCounters();
	        	startTime = new Long(System.nanoTime());
	        	SortComparison.quickSort(a, false);
	        	endTime = new Long(System.nanoTime());
	        	StdOut.printf("The time for quicksort with random pivot and cutoff to insertion sort on %s is: %d\nThe number of swaps is: %d    And the number of comparisons is: %d\n\n"
	        			, S, (endTime-startTime), SortComparison.swaps, SortComparison.comparisons);
	        	
	        	SortComparison.resetCounters();
	        	startTime = new Long(System.nanoTime());
	        	SortComparison.mergeSort(a, true);
	        	endTime = new Long(System.nanoTime());
	        	StdOut.printf("The time for merge sort with recursive method and cutoff to insertion sort on %s is: %d\nThe number of swaps is: %d    And the number of comparisons is: %d\n\n"
	        			, S, (endTime-startTime), SortComparison.swaps, SortComparison.comparisons);
	        	
	        	SortComparison.resetCounters();
	        	startTime = new Long(System.nanoTime());
	        	SortComparison.mergeSort(a, false);
	        	endTime = new Long(System.nanoTime());
	        	StdOut.printf("The time for merge sort with sequential method on %s is: %d\nThe number of swaps is: %d    And the number of comparisons is: %d\n\n"
	        			, S, (endTime-startTime), SortComparison.swaps, SortComparison.comparisons);
	        	
	        	SortComparison.resetCounters();
	        	startTime = new Long(System.nanoTime());
	        	SortComparison.shellSort(a);
	        	endTime = new Long(System.nanoTime());
	        	StdOut.printf("The time for shell sort on %s is: %d\nThe number of swaps is: %d    And the number of comparisons is: %d\n\n"
	        			, S, (endTime-startTime), SortComparison.swaps, SortComparison.comparisons);
	        	
	        	SortComparison.resetCounters();
	        	startTime = new Long(System.nanoTime());
	        	SortComparison.selectionSort(a);
	        	endTime = new Long(System.nanoTime());
	        	StdOut.printf("The time for selection sort on %s is: %d\nThe number of swaps is: %d    And the number of comparisons is: %d\n\n"
	        			, S, (endTime-startTime), SortComparison.swaps, SortComparison.comparisons);
	        	
	        	SortComparison.resetCounters();
	        	startTime = new Long(System.nanoTime());
	        	SortComparison.bubbleSort(a);
	        	endTime = new Long(System.nanoTime());
	        	StdOut.printf("The time for bubble sort on %s is: %d\nThe number of swaps is: %d    And the number of comparisons is: %d\n\n"
	        			, S, (endTime-startTime), SortComparison.swaps, SortComparison.comparisons);
    	
    	//TODO: implement this method
    }
	*/
}

