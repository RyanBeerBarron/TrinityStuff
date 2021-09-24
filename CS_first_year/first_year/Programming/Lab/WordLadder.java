package introduction_programming;
import java.util.Scanner;
import java.util.Arrays;
public class WordLadder 
{

	public static void main(String[] args) 
	{
		In dictionary = new In("words.txt");
		String[] jesusThatsALongOne = readDictionary(dictionary);
		Scanner sc = new Scanner(System.in);
		boolean finished = false;
		while(!finished)
		{
			String[] wordList = readWordList();
			if(wordList.length == 1 && wordList[0].equals(""))
			{	
				finished = true;
			}	
			else if(isWordChain(wordList, jesusThatsALongOne))
			{
				System.out.println("Valid chain of words from Lewis Carroll's word-links game.");
			}
			else
			{
				System.out.println("Not a valid chain of words from Lewis Carroll's word-links game.");
			}
		}
		System.out.println("Goodbye");
		sc.close();
	}
	public static String[] readDictionary(In in)
	{
		String s = in.readAll();
		String[] arrayString = s.split("\n");
		return arrayString;
	}
	public static String[] readWordList()
	{
		Scanner sc = new Scanner(System.in);
		System.out.println("Enter word ladder, each word separated by commas.");
		String s = sc.nextLine();
		String[] wordList = s.split(", ");
		sc.close();
		return wordList;
	}
	public static boolean isUniqueList(String[] arrayString)
	{
		boolean isUnique = true;
		for( int i = 0; i<arrayString.length && isUnique; i++)
		{
			for( int j =i+1; j<arrayString.length && isUnique; j++)
			{
				if(arrayString[i].equals(arrayString[j]))
					isUnique = false;
			}
		}
		return isUnique;
	}
	public static boolean isEnglishWord(String s, String[] dictionary)
	{
		int n = -1;
		n = Arrays.binarySearch(dictionary, s);
		return (n>=0);
	}
	public static boolean isDifferentByOne(String s1, String s2)
	{
		int number = 1;
		if(s1.length() == s2.length())
		{
			char[] charArray1 = s1.toCharArray();
			char[] charArray2 = s2.toCharArray();
			for ( int i = 0; i<charArray1.length; i++)
			{
				if(charArray1[i]!=charArray2[i])
					number-=1;
			}
		}
		return (number>=0);
	}
	public static boolean isWordChain(String[] wordList, String[] dictionary)
	{
		if(isUniqueList(wordList))
		{
			for( int i = 1; i<wordList.length ; i++)
			{
				if(isEnglishWord(wordList[i-1], dictionary)&&isEnglishWord(wordList[i], dictionary))
				{
					if(isDifferentByOne(wordList[i-1], wordList[i]))
					{
					}
					else return false;	
				}
				else return false;
			}
			return true;
		}
		else return false;
	}
}

