package introduction_programming;
import java.awt.Font;	

public class StdDrawDemo {
  public static void main(String[] args) {
    /** 
     * Draw a square centered at (0.2, 0.8) with side of length twice
     * 0.1 (side length 0.2).
     **/
    StdDraw.square(0.2, 0.8, 0.1);

    /**
     * Draw a filled square centered on (0.8, 0.8) with side of length 
     * twice 0.2 (side length 0.4).
     **/
    StdDraw.filledSquare(0.8, 0.8, 0.2);

    /**
     * Set drawing pen radius to 0.02 (default pen radius is 0.002).
     **/
    StdDraw.setPenRadius(0.02);
 
    /**
     * Draw a circle centered on (0.8, 0.2) with radius of length 0.2.
     */
    StdDraw.circle(0.8, 0.2, 0.2);

    /**
     * Reset drawing pen radius (default pen radius is 0.002).
     **/
    StdDraw.setPenRadius();

    /**
     * Draw a blue diamond:
     * Set drawing pen colour to blue (default pen colour is black).
     **/
    StdDraw.setPenColor(StdDraw.BLUE);

    /**
     * Create an array storing the X-coordinates of the vertexes of 
     * the diamond (or any polygon) in anti-clockwise order. 
     **/
    double[] x = { 0.1, 0.2, 0.3, 0.2 };

    /**
     * Create an array storing the Y-coordinates of the vertexes of 
     * the diamond (or any polygon) in anti-clockwise order. 
     **/
    double[] y = { 0.2, 0.3, 0.2, 0.1 };

    /**
     * Draw a filled polygon with vertexes defined by a X-coordinate 
     * array and a Y-coordinate array.
     **/
    StdDraw.filledPolygon(x, y);

    /**
     * Set drawing pen colour to black.
     **/
    StdDraw.setPenColor(StdDraw.BLACK);

    /**
     * Draw text "black text" centered at (0.2, 0.5) using current pen
     * color and text font; default font is Sans Serif plain style  
     * with point size 16.
     **/
    StdDraw.text(0.2, 0.5, "black text"); 
       
    /**
     * Set drawing pen colour to white.
     **/
    StdDraw.setPenColor(StdDraw.WHITE);

    /**
     * Create a new Font object named arial_italic_30pt.
     **/
    Font arial_italic_30pt = new Font("Arial", Font.ITALIC, 30);

    /**
     * Set current text font to arial_italic_30pt.
     **/
    StdDraw.setFont(arial_italic_30pt);

    /**
     * Draw text "white text" centered at (0.8, 0.8) using current pen
     * colour and text font.
     **/
    StdDraw.text(0.8, 0.8, "white text");

    /**
     * Set drawing pen colour to red (default pen colour is black).
     **/
    StdDraw.setPenColor(StdDraw.BOOK_RED);

    for(int start = 0, end = 1; end < 361; end++) {
      /**
       * Draw arc (of circle) centered at (0.8, 0.2) radius 0.1 from
       * angle start to angle end (in degrees).
       **/
      StdDraw.arc(0.8, 0.2, 0.1, start, end);

      /**
       * Display on screen, pause for 10 milliseconds, and turn on 
       * animation mode: subsequent calls to drawing methods will not
       * be displayed on screen until the next call to show.
       **/
      StdDraw.show(10);

      /**
       * Start of next arc is end of previous arc.
       **/
      start = end;
    }
  }
}

