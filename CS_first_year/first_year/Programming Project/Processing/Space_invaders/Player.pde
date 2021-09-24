class Player{
  int xpos;
  int ypos;
  int cannonXPos;
  int cannonYPos;
  color paddlecolor = color(50);
  Player(int screen_y)
  {
    xpos=SCREENX/2;
    ypos=screen_y;
  }
  void move(int x)
  {
    if(x>SCREENX-PADDLEWIDTH)
    {
      xpos= SCREENX-PADDLEWIDTH;
    }
    else
    {
      xpos=x;
    }
    cannonXPos = xpos+PADDLEWIDTH/2-CANNONWIDTH/2;
    cannonYPos = ypos-PADDLEHEIGHT;
  }
  void draw()
  {
    fill(paddlecolor);
    rect(xpos, ypos, PADDLEWIDTH, PADDLEHEIGHT);
    rect(cannonXPos, cannonYPos, CANNONWIDTH, CANNONHEIGHT);
  }
}  