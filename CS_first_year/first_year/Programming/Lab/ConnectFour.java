package introduction_programming;
import java.util.Scanner;

public class ConnectFour 
{
	public final static char BLANK = ' ';
	public final static char NOUGHTS = 'O';
	public final static char CROSSES  = 'X';
	public final static int BOARD_ROWS = 10;
	public final static int BOARD_COLUMNS = 10;
	public static final int PIECES_IN_A_ROW_TO_WIN = 5;
	
	public static void main(String[] args) 
	{
		char[][] board = new char[BOARD_ROWS][BOARD_COLUMNS];
		clearBoard(board);
		char currentPlayerPiece = CROSSES;
		Scanner sc = new Scanner(System.in);
		while(!(fullBoard(board))&&winner(board)==BLANK)
		{
			printBoard(board);
			int column = -1;
			do
			{
				sc = new Scanner(System.in);
				System.out.print("Enter move for " + currentPlayerPiece + ":");
				if(sc.hasNextInt())
				{
					column = sc.nextInt();
					if (column>=1 && column <=7)
					{
						column -= 1;
						if(!canMakeMove(board, column))
						{	
							System.out.println("Invalid entry. This location is already occupied.");
						}
					}
					else column = -1;
				}	
				else System.out.println("Invalid entry. You must enter valid collumn.");
			}while((column==-1) || !canMakeMove(board,column));
			makeMove(board, column, currentPlayerPiece);
			currentPlayerPiece = (currentPlayerPiece==CROSSES)?NOUGHTS:CROSSES;	
		}
		printBoard(board);
		if(winner(board)==BLANK)
			System.out.println("It was a draw.");
		else System.out.println("The winner was " + winner(board));
		sc.close();
	}
	public static void clearBoard(char[][] board)
	{
		for( int i = 0; i<BOARD_ROWS; i++)
		{
			for ( int j = 0; j<BOARD_COLUMNS; j++)
			{
				board[i][j] = BLANK;
			}
		}
	}

	public static boolean isBoardFull(char[][] board)
	{
		for ( int i =0; i<BOARD_ROWS; i++)
		{
			for ( int j=0; j<BOARD_COLUMNS; j++)
			{
				if(board[i][j]==BLANK)
					return false;
			}
		}
		return true;
	}	

	public static char winner(char[][] board)
	{
		char temp = BLANK;
		int count = 0;
		for ( int row = 0; row<BOARD_ROWS ; row++)
		{
			for( int column = 0; column<BOARD_COLUMNS; column++)
			{
				if(column<=BOARD_COLUMNS-PIECES_IN_A_ROW_TO_WIN)
				{
					count=1;
					temp = board[row][column];
					for(int j=1; j<PIECES_IN_A_ROW_TO_WIN && temp !=BLANK; j++)
					{
						if(temp == board[row][column+j])
							count++;
					}
					if(count==PIECES_IN_A_ROW_TO_WIN)
						return temp;
				}
				if(row<=BOARD_ROWS-PIECES_IN_A_ROW_TO_WIN)
				{
					count=1;
					temp = board[row][column];
					for(int j=1; j<PIECES_IN_A_ROW_TO_WIN && temp !=BLANK; j++)
					{
						if(temp == board[row+j][column])
							count++;
					}
					if(count==PIECES_IN_A_ROW_TO_WIN)
						return temp;
				}
				if(row<=BOARD_ROWS-PIECES_IN_A_ROW_TO_WIN && column<=BOARD_COLUMNS-PIECES_IN_A_ROW_TO_WIN)
				{
					count=1;
					temp = board[row][column];
					for(int j=1; j<PIECES_IN_A_ROW_TO_WIN && temp !=BLANK; j++)
					{
						if(temp == board[row+j][column+j])
							count++;
					}
					if(count==PIECES_IN_A_ROW_TO_WIN)
						return temp;
				}
				if(row<=BOARD_ROWS-PIECES_IN_A_ROW_TO_WIN && column>=PIECES_IN_A_ROW_TO_WIN-1)
				{	
					count=1;
					temp = board[row][column];
					for(int j=1; j<PIECES_IN_A_ROW_TO_WIN && temp !=BLANK; j++)
					{
						if(temp == board[row+j][column-j])
							count++;
					}
					if(count==PIECES_IN_A_ROW_TO_WIN)
						return temp;
				}
			}
		}
		return BLANK;
	}

	public static boolean fullBoard(char[][] board)
	{
		for (int i =0; i<BOARD_ROWS; i++)
		{
			for (int j=0; j<BOARD_COLUMNS; j++)
			{
				if(board[i][j]==BLANK)
					return false;
			}
		}
		return true;
	}

	public static void printBoard(char[][] board)
	{
		for( int row=0; row<BOARD_ROWS; row++)
		{
			for( int column=0; column<BOARD_COLUMNS; column++)
			{
				System.out.print(" | "+board[row][column]);
			}
			System.out.println(" |");
		}
		
		for(int row=0; row<2; row++)
		{
			for ( int column=0; column<BOARD_COLUMNS; column++)
			{
				if(column==0 && row==0)
					System.out.print(" ");
				if(row==0)
					System.out.print("----");
				if (row==1)
					System.out.print("   "+ (column+1));
			}
			if(row==0)
				System.out.println("-");
			if(row==1)
				System.out.println();
		}
	}

	public static boolean canMakeMove(char[][] board, int column)
	{
		boolean canMakeMove=false;
		for( int i=BOARD_ROWS-1; i>=0 && !canMakeMove; i--)
		{
			if(board[i][column]==BLANK)
			{
				canMakeMove = true;
			}
		}
		return canMakeMove;
	}

	public static void makeMove(char[][] board, int column, char playerPiece)
	{
		boolean finished = false;
		for( int i =BOARD_ROWS-1; i>=0 && !finished ; i--)
		{
			if(board[i][column]==BLANK)
			{	
				board[i][column] = playerPiece;
				finished = true;
			}
		}
		
	}
}











