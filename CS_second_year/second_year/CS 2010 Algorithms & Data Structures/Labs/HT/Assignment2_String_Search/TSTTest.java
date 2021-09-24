package assignment_2_HT;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;
import org.junit.Test;
import java.util.LinkedList;
import org.json.simple.parser.*;
import org.json.simple.*;
import java.io.*;

public class TSTTest 
{

	  @Test
	  public void testEmpty()
	  {
	    TST<Long> trie = new TST<>();
	    assertEquals("size of an empty trie should be 0",0, trie.size());
	    assertFalse("searching an empty trie should return false",trie.contains(""));
	    assertNull("getting from an empty trie should return null",trie.get(""));
	  }
	@Test 
	public void testTST()
	{
		TST<Integer> trie = new TST<Integer>();
		trie.put("bed", 50);
		assertEquals("size should be 10", 1, trie.size());
		trie.put("better", 3);
		trie.put("backend", 30);
		trie.put("backup", 1);
		trie.put("auto", 1);
		trie.put("test", 3);
		trie.put("summary", 5);
		trie.put("sum", 40);
		trie.put("end", 3);
		trie.put("blah", 3);
		trie.put("blabla", 50);
		assertTrue("TST contains 'bed'", trie.contains("bed"));
		assertEquals("size should be 10", 11, trie.size());
		assertEquals("Get value of backend", "30", Integer.toString(trie.get("backend")));
		LinkedList<String> list = trie.keysWithPrefix("b");
		String fullString = "";
		for(String s : list)
		{
		  fullString = fullString + s + " ";
		}
		assertEquals("","backend backup bed better blabla blah ", fullString );
		trie.put("backend", 10);
		assertEquals("Get value of backend", "10", Integer.toString(trie.get("backend")));
		int a = trie.get("backend");
		a = a * 15;
		trie.put("backend", a);
		assertEquals("Get value of backend", "150", Integer.toString(trie.get("backend")));
		if(trie.contains("sum"))
		{
			Integer b = trie.get("sum");
			b = b + 1;
			trie.put("sum",b);
		}
		assertEquals("","41",Integer.toString(trie.get("sum")));
		
	}
	
	public static void main(String[] args)
	{
		In in = new In("google-books-common-words.txt");
		TST<Long> trie = new TST<Long>();
		String s;
		long a;
		while(!in.isEmpty())
		{
			s = in.readString();
			a = in.readLong();
			trie.put(s, a);
		}
		StdOut.printf("There are %d words in the trie\n", trie.size());
		StdOut.printf("The frequency of the word 'ALGORITHM' is: %d\n", trie.get("ALGORITHM"));
		if(trie.contains("EMOJI")) StdOut.printf("The trie does contain the word EMOJI\n");
		else StdOut.printf("The trie does not contain the word EMOJI\n");
		if(trie.contains("BLAH")) StdOut.printf("The trie does contain the word BLAH\n");
		else StdOut.printf("The trie does not contain the word BLAH\n");
		LinkedList<String> list = new LinkedList<String>();
		list = trie.keysWithPrefix("TEST");
		StdOut.printf("The number of keys with the prefix test in the trie is: %d\n", list.size());
		int count = 0;
		TST<Integer> t = new TST<Integer>();
		try
		{
			JSONParser json = new JSONParser();
			FileReader file = new FileReader("BUSES_SERVICE_0.json");
			JSONArray array = (JSONArray) json.parse(file);
			
			for(Object j : array)
			{
				count++;
				JSONObject object = (JSONObject) j;
				String dest = (String)object.get("Destination");
				if(t.contains(dest))
				{
					Integer b = t.get(dest);
					t.put(dest, b+1);
				}
				else t.put(dest, 1);
			}
		}
		catch (FileNotFoundException e)
		{
			e.printStackTrace();
		}
		catch (IOException e)
		{
			e.printStackTrace();
		}
		catch (ParseException e)
		{
			e.printStackTrace();
		}
		System.out.println("Count is " + count);
		StdOut.printf("The size of the trie is %d\n", t.size());
		if(t.contains("SOUTHSIDE")) StdOut.printf("The trie does contain southside\n");
		else StdOut.printf("The trie does not contain southside\n");
		LinkedList<String> l = t.keysWithPrefix("DOWN");
		int total = 0;
		for(String w : l)
		{
			total += t.get(w);
		}
		StdOut.printf("Total number of occurences of destination with prefix down is %d", total);
	}	
	
	
}
