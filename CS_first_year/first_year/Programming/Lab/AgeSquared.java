package agesquared;

public class AgeSquared 
{
	public static final int CURRENT_YEAR = 2016;
	public static final int YOUNGEST_AGE = 0;
	public static final int OLDEST_AGE = 123;

	public static void main(String[] args) 
	{
		int age;
		int ageSquared;
		int yearOfBirth;
		int currentAge;
		String answer="";
		for ( age=YOUNGEST_AGE; age<=OLDEST_AGE; age++)
		{
			ageSquared=age*age;
			yearOfBirth=ageSquared-age;
			currentAge= CURRENT_YEAR - yearOfBirth;
			if (currentAge>=YOUNGEST_AGE && currentAge<=OLDEST_AGE)
			{	
				answer = "";
				answer +="In the year " + ageSquared + " people with the age " + age + " will be the square root of the "
						+ "current year.";
				System.out.println(answer);
			}	
		}	
		if (answer=="")
			System.out.println("Sorry nobody alive has ever "
					+ "been or will ever be alive in a year that is the square of their age.");
	}
}