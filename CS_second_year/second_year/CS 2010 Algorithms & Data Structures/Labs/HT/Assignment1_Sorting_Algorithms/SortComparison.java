
// -------------------------------------------------------------------------
import java.util.*;
/**
 *  This class contains static methods that implementing sorting of an array of numbers
 *  using different sort algorithms.
 *
 *  @author
 *  @version HT 2018
 */

 class SortComparison 
 {
	public static final int CUTOFF = 10;
	public static final boolean DEBUG = false;
	public static long swaps = 0;
    public static long comparisons = 0;
    /**
     * Sorts an array of doubles using InsertionSort.
     * This method is static, thus it can be called as SortComparison.sort(a)
     * @param a: An unsorted array of doubles.
     * @return array sorted in ascending order.
     *
     */
    static double [] insertionSort (double a[])
    {
		double[] b = a.clone();
    	for ( int i = 0; i<b.length; i++)
    	{
            comparisons++;
    		for(int j = i; j>0 && b[j]<b[j-1]; j--)
    		{
                comparisons++;
				swap(b, j, j-1);
                swaps++;
                if(DEBUG)
					System.out.println(Arrays.toString(b));
    		}
    	}
    	return b;
    }//end insertionsort

    /**
     * Sorts an array of doubles using Quick Sort.
     * This method is static, thus it can be called as SortComparison.sort(a)
     * @param a: An unsorted array of doubles.
     * @return array sorted in ascending order
     *
     */
    static double [] quickSort (double a[], boolean median)
    {
	   double[] b = a.clone();
       if(!median)
        shuffle(b);
       quick(b, 0, b.length-1, median);
       return b;

    }//end quicksort
    private static void quick(double[]  a, int low, int high, boolean median)
    {
        if(high <= low) return;
        if (high <= low + CUTOFF - 1)
        {
        	double[] b = Arrays.copyOfRange(a, low, high+1);
        	b = insertionSort(b);
        	System.arraycopy(b, 0, a, low, high+1-low);
        	return;
        }
        int pivot;
        if(!median)
            pivot = low;
        else
        {
            int mid = low + (high - low)/2;
            pivot = median(a, low, mid, high);
        }
        pivot = partition(a, low, high, pivot);
        quick(a, low, pivot-1, median);
        quick(a, pivot+1, high, median);
    }

    private static int partition(double[] a, int low, int high, int pivot)
    {
        int i = low, j=high;
        while(i<j)
        {
            while(a[pivot]>=a[i] && i<high)
            {
            	i++;
            	comparisons++;
            }
            while(a[pivot]<=a[j] && j>low)
            {
            	j--;
            	comparisons++;
            }
            if(i<j)
            {
                swap(a, i, j);
                swaps++;
                if(DEBUG)
                    System.out.println(Arrays.toString(a));         
            }   
        }
        swaps++;
        if(DEBUG)
            System.out.println(Arrays.toString(a));
        int median = median(i,j,pivot);
        
        if( median == pivot )
        	return pivot;
        else if( median == j )
        {
        	swap(a, pivot, j);
        	return j;
        }
        else
        {
        	swap(a, pivot, i);
        	return i;
        }
    }
    /**
     * Sorts an array of doubles using Merge Sort.
     * This method is static, thus it can be called as SortComparison.sort(a)
     * @param a: An unsorted array of doubles.
     * @return array sorted in ascending order
     *
     */
    static double [] mergeSort (double a[], boolean recursive)
    {
	   	double[] b = a.clone();
        double[] aux = new double[b.length];
        int low = 0, high = b.length-1;
        if(recursive)
            sortTopDown(b,aux,low,high);
        else sortBottomUp(b, aux);
        return b;
		 //todo: implement the sort
	
    }//end mergesort

    private static void sortBottomUp(double a[], double aux[])
    {
        for(int size = 1; size<a.length; size = size + size)
        {
            for(int low = 0; low<a.length-size; low += size+size)
            {
                merge(a, aux, low, low+size-1, (low+size+size-1>a.length-1)?a.length-1:low+size+size-1);
                if(DEBUG)
                    System.out.println(Arrays.toString(a));
            }    
        }    
    }

    private static void sortTopDown (double a[], double aux[], int low, int high)
    {
        if (high<=low) return;
        if (high <= low + CUTOFF - 1)
        {
        	double[] b = Arrays.copyOfRange(a, low, high+1);
        	b = insertionSort(b);
        	System.arraycopy(b, 0, a, low, high+1-low);
        	return;
        }
        int mid = low + (high-low)/2;
        sortTopDown(a,aux,low,mid);
        sortTopDown(a,aux,mid+1,high);
        if(a[mid]<a[mid+1]){
            comparisons++;
            return;} 
        merge(a, aux, low, mid, high);
        if(DEBUG)
            System.out.println(Arrays.toString(a));
    }

    private static void merge(double a[], double aux[], int low, int mid, int high)
    {
        for(int i =low; i<high+1 ;i++)
        {
            aux[i] = a[i];
        }
        int i = low, j = mid+1;     
        for(int k = low; k<high+1; k++)
        {
            if(i>mid)
            {
                a[k] = aux[j++];
                swaps++;
            }
            else if(j>high)
            {
                a[k] = aux[i++];
                swaps++;
            }
            else
            {
            	comparisons++; 
            	swaps++;
            	if(aux[i]<aux[j])
            		a[k] = aux[i++];
            	else 
            		a[k] = aux[j++];
            }
        }   
    }
	/**
     * Sorts an array of doubles using Shell Sort.
     * This method is static, thus it can be called as SortComparison.sort(a)
     * @param a: An unsorted array of doubles.
     * @return array sorted in ascending order
     *
     */
    static double [] shellSort (double a[])
    {
		double[] b = a.clone();
    	int h = 1;
    	while (h<b.length/3) h = 3*h+1;
    	while(h>=1)
    	{
	    	for(int i =h; i<a.length; i++)
            {
                comparisons++;
                for(int j = i; j>=h && b[j-h]>b[j]; j = j-h)
                {
                    comparisons++;
                    swap(b, j-h, j);
                    swaps++;          
                    if(DEBUG)
                        System.out.println(Arrays.toString(b));
                }    
            }    
	    h = h/3;
    	}
    	return b;
		 
    }//end shellsort
    
    /**
	 * ! BAD ! LOOK AHEAD ! BAD !
     * Sorts an array of doubles using Bad Shell Sort.
	 * Bad shell sort is the shell sort I first tried to implement from seeing the animation in the slides and online of shell sort.
	 * I first intuitively understood it as some sort of gapped bubble sort. So we loop for each gap h, and then we loop for each sub array it creates, and then for each sub array we have nested loops for bubblesort.
     * This method is static, thus it can be called as SortComparison.sort(a)
     * @param a: An unsorted array of doubles.
     * @return array sorted in ascending order
     *
     */
    
     static double [] badShellSort (double a[])
    {
        double[] b = a.clone();
        int h = 1;
        while (h<b.length/3) h = 3*h+1;
        while(h>=1)
        {
              for( int i = 0; i<b.length/h; i++)
            {
                for( int j = h; j<b.length-i*h; j++)
                {
                    comparisons++;
                    if(b[j]<b[j-h])
                    {   
                        
                        swap(b, j, j-h);
                        swaps++;
                        if(DEBUG)
                            System.out.println(Arrays.toString(b));
                    }
                }   
            }    
        h = h/3;
        }
        return b;
         
    }//end badShellsort
    /**
     * Sorts an array of doubles using Selection Sort.
     * This method is static, thus it can be called as SortComparison.sort(a)
     * @param a: An unsorted array of doubles.
     * @return array sorted in ascending order
     *
     */
    static double [] selectionSort (double a[])
    {
		double[] b = a.clone();
    	for(int i = 0; i<b.length; i++)
    	{
    		int indexOfMin = i;
    		for(int j = i+1; j<b.length; j++)
    		{	
                comparisons++;
    			if(b[j]<b[indexOfMin])
    				indexOfMin = j;
    		}
			
			swap(b, i, indexOfMin);
            swaps++;
            if(DEBUG)
				System.out.println(Arrays.toString(b));
    	}
    	return b;

    }//end selectionsort

    /**
     * Sorts an array of doubles using Bubble Sort.
     * This method is static, thus it can be called as SortComparison.sort(a)
     * @param a: An unsorted array of doubles.
     * @return array sorted in ascending order
     *
     */
    static double [] bubbleSort (double a[])
    {
		double[] b = a.clone();
    	for(int i = 0; i<b.length; i++)
    	{
    		for( int j = 1 ; j<(b.length - i); j++ )
    		{
                comparisons++;
    			if(b[j-1]>b[j])
    			{	
					swap(b, j, j-1);
                    swaps++;
                    if(DEBUG)
						System.out.println(Arrays.toString(b));
    			}
    		}	
    	}
    	return b;
    }//end bubblesort
	
   static int median(int a, int b, int c)
    {
    	if( a < b )
    	{
    		if( a < c )
    		{
    			if(b < c)
    				return b;
    			else return c;
    		}
    		else return a;
    	}
    	else
    	{
    		if( b < c )
    		{
    			if( a < c )
    				return a;
    			else return c;
    		}
    		return b;
    	}
    }
    static int median(double[] array, int a, int b, int c)
    {
    	 if( array[a] < array[b] )
         {
         	if( array[a] < array[c])
         	{	
         		comparisons = comparisons + 3;
         		if( array[b] < array[c] )
         			return b;
         		else
         			return c;
         	}
         	else
         	{
         		comparisons = comparisons + 2;
         		return a;
         	}
         }
         else
         {
         	if( array[b] < array[c] )
         	{
         		comparisons = comparisons + 3;
         		if( array[a] < array[c] )
         			return a;
         		else
         			return c;
         	}
         	
         	else
         	{
         		comparisons = comparisons + 2;
         		return b;
         	}
         }
    }
    
	private static void swap(double[] a, int i, int n)
	{
		double temp = a[i];
		a[i] = a[n];
		a[n] = temp;
	}	
	static void shuffle(double[] a)
	{
		Random rnd = new Random();
		for(int i = 0; i<a.length; i++)
		{
			int next = rnd.nextInt(a.length);
			swap(a, i, next);
		}
	}
	
	
/*	
  	static void resetCounters()
	{
		swaps = 0;
		comparisons = 0;
	}
*/
	
	
    static void reverse(double[] a)
    {
        int i, j;
        for(i = 0, j = a.length-1; i<=j; i++, j--)
        {
            swap(a, i, j);
        }    
    }
    
    static void generateNumber(double[] a)
    {
    	Random rnd = new Random();
    	for(int i=0; i<a.length; i++)
    	{	
    		a[i] = rnd.nextDouble()*1000;
    	}
    }
   
 }//end class

