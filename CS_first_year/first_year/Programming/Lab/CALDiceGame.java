package introduction_programming;
import java.util.Scanner;

public class CALDiceGame
{

	public static void main(String[] args)
	{
		Scanner sc = new Scanner(System.in);
		System.out.println("Welcome to Chuck-A-Luck Dice game. How much money would you want to start with?");
		double money = 0;
		boolean finished = false;
		while(money<=0)
		{
			sc = new Scanner(System.in);
			if (sc.hasNextDouble())
			{
				double temp = sc.nextDouble();
				if(validMoney(temp))
					money = temp;
				else System.out.println("Invalid amount of money.");
			}
			else System.out.println("Invalid input, enter amount of money you want to bet.");
		}	
		Wallet wallet = new Wallet();
		wallet.put(money);
		finished = false;
		while(!finished)
		{
			sc = new Scanner(System.in);
			System.out.println("Please say your bet type, it can be Triple, Field, High or Low. Or type in 'quit' to end.");
			if(sc.hasNext("quit"))
			{
				finished = true;
				System.out.println("Thanks for playing, goodbye.");
			}	
			else if (wallet.check()== 0)
			{
				finished  = true;
				System.out.println("Sorry, you have no more money. Thanks for playing.");
			}
			else if(sc.hasNext("Triple")||sc.hasNext("Field")||sc.hasNext("High")||sc.hasNext("Low"))
			{
				String s = sc.next();
				resolveBet(s, wallet);
			}
		}
		sc.close();
		if(0== wallet.check())
			System.out.println("You've lost all your money, don't gamble as much.");
		else if (money > wallet.check())
			System.out.println("You've lost some money. Better luck next time.");
		else if (money == wallet.check())
			System.out.println("You have the same amount of money. Impressive");
		else if (money < wallet.check())
			System.out.println("You have gained money... GIVE IT BACK YOU PUNK!");
	}	
	public static void resolveBet(String s, Wallet wallet)
	{
		double money = wallet.check();
		System.out.println("You've choosed " + s + " type bet. How much money would you like to bet? You have "+ money);
		Scanner sc = new Scanner(System.in);
		double bet = 0;
		while(bet<=0)
		{
			sc = new Scanner(System.in);
			if (sc.hasNextDouble())
			{
				double temp = sc.nextDouble();
				if(validMoney(temp))
					bet = temp;
				else System.out.println("Invalid amount of money.");
			}
			else System.out.println("Invalid input, enter amount of money you want to bet.");
		}	
		if(wallet.get(bet))
		{
			Dice d1 = new Dice();
			Dice d2 = new Dice();
			Dice d3 = new Dice();
			int d1Roll = d1.roll();
			int d2Roll = d2.roll();
			int d3Roll = d3.roll();
			int sum = d1Roll + d2Roll + d3Roll;
			System.out.println("The dices rolled " + d1Roll + " " + d2Roll + " "+ d3Roll + ". The total is "+ sum);
			if(s.equals("Triple") && d1Roll == d2Roll && d1Roll == d3Roll && d1Roll != 1 && d1Roll !=6)
			{
				wallet.put(bet*31);
				System.out.println("Well done, you win. You have " + wallet.check());
			}
			else if (s.equals("Field") && (sum>12||sum<8))
			{
				wallet.put(bet*2);
				System.out.println("Well done, you win. You have " + wallet.check());
			}
			else if (s.equals("High")&& sum>10 && (d1Roll != d2Roll || d1Roll != d3Roll || d2Roll != d3Roll))
			{
				wallet.put(bet*2);
				System.out.println("Well done, you win. You have " + wallet.check());
			}
			else if (s.equals("Low")&& sum<11 && (d1Roll != d2Roll || d1Roll != d3Roll || d2Roll != d3Roll))
			{
				wallet.put(bet*2);
				System.out.println("Well done, you win. You have " + wallet.check());
			}
			else System.out.println("Sorry, you lost, more luck next time. You now have " + wallet.check() + " money in your wallet");
		}
		sc.close();
	}
	public static boolean validMoney(double d)
	{
		return(Math.floor(d*100)==d*100);		
	}
}	


