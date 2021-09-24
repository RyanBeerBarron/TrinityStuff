import java.util.LinkedList;

public class linearSearchLinkedList 
{
	public static int recursiveLinearSearch(LinkedList<Integer> l, int data)
	{
		LinkedList<Integer> lists = new LinkedList<Integer>();
		lists = l;
		return privateRecursiveLinearSearch(lists, data);
	}
	private static int privateRecursiveLinearSearch(LinkedList<Integer> l, int data)
	{
		if (l.size() == 0 ) return -1;
		if(l.getFirst() == data) return 1;
		else
		{
			LinkedList<Integer> list = l;
			list.removeFirst();
			return 1+recursiveLinearSearch(list, data);
		}
	}
	
	public static int iterativeLinearSearch(LinkedList<Integer> l, int data)
	{
		for(int i = 0; i<l.size();i++)
		{
			if(l.get(i) == data)
				return i+1;
		}
		return -1;
	}

	public static void main(String[] args)
	{
		LinkedList<Integer> list = new LinkedList<Integer>();
		list.add(1);
		list.add(2);
		list.add(3);
		list.add(4);
		list.add(5);
		list.add(6);
		list.add(7);
		System.out.println(iterativeLinearSearch(list, 5));
		System.out.println(recursiveLinearSearch(list, 7));
		
	}
}
