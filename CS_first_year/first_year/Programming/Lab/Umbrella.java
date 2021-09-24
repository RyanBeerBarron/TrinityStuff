package umbrella;

import javax.swing.JOptionPane;

public class Umbrella
{

	public static void main(String[] args)
	{
		int answer = JOptionPane.showConfirmDialog(null, "Is it raining outside at the moment? ");
		if (answer == JOptionPane.YES_OPTION)
			JOptionPane.showMessageDialog(null, "Take your umbrella with you and put it up.");
		else 
		{
			answer = JOptionPane.showConfirmDialog(null, "Will it rain in the next few hours? ");
			if (answer == JOptionPane.YES_OPTION)
				JOptionPane.showMessageDialog(null, "Take your umbrella with you in case it starts raining.");
			else
				JOptionPane.showMessageDialog(null, "You do not need to take your umbrella with you.");
		}
	}
}
