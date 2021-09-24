package assignment_3_HT;

import java.util.*;
/*
 * A Contest to Meet (ACM) is a reality TV contest that sets three contestants at three random
 * city intersections. In order to win, the three contestants need all to meet at any intersection
 * of the city as fast as possible.
 * It should be clear that the contestants may arrive at the intersections at different times, in
 * which case, the first to arrive can wait until the others arrive.
 * From an estimated walking speed for each one of the three contestants, ACM wants to determine the
 * minimum time that a live TV broadcast should last to cover their journey regardless of the contestants’
 * initial positions and the intersection they finally meet. You are hired to help ACM answer this question.
 * You may assume the following:
 *     Each contestant walks at a given estimated speed.
 *     The city is a collection of intersections in which some pairs are connected by one-way
 * streets that the contestants can use to traverse the city.
 *
 * This class implements the competition using Dijkstra's algorithm
 */

public class CompetitionDijkstra 
{
	final WeightedGraph graph;
	final int sA, sB, sC;
	
	DirectedWeightedEdge[] edgeTo;
	double[] distTo;
	IndexMinPQ<Double> pq;
	
	double highestDistance;
	
	private class DirectedWeightedEdge
	{
		private final int v, w;
		private final double weight;
		
		DirectedWeightedEdge(int v, int w, double weight)
		{
			this.v = v;
			this.w = w;
			this.weight = weight;
		}
		
		int from()
		{
			return v;
		}
		int to()
		{
			return w;
		}
		double weight()
		{
			return weight;
		}
		public String toString()
		{
			String s = "";
			s = s + v;
			s = s + " " + w;
			s = s + " " + weight;
			return s;
		}
	}
	
	private class WeightedGraph
	{
		private final int V;
		private int E;
		private final LinkedList<DirectedWeightedEdge> [] adj;

		WeightedGraph(int V)
		{
			this.V = V;
			adj =(LinkedList<DirectedWeightedEdge>[]) new LinkedList[V];
			for(int v = 0; v<V; v++)
			{
				adj[v] = new LinkedList<DirectedWeightedEdge>();
			}
		}
		void addEdge(int v, int w, double weight)
		{
			DirectedWeightedEdge e = new DirectedWeightedEdge(v, w, weight);
			adj[v].add(e);
			E++;
		}
		void addEdge(DirectedWeightedEdge e)
		{
			int v = e.from();
			adj[v].add(e);
			E++;
		}
		Iterable<DirectedWeightedEdge> adj(int v)
		{
			return adj[v];
		}
		int V()
		{
			return V;
		}
		int E()
		{
			return E;
		}
	}
	
	
    /**
     * @param filename: A filename containing the details of the city road network
     * @param sA, sB, sC: speeds for 3 contestants
    */
    CompetitionDijkstra (String filename, int sA, int sB, int sC)
    {
    	In in = new In(filename);
    	int v = in.readInt();
    	this.graph = new WeightedGraph(v);
    	int e = in.readInt();
    	for(int i = 0; i<e; i++)
    	{
    		int source = in.readInt();
    		int dest = in.readInt();
    		double weight = in.readDouble();
    		this.graph.addEdge(source, dest, weight);
    	}
    	this.sA = sA;
    	this.sB = sB;
    	this.sC = sC;
    	highestDistance = 0;
    }


    /**
    * @return int: minimum minutes that will pass before the three contestants can meet
     */
    public int timeRequiredforCompetition()
    {
    	int lowestSpeed = lowestSpeed(sA, sB, sC);
    	StdOut.printf("The speeds are: %d, %d, %d. And the lowest speed is: %d\n", sA, sB, sC, lowestSpeed);
    	if (lowestSpeed<= 0) return -1;
    	
        for(int vertex = 0; vertex < graph.V(); vertex++)
        {
        	edgeTo = new DirectedWeightedEdge[graph.V()];
        	edgeTo[vertex] = new DirectedWeightedEdge(vertex, vertex, 0.0); 
        	distTo = new double[graph.V()];
        	pq = new IndexMinPQ<Double>(graph.V());
        	for(int i = 0; i<distTo.length; i++)
        		distTo[i] = Double.POSITIVE_INFINITY;
        	distTo[vertex] = 0.0;
        	pq.insert(vertex, 0.0);
        	while(!pq.isEmpty())
        	{
        		int v = pq.delMin();
        		for(DirectedWeightedEdge e : graph.adj(v))
        		{
        			int src = e.from();
        			int dest = e.to();
        			if( distTo[dest] > distTo[src]+e.weight())
        			{
        				distTo[dest] = distTo[src]+e.weight();
        				edgeTo[dest] = e;
        				if(pq.contains(dest)) pq.decreaseKey(dest, distTo[dest]);
        				else pq.insert(dest, distTo[dest]);
        			}
        		}	
        	}
        	for(int i = 0; i<edgeTo.length; i++)
        	{
        		if(edgeTo[i] == null) 
        		{
        			return -1;
        		}
        	}
        	for(int i = 0; i<distTo.length; i++)
        	{
        		if( distTo[i] > highestDistance)
        			highestDistance = distTo[i];
        	}
        }
    	return (int) Math.ceil(highestDistance*1000/lowestSpeed);
    }
    
    static int lowestSpeed(int sA, int sB, int sC)
    {
    	if(sA <= sB && sA <= sC ) return sA;
    	else if(sB <= sA && sB <= sC ) return sB;
    	else return sC;
    }

}
