package assignment_3_HT;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;
import org.junit.Test;


public class CompetitionTests {

    @Test
    public void testDijkstraConstructor() 
    {
    	CompetitionDijkstra competition = new CompetitionDijkstra("tinyEWD.txt", 50, 60, 80);
    	assertEquals("Test", 38, competition.timeRequiredforCompetition());
    	competition = new CompetitionDijkstra("1000EWD.txt", 50, 60, 80);
    	System.out.println("The minimum time required is: " + competition.timeRequiredforCompetition());
    }

    @Test
    public void testFWConstructor() 
    {
    	CompetitionFloydWarshall competition = new CompetitionFloydWarshall("tinyEWD.txt", 50, 60, 80);
    	assertEquals("Test Floyd Warshall", 38, competition.timeRequiredforCompetition());
    }

    //TODO - more tests
    
}
