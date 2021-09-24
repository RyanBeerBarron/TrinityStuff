package validdate;
import java.util.Scanner;

public class ValidDate 
{
	public static final int NUMBER_OF_MONTHS = 12;
	public static final int FEBRUARY = 2;
	public static final int APRIL = 4;
	public static final int JUNE = 6;
	public static final int SEPTEMBER = 9;
	public static final int NOVEMBER = 11;
	public static final int DAYS_IN_FEBRUARY = 28;
	public static final int DAYS_IN_FEBRUARY_LEAP_YEAR = 29;
	public static final int SHORT_MONTH = 30;
	public static final int LONG_MONTH = 31;
	
	public static void main(String[] args) 
	{
		Scanner input = new Scanner(System.in);
		System.out.println("Please enter date in the following format "
				+ "(dd mm yyyy)");
		int day = input.nextInt();
		int month = input.nextInt();
		int year = input.nextInt();
		input.close();
		if (!validDate(day, month, year))
			System.out.println("Your date is invalid.");
		else System.out.println(dayOfTheWeek(day, month, year) + ", " + day +
				numberEnding(day) + " " + monthName(month) + " " + year);
	}
	
	public static boolean validDate(int day, int month, int year)
	{
		return year >= 0 && month > 0 & month <= NUMBER_OF_MONTHS && day >0 && day <= daysInMonth(month, year);
	}
	
	public static int daysInMonth(int month, int year)
	{
		if ( month == APRIL || month == JUNE || month == SEPTEMBER || month == NOVEMBER)
		{
			return SHORT_MONTH;
		}
		else if ( month==FEBRUARY)
		{
			if (isLeapYear(year))
				return DAYS_IN_FEBRUARY_LEAP_YEAR;
			else return DAYS_IN_FEBRUARY;
		}
		return LONG_MONTH;
	}
	
	public static boolean isLeapYear(int year)
	{
		return  ((year % 400 == 0) || ((year % 4 == 0) && (year % 100 != 0)));
	}

	public static String numberEnding(int day)
	{
		if ( day % 100 >= 10 && day % 100 <= 20)
			return "th";
		else if (day % 10 == 1)
			return "st";
		else if ( day % 10 == 2)
			return "nd";
		else if (day % 10 == 3)
			return "rd";
		else return "th";
	}

	public static String monthName(int month)
	{
		String monthName;
		switch (month)
		{
		case 1:
			return "January";
		case 2:
			return "February";
		case 3:
			return "March";
		case 4:
			return "April";
		case 5:
			return "Mai";
		case 6:
			return "June";
		case 7:
			return "July";
		case 8:
			return "August";
		case 9:
			return "September";
		case 10:
			return "October";
		case 11:
			return "November";
		case 12:
			return "December";
		default:
			return " ";
		}
	}

	public static String dayOfTheWeek(int day, int month, int year)
	{
		if ( month == 1 || month == 2)
			year--;
		int y = year % 100;
		int c = year / 100;	
		Double w = (day+Math.floor(2.6*(((month + 9)%12)+1)-0.2)+y+Math.floor(y/4)+Math.floor(c/4)-2*c);
		int z = w.intValue();
		z = z % 7;
		switch (z)
		{
		case 0:
			return "Sunday";
		case 1:
			return "Monday";
		case 2:
			return "Tuesday";
		case 3:
			return "Wednesday";
		case 4:
			return "Thursday";
		case 5:
			return "Friday";
		case 6:
			return "Saturday";
		default:
			return "";
		}
	}

}
