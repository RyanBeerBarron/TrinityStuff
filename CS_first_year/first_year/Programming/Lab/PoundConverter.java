package poundConverter;

import java.util.Scanner;
import javax.swing.JOptionPane;

public class PoundConverter {
	
	public static final int OLD_PENNY_TO_NEW_PENNY = 67;
	public static final int OLD_SHILLING_TO_OLD_PENNY = 12;
	public static final int OLD_POUND_TO_OLD_SHILLING = 20;
	public static final int NEW_POUND_TO_NEW_PENNY = 100;

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String input = JOptionPane.showInputDialog("Enter amount of old pounds, old shillings and old pennies in this format."
				+" (Old Pound:Old Shilling:Old Penny) ");
		Scanner inputScanner = new Scanner ( input );
		inputScanner.useDelimiter(":");
		int oldPound = inputScanner.nextInt();
		int oldShilling = inputScanner.nextInt();
		int oldPenny = inputScanner.nextInt();
		inputScanner.close();
		int totalOldShilling = oldPound * OLD_POUND_TO_OLD_SHILLING + oldShilling;
		int totalOldPenny = totalOldShilling * 	OLD_SHILLING_TO_OLD_PENNY + oldPenny;
		int totalNewPenny = totalOldPenny * OLD_PENNY_TO_NEW_PENNY;
		int totalNewPound = totalNewPenny / NEW_POUND_TO_NEW_PENNY;
		int moduloNewPenny = totalNewPenny % NEW_POUND_TO_NEW_PENNY;
		JOptionPane.showMessageDialog(null, "You have "+ totalNewPound + "£ pounds and " + moduloNewPenny + " pennies.");
		
		
	}

}