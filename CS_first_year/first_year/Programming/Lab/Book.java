

public class Book implements Comparable<Book>
{
	
	private final String isbn;
	private final String title;
	private final String author;
	private int quantity;
	
	public Book(String isbn, String title, String author, int quantity) {
		this.isbn = isbn;
		this.title = title;
		this.author = author;
		this.quantity = quantity;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public String getIsbn() {
		return isbn;
	}

	public String getTitle() {
		return title;
	}

	public String getAuthor() {
		return author;
	}

	public String toString() {
		return "Book Isbn: " + this.isbn + ", Title: " + this.title + ", Author: "+ this.author + ", Quanity: "+ this.quantity + ".";
	}
	
	public int compareTo(Book book)
	{
		return (this.quantity > book.quantity ) ? 1 : (this.quantity < book.quantity ) ? -1 : 0;
	}


}
