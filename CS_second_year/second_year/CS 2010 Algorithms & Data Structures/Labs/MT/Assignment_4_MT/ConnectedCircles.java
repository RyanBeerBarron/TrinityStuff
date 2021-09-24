package assignment_4_MT;

import java.util.Arrays;

public class ConnectedCircles 
{
	private boolean[] marked;
	private int[] id;
	private int count;
	private int[] cc;
	
	ConnectedCircles(FacebookCircles circles)
	{
		count = 0;
		marked = new boolean[circles.numberOfUsers()];
		id = new int[circles.numberOfUsers()];
		for( int v = 0; v<circles.numberOfUsers(); v++)
		{
			if(!marked[v])
			{
				dfs(circles, v);
				count++;
			}
		}
		cc = new int[count];
		for(int i : id)
		{
			cc[i]++;
		}
		Arrays.sort(cc);
	}
	
	public int count()
	{
		return count;
	}
	
	public int id(int v)
	{
		return id[v];
	}
	
	public boolean connected(int v, int w)
	{
		return id[v]==id[w];
	}
	
	private void dfs(FacebookCircles circle, int v)
	{
		marked[v] = true;
		id[v] = count;
		for(int w : circle.adj(v))
		{
			if(!marked[w]) 
			{
				marked[w] = true;
				id[w] = count;
				dfs(circle, w); 
			}
		}
	}
	
	public int smallestCircle()
	{
		return cc[0];
	}
	
	public int largestCircle()
	{
		return cc[count-1];
	}
	
	public int medianCircle()
	{
		return cc[count/2];
	}
	
	public int averageCircle()
	{
		int total = 0;
		for(int circle : cc)
		{
			total += circle;
		}
		return total/count;
	}
}
