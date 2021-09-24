package introduction_programming;
import java.util.Scanner;

public class SampleETest 
{

	public final static char BLANK = ' ';
	public final static char NOUGHTS = 'O';
	public final static char CROSSES  = 'X';
	public final static int BOARD_SIZE = 3;
	
	public static void main(String[] args)
	{
		char[][] board = new char[BOARD_SIZE][BOARD_SIZE];
		clearBoard(board);
		char currentPlayerPiece = CROSSES;
		Scanner input = new Scanner(System.in);
		while((!isBoardFull(board))&& winner(board)==BLANK)
		{
			printBoard(board);
			int row=-1;
			int collumn=-1;
			do
			{
				System.out.print("Enter move for " + currentPlayerPiece + ": ");
				char[] inputCharacters = input.next().toCharArray();
				if((inputCharacters.length>=2)&&
					(inputCharacters[0]>='A')  && (inputCharacters[0]<= 'C') &&	
					(inputCharacters[1]>='1') && (inputCharacters[1]<='3'))
				{	
					row = (int) (inputCharacters[0]-'A');
					collumn = (int) (inputCharacters[1]-'1');
					if(!canMakeMove(board,row,collumn))
					{	
						System.out.println("Invalid entry. This location is already occuipied.");
					}
				}
				else
					System.out.println("Invalid entry. You must enter a row and collumn.");
			}while((row==-1 ) || (!canMakeMove(board,row,collumn)));	
			makeMove(board,currentPlayerPiece,row,collumn);
			currentPlayerPiece = (currentPlayerPiece==CROSSES)?NOUGHTS:CROSSES;
		}
		printBoard(board);
		if(winner(board)==BLANK)
			System.out.println("It was a draw.");
		else System.out.println("The winner was " + winner(board));
		input.close();
	}
	public static void clearBoard(char[][] board)
	{
		for( int i = 0; i<BOARD_SIZE; i++)
		{
			for ( int j = 0; j<BOARD_SIZE; j++)
			{
				board[i][j] = BLANK;
			}
		}
	}
	public static boolean isBoardFull(char[][] board)
	{
		for ( int i =0; i<BOARD_SIZE; i++)
		{
			for ( int j=0; j<BOARD_SIZE; j++)
			{
				if(board[i][j]==BLANK)
					return false;
			}
		}
		return true;
	}
	public static char winner(char[][] board)
	{
		for(int i =0, j=0; i<BOARD_SIZE&&j<BOARD_SIZE; i++, j++)
		{
			if(board[i][j]!=BLANK)
			{
				if(i==0)
				{
					char temp = board[0][0];
					if((temp == board[0][1] && temp == board[0][2])
							||(temp == board[1][1] && temp == board[2][2])
							||( temp ==board[1][0] && temp==board[2][0]))
						return temp;
						
				}
				if(i==1)
				{
					char temp = board[1][1];
					if((temp == board[0][1] && temp == board[2][1])
							||(temp == board[1][0] && temp == board[1][2])
							||(temp == board[2][0] && temp == board[0][2]))
						return temp;
				}
				if(i==2)
				{
					char temp = board[2][2];
					if ((temp == board[2][1] && temp == board[2][0])
							|| (temp == board[1][2] && temp == board [0][2]))
						return temp;
				}
			}
		}
		return BLANK;
	}
	public static void printBoard(char[][] board)
	{
		System.out.println("A " + board[0][0] + " | " + board[0][1] +" | "+ board[0][2] );
		System.out.println(" ---|---|---");
		System.out.println("B " + board[1][0] + " | " + board[1][1] +" | "+ board[1][2] );
		System.out.println(" ---|---|---");
		System.out.println("C " + board[2][0] + " | " + board[2][1] +" | "+ board[2][2] );
		System.out.println("  " + 1 +"   " +2+"   "+3);
	}
	public static boolean canMakeMove(char[][] board, int row, int collumn)
	{
		return (board[row][collumn]==BLANK);
	}
	public static void makeMove(char[][] board, char currentPlayerPiece, int row, int collumn)
	{
		board[row][collumn]=currentPlayerPiece; 
	}
}
