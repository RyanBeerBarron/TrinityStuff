package assignment_2_HT;

public class KMPSearch 
{
	private int radix;
	private int[][] dfa;	  
	private char[] pattern;
	private String pat;
	  /*
	   * Bus Service Questions:
	   *
	   * 1. How many total vehicles is there information on?
	   *    //987
	   *
	   * 2. Does the file contain information about the vehicle number 16555?
	   *    //Yes
	   *
	   * 3. Locate the first record about a bus heading to HAMPTON PARK
	   *    //19774
	   *
	   * 4. Does the file contain information about the vehicle number 9043409?
	   *    //No
	   */

	   /*
	    * The method checks whether a pattern pat occurs at least once in String txt.
	    *
	    */
	public KMPSearch(String pat)
	{
		this.radix = 256;
		this.pat = pat;
		int m = pat.length();
		this.dfa = new int[this.radix][m];
	
		//Set transition for correct character
		for(int state = 0; state<m; state++)
		{
			dfa[pat.charAt(state)][state] = state+1;
		}
	
		//Set transition mismatch for state 0
		for(int c = 0; c<radix; c++)
		{
			if( c != pat.charAt(0))
				dfa[c][0] = 0;	
		}
	
		//Set transition mismatch for the other states
		for(int x = 0, state = 1; state<m; state++)
		{
			for(int c = 0; c<radix; c++)
			{
				if( c != pat.charAt(state))
					dfa[c][state] = dfa[c][x];
			}
			x = dfa[pat.charAt(state)][x];	
		}	
	}


	public KMPSearch(char[] pattern)
	{
		this.radix = 256;
		this.pattern = pattern;
		int m = pattern.length;
		this.dfa = new int[this.radix][m];
	
		//Set transition for correct character
		for(int state = 0; state<m; state++)
		{
			dfa[pat.charAt(state)][state] = state+1;
		}
	
		//Set transition mismatch for state 0
		for(int c = 0; c<radix; c++)
		{
			if( c != pat.charAt(0))
				dfa[c][0] = 0;	
		}
	
		//Set transition mismatch for the other states
		for(int x = 0, state = 1; state<m; state++)
		{
			for(int c = 0; c<radix; c++)
			{
				if( c != pat.charAt(state))
					dfa[c][state] = dfa[c][x];
			}
			x = dfa[pat.charAt(state)][x];	
		}	
	}
	public KMPSearch(String pat, int radix)
	{
		this.radix = radix;
		this.pat = pat;
		int m = pat.length();
		this.dfa = new int[this.radix][m];
	
		//Set transition for correct character
		for(int state = 0; state<m; state++)
		{
			dfa[pat.charAt(state)][state] = state+1;
		}
	
		//Set transition mismatch for state 0
		for(int c = 0; c<radix; c++)
		{
			if( c != pat.charAt(0))
				dfa[c][0] = 0;	
		}
	
		//Set transition mismatch for the other states
		for(int x = 0, state = 1; state<m; state++)
		{
			for(int c = 0; c<radix; c++)
			{
				if( c != pat.charAt(state))
					dfa[c][state] = dfa[c][x];
			}
			x = dfa[pat.charAt(state)][x];	
		}	
	}
	public KMPSearch(char[] pattern, int radix)
	{
		this.radix = radix;
		this.pattern = pattern;
		int m = pattern.length;
		this.dfa = new int[this.radix][m];
	
		//Set transition for correct character
		for(int state = 0; state<m; state++)
		{
			dfa[pat.charAt(state)][state] = state+1;
		}
	
		//Set transition mismatch for state 0
		for(int c = 0; c<radix; c++)
		{
			if( c != pat.charAt(0))
				dfa[c][0] = 0;	
		}
	
		//Set transition mismatch for the other states
		for(int x = 0, state = 1; state<m; state++)
		{
			for(int c = 0; c<radix; c++)
			{
				if( c != pat.charAt(state))
					dfa[c][state] = dfa[c][x];
			}
			x = dfa[pat.charAt(state)][x];	
		}	
	}




	public static boolean contains(String txt, String pat) 
	{
		if (txt.length() == 0 || pat.length() == 0) return false;
		KMPSearch KMP = new KMPSearch(pat);
		int n = txt.length();
		int m = pat.length();
		int i, j;
		for(i = 0, j = 0; i<n && j<m; i++)
		{
			j = KMP.dfa[txt.charAt(i)][j];
		}	
		if ( j == m ) return true;
    	else return false;
  	}

	  /*
	   * The method returns the index of the first ocurrence of a pattern pat in String txt.
	   * It should return -1 if the pat is not present
	   */
  	public static int searchFirst(String txt, String pat) 
  	{
  		if (txt.length() == 0 || pat.length() == 0) return -1;
  		KMPSearch KMP = new KMPSearch(pat);
		int n = txt.length();
		int m = pat.length();
		int i, j;
		for( i = 0, j = 0; i<n && j<m; i++)
		{
			j = KMP.dfa[txt.charAt(i)][j];
		}	
		if ( j == m ) return i-m;
    	else return -1;
  	}

	  /*
	   * The method returns the number of non-overlapping occurences of a pattern pat in String txt.
	   */
  	public static int searchAll(String txt, String pat) 
  	{
  		if (txt.length() == 0 || pat.length() == 0) return 0;
  		KMPSearch KMP = new KMPSearch(pat);
		int n = txt.length();
		int m = pat.length();
		int count = 0;
		for(int i = 0, j = 0; i<n; i++)
		{
			j = KMP.dfa[txt.charAt(i)][j];
			if (j == m)
			{
				j = 0;
				count++;
			}	
		}	
		return count;
  	}
}
