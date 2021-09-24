import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import org.junit.*;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

import java.util.Arrays;

//-------------------------------------------------------------------------
/**
 *  Test class for Collinear.java
 *
 *  @author  
 *  @version 03/10/16 17:10:35
 */
@RunWith(JUnit4.class)
public class CollinearTest
{
    //~ Constructor ........................................................
    @Test
    public void testConstructor()
    {
      new Collinear();
    }

    //~ Public Methods ........................................................

    // ----------------------------------------------------------
    /**
     * Check that the two methods work for empty arrays
     */
    @Test
    public void testEmpty()
    {
        int expectedResult = 0;
        
        assertEquals("countCollinear failed with 3 empty arrays",       expectedResult, Collinear.countCollinear(new int[0], new int[0], new int[0]));
        assertEquals("countCollinearFast failed with 3 empty arrays", expectedResult, Collinear.countCollinearFast(new int[0], new int[0], new int[0]));
    }

    // ----------------------------------------------------------
    /**
     * Check for no false positives in a single-element array
     */
    @Test
    public void testSingleFalse()
    {
        int[] a3 = { 15 };
        int[] a2 = { 5 };
        int[] a1 = { 10 };

        int expectedResult = 0;

        assertEquals("countCollinear({10}, {5}, {15})",       expectedResult, Collinear.countCollinear(a1, a2, a3) );
        assertEquals("countCollinearFast({10}, {5}, {15})", expectedResult, Collinear.countCollinearFast(a1, a2, a3) );
    }

    // ----------------------------------------------------------
    /**
     * Check for no false positives in a single-element array
     */
    @Test
    public void testSingleTrue()
    {
        int[] a3 = { 15, 5 };       int[] a2 = { 5 };       int[] a1 = { 10, 15, 5 };

        int expectedResult = 1;
        assertEquals("countCollinear(" + Arrays.toString(a1) + "," + Arrays.toString(a2) + "," + Arrays.toString(a3) + ")",     expectedResult, Collinear.countCollinear(a1, a2, a3));
        assertEquals("countCollinearFast(" + Arrays.toString(a1) + "," + Arrays.toString(a2) + "," + Arrays.toString(a3) + ")", expectedResult, Collinear.countCollinearFast(a1, a2, a3));
    }


    // TODO: add more tests here. Each line of code and ech decision in Collinear.java should
    // be executed at least once from at least one test.
    @Test
    public void testSort()
    {
    	int a[] = { 1, 2, 3, 4, 5};
    	Collinear.sort(a);
    }
    
    
    
    @Test
    public void testBinarySearch()
    {
    	int[] a = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    	
    	assertTrue("test", Collinear.binarySearch(a, 3));
    }
    // ----------------------------------------------------------
    /**
     *  Main Method.
     *  Use this main method to create the experiments needed to answer the experimental performance questions of this assignment.
     *
     *  You should read the lecture notes and/or book to understand how to correctly implement the main methods.
     *  You can use any of the provided classes to read from files, and time your code.
     *
     */
     public static void main(String[] args)
     {
    	/* In in1 = new In("r01000-1.txt");
    	 In in2 = new In("r01000-2.txt");
    	 In in3 = new In("r01000-3.txt");
    	 int[] a1 = in1.readAllInts();
    	 int[] a2 = in2.readAllInts();
    	 int[] a3 = in3.readAllInts();
    	 Stopwatch stopwatch = new Stopwatch();
    	 StdOut.println("Input size is N = 1000\n" + Collinear.countCollinear(a1, a2, a3));
    	 double elapsedTime = stopwatch.elapsedTime();
    	 System.out.println(elapsedTime);
    	 
    	 in1 = new In("r02000-1.txt");
    	 in2 = new In("r02000-2.txt");
    	 in3 = new In("r02000-3.txt");
    	 a1 = in1.readAllInts();
    	 a2 = in2.readAllInts();
    	 a3 = in3.readAllInts();
    	 stopwatch = new Stopwatch();
    	 System.out.println("Input size is N = 2000\n" + Collinear.countCollinear(a1, a2, a3));
    	 elapsedTime = stopwatch.elapsedTime();
    	 System.out.println(elapsedTime);
    	 
    	 in1 = new In("r04000-1.txt");
    	 in2 = new In("r04000-2.txt");
    	 in3 = new In("r04000-3.txt");
    	 a1 = in1.readAllInts();
    	 a2 = in2.readAllInts();
    	 a3 = in3.readAllInts();
    	stopwatch = new Stopwatch();
    	StdOut.println("Input size is N = 4000\n" + Collinear.countCollinear(a1, a2, a3));
    	elapsedTime = stopwatch.elapsedTime();
    	StdOut.println(elapsedTime);
     
    	in1 = new In("r05000-1.txt");
   	 	in2 = new In("r05000-2.txt");
   	 	in3 = new In("r05000-3.txt");
   	 	a1 = in1.readAllInts();
   	 	a2 = in2.readAllInts();
   	 	a3 = in3.readAllInts();
   	 	stopwatch = new Stopwatch();
   	 	StdOut.println("Input size is N = 5000\n" + Collinear.countCollinear(a1, a2, a3));
   	 	elapsedTime = stopwatch.elapsedTime();
   	 	StdOut.println(elapsedTime);
   	 	StdOut.println("\n");
   	 	
   	 	in1 = new In("r01000-1.txt");
   	 	in2 = new In("r01000-2.txt");
   	 	in3 = new In("r01000-3.txt");
   	 	a1 = in1.readAllInts();
   	 	a2 = in2.readAllInts();
   	 	a3 = in3.readAllInts();
   	 	stopwatch = new Stopwatch();
   	 	StdOut.println("Input size is N = 1000 using fast algorithm\n" + Collinear.countCollinearFast(a1, a2, a3));
   	 	elapsedTime = stopwatch.elapsedTime();
   	 	System.out.println(elapsedTime);
	 
   	 	in1 = new In("r02000-1.txt");
   	 	in2 = new In("r02000-2.txt");
   	 	in3 = new In("r02000-3.txt");
   	 	a1 = in1.readAllInts();
   	 	a2 = in2.readAllInts();
   	 	a3 = in3.readAllInts();
   	 	stopwatch = new Stopwatch();
   	 	System.out.println("Input size is N = 2000 using fast algorithm\n" + Collinear.countCollinearFast(a1, a2, a3));
   	 	elapsedTime = stopwatch.elapsedTime();
   	 	System.out.println(elapsedTime);
	 
   	 	in1 = new In("r04000-1.txt");
   	 	in2 = new In("r04000-2.txt");
   	 	in3 = new In("r04000-3.txt");
   	 	a1 = in1.readAllInts();
   	 	a2 = in2.readAllInts();
   	 	a3 = in3.readAllInts();
   	 	stopwatch = new Stopwatch();
   	 	StdOut.println("Input size is N = 4000 using fast algorithm\n" + Collinear.countCollinearFast(a1, a2, a3));
   	 	elapsedTime = stopwatch.elapsedTime();
   	 	StdOut.println(elapsedTime);
 
   	 	in1 = new In("r05000-1.txt");
	 	in2 = new In("r05000-2.txt");
	 	in3 = new In("r05000-3.txt");
	 	a1 = in1.readAllInts();
	 	a2 = in2.readAllInts();
	 	a3 = in3.readAllInts();
	 	stopwatch = new Stopwatch();
	 	StdOut.println("Input size is N = 5000\n" + Collinear.countCollinearFast(a1, a2, a3));
	 	elapsedTime = stopwatch.elapsedTime();
	 	StdOut.println(elapsedTime);
	 	StdOut.println("\n");*/
     }

}

