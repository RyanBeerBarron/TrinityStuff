package twelvedays;

public class TwelveDays 
{
	public static final int NUMBER_OF_VERSES = 12;
	public static final String FIRST_VERSE ="a Partridge in a Pear Tree.\n ";
	public static final String SECOND_VERSE ="2 Turtle Doves\n";
	public static final String THIRD_VERSE ="3 French Hens\n";
	public static final String FOURTH_VERSE ="4 Calling Birds\n";
	public static final String FIFTH_VERSE ="5 Golden Rings\n";
	public static final String SIXTH_VERSE ="6 Geese a Laying\n";
	public static final String SEVENTH_VERSE ="7 Swans a Swimming\n";
	public static final String EIGHTH_VERSE ="8 Maids a Milking\n";
	public static final String NINTH_VERSE ="9 Ladies Dancing\n";
	public static final String TENTH_VERSE ="10 Lords a Leaping\n";
	public static final String ELEVENTH_VERSE ="11 Pipers Piping\n";
	public static final String TWELFTH_VERSE ="12 Drummers Drumming\n";
	
	public static void main(String[] args)
	{
		String day="";
		int n = 0;
		String verse="";
		for (n=1; n<=NUMBER_OF_VERSES; n++)
		{
			switch (n)
			{
			case 1:
				day = "first";
				verse = FIRST_VERSE;
				break;
			case 2:
				day ="second";
				verse =SECOND_VERSE + "and " + verse;
				break;
			case 3:
				day="third";
				verse=THIRD_VERSE + verse;
				break;
			case 4:
				day="fourth";
				verse=FOURTH_VERSE + verse;
				break;
			case 5:
				day="fifth";
				verse=FIFTH_VERSE + verse;
				break;
			case 6:
				day="sixth";
				verse=SIXTH_VERSE + verse;
				break;
			case 7:
				day="seventh";
				verse=SEVENTH_VERSE+ verse;
				break;
			case 8:
				day="eighth";
				verse=EIGHTH_VERSE + verse;
				break;
			case 9:
				day="ninth";
				verse=NINTH_VERSE + verse;
				break;
			case 10:
				day="tenth";
				verse=TENTH_VERSE + verse;
				break;
			case 11:
				day="eleventh";
				verse=ELEVENTH_VERSE + verse;
				break;
			case 12:
				day="twelfth";
				verse=TWELFTH_VERSE + verse;
				break;
			default:
				break;
			}
			String song ="On the " + day +  " day of Christmas\nmy true love sent to me:";
			System.out.println(song);
			System.out.println(verse);
		}
		
	}

}
