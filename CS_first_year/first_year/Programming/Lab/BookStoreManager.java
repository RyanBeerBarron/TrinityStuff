import java.util.*;

public class BookStoreManager
{
	private ArrayList<Book> bookCollection;
	
	public BookStoreManager(In in)
	{
		int inSize = in.readInt();
		bookCollection = new ArrayList<Book>(inSize);
		for(int index = 0; index<inSize; index++)
		{
			String isbn = in.readLine();
			String title = in.readLine();
			String author = in.readLine();
			int quantity = in.readInt();
			boolean duplicate = false;
			for(int indexBis = 0; indexBis<bookCollection.size() && !duplicate; indexBis++)
			{
				Book book = bookCollection.get(indexBis);
				String bookIsbn = book.getIsbn();
				String bookTitle = book.getTitle();
				String bookAuthor = book.getAuthor();
				int bookQuantity = book.getQuantity();
				if(bookIsbn.equals(isbn) && bookTitle.equals(title) && bookAuthor.equals(author))
				{
					bookQuantity += quantity;
					book.setQuantity(bookQuantity);
					duplicate = true;
				}
			}
			if(!duplicate)
			{
				Book book = new Book(isbn, title, author, quantity);
				bookCollection.add(book);
			}
		}
	}
	public void printBooks()
	{
		for(int index = 0; index<bookCollection.size(); index++)
		{
			Book book = bookCollection.get(index);
			System.out.println(book);
		}
	}
	public static void main(String[] args)
	{
		In in = new In("books.txt");
		BookStoreManager bookManager = new BookStoreManager(in);
		bookManager.printBooks();
		System.out.println();
		Collections.sort(bookManager.bookCollection);
		bookManager.printBooks();
	}

}
