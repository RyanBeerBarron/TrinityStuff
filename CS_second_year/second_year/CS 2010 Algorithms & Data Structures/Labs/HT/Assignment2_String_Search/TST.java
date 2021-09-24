package assignment_2_HT;

import java.util.LinkedList;
import java.util.Collections;


public class TST<Value> 
{

  /*
   * Bus Service Questions:
   * 1. How many unique destinations is there in the file?
   *    //TODO
   * 2. Is there a bus going to the destination "SOUTHSIDE"?
   *    //TODO
   * 3. How many records is there about the buses going to the destination beginning with "DOWN"?
   *    //TODO
   *
   * Google Books Common Words Questions:
   * 4. How many words is there in the file?
   *    //189245
   * 5. What is the frequency of the word "ALGORITHM"?
   *    //TODO
   * 6. Is the word "EMOJI" present?
   *   //TODO
   * 7. IS the word "BLAH" present?
   *   //TODO
   * 8. How many words are there that start with "TEST"?
   *    //TODO
   */
  private long size;
  private Node<Value> root;


  /* A Node in your trie containing a Value val and a pointer to its children */
  private static class Node<Value> 
  {
    private char c;                        // character
    private Node<Value> left, mid, right;  // left, middle, and right subtries
    private Value val;                     // value associated with string
  }

    /* a pointer to the start of your trie */
    //private TrieNode root = new TrieNode();

  /*
   * Returns the number of words in the trie
   */
    public long size() 
    {
      return size;
    }  
  /*
   * returns true if the word is in the trie, false otherwise
   */
  public boolean contains(String key) 
  {
    return (get(key)!=null);
  }

  /*
   * return the value stored in a node with a given key, returns null if word is not in trie
   */
  public Value get(String key) 
  {
    if(key.length() == 0) return null;
    Node<Value> x = get(root, key, 0);
    if (x == null) return null;
    return x.val;
  }

  private Node<Value> get(Node<Value> x, String key, int index)
  {
    if(x == null) return null;
    char c = key.charAt(index);
    if(c < x.c)
    {
    	return get(x.left, key, index);
    }
    else if(c > x.c)
    {
    	return get(x.right, key, index);
    }
    else if(c == x.c && index < key.length()-1)
    {
    	return get(x.mid, key, index+1);
    }
    else return x;
  }
  /*
   * stores the Value val in the node with the given key
   */
  public void put(String key, Value val) 
  {
    if(key == null) return;
    if(!contains(key)) size++;
    root = put(root, key, val, 0);
    return;
  }


  private Node<Value> put(Node<Value> x, String key, Value val, int index)
  {
    char c = key.charAt(index);
    if(x == null)
    {
      x = new Node<Value>();
      x.c = c;
    }
    if (c < x.c)
    {
    	x.left = put(x.left, key, val, index);
    }
    else if (c > x.c) 
    {
    	x.right = put(x.right, key, val, index);
    }
    else if (c == x.c && index < key.length()-1)
    {
    	x.mid = put(x.mid, key, val, index+1);
    }
    else x.val = val;
    return x;
  }
  /*
   * returns the linked list containing all the keys present in the trie
   * that start with the prefix passes as a parameter, sorted in alphabetical order
   */
  public LinkedList<String> keysWithPrefix(String prefix) 
  {
    LinkedList<String> list = new LinkedList<String>();
    Node<Value> x = get(root, prefix, 0);
    if (x == null) return list;
    if (x.val != null) list.add(prefix);
    collect(list, x.mid, new StringBuilder(prefix));
    Collections.sort(list);
    return list;
  }
  
  private void collect(LinkedList<String> list, Node<Value> x, StringBuilder prefix)
  {
	  if (x == null) return;
	  collect(list, x.left, prefix);
	  if(x.val != null) list.add(prefix.toString()+x.c);
	  collect(list, x.mid, prefix.append(x.c));
	  prefix.deleteCharAt(prefix.length() - 1);
	  collect(list, x.right, prefix);
  }
}
