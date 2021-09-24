package assignment_2_HT;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;
import org.junit.Test;
import assignment_1_HT.In;

public class KMPSearchTest 
{
	public final static String STRING = "SERVICE_0.txt";
	
  @Test
  public void testEmpty()
  {
    assertEquals("Empty text or pattern is invalid",-1,KMPSearch.searchFirst("",""));
    assertEquals("Empty text or pattern is invalid",0,KMPSearch.searchAll("",""));
    assertFalse("Empty text or pattern is invalid",KMPSearch.contains("",""));
  }
  
  @Test
  public void testString()
  {
	  assertTrue("Test succes search",KMPSearch.contains("this is a test","is"));
	  assertEquals("Test succes search",2,KMPSearch.searchFirst("this is a test","is"));
	  assertEquals("Test succes search",2,KMPSearch.searchAll("This is a test", "is"));
  }
  
  @Test
  public void testNoString()
  {
	  assertFalse("Test fail search", KMPSearch.contains("This is a test","secret"));
	  assertEquals("Test fail search", -1, KMPSearch.searchFirst("This is a test","secret"));
	  assertEquals("Test fail search", 0, KMPSearch.searchAll("This is a test","secret"));
  }
  
  public static void main(String[] args)
  {
	  In in = new In("BUSES_SERVICE_0.txt");
	  String txt = in.readAll();
	  String pat = "VehicleNo";
	  StdOut.printf("The number of occurences of %s in the text file is: %d\n", pat, KMPSearch.searchAll(txt, pat));
	  if(KMPSearch.contains(txt, "16555")) StdOut.printf("Yes\n");
	  else StdOut.printf("No\n");
	  pat = "HAMPTON PARK";
	  StdOut.printf("The first occurence of %s in the text file is: %d\n", pat, KMPSearch.searchFirst(txt, pat));
	  if(KMPSearch.contains(txt, "9043409")) StdOut.printf("Yes\n");
	  else StdOut.printf("No\n");
	  
  }
}