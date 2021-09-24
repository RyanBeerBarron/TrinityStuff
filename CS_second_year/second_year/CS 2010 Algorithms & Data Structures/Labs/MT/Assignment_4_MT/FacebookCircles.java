package assignment_4_MT;

/**
 * Class FacebookCircles: calculates the statistics about the friendship circles in facebook data.
 *
 * @author
 *
 * @version 01/12/15 02:03:28
 */
public class FacebookCircles 
{
	private final int facebookUsers;
	private int friendships;
	private  Bag<Integer>[] adj;
	ConnectedCircles cc;

  /**
   * Constructor
   * @param numberOfFacebookUsers : the number of users in the sample data.
   * Each user will be represented with an integer id from 0 to numberOfFacebookUsers-1.
   */
	public FacebookCircles(int numberOfFacebookUsers) 
	{
		friendships = 0;
		facebookUsers = numberOfFacebookUsers;
		adj = (Bag<Integer>[]) new Bag[numberOfFacebookUsers];
		for(int v = 0; v< facebookUsers; v++)
		{
			adj[v] = new Bag<Integer>();
		}
	}

  /**
   * creates a friendship connection between two users, represented by their corresponding integer ids.
   * @param user1 : int id of first user
   * @param user2 : int id of second  user
   */
	public void friends( int user1, int user2 ) 
	{
		friendships++;
		adj[user1].add(user2);
		adj[user2].add(user1);
	}
  
  /**
   * @return the number of friend circles in the data already loaded.
   */
	public int numberOfCircles() 
	{
		cc = new ConnectedCircles(this);
		return cc.count();
	}

  /**
   * @return the size of the largest circle in the data already loaded.
   */
  public int sizeOfLargestCircle() 
  {
	  cc = new ConnectedCircles(this);
	  return cc.largestCircle();
  }

  /**
   * @return the size of the median circle in the data already loaded.
   */
  public int sizeOfAverageCircle() 
  {
	  cc = new ConnectedCircles(this);
	  return cc.averageCircle();
  }

  /**
   * @return the size of the smallest circle in the data already loaded.
   */
  public int sizeOfSmallestCircle() 
  {
	  cc = new ConnectedCircles(this);
	  return cc.smallestCircle();
  }

  public int numberOfUsers()
  {
	  return facebookUsers;
  }
  
  public int numberOfFriendships()
  {
	  return friendships;
  }
  
  public Bag<Integer> adj(int v)
  {
	  return adj[v];
  }
}
