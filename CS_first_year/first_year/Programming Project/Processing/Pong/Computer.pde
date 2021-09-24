class Computer {
  int xpos; int ypos; int computerLives = 3;
  color  paddlecolor  =  color(50);
  Computer(int screen_y)
  {
    xpos = SCREENX/2;
    ypos=screen_y;
  }
  void draw(){
    fill (paddlecolor);
    rect(xpos, ypos, PADDLEWIDTH, PADDLEHEIGHT);
  }
  void move (){
   if(theBall.x> xpos+PADDLEWIDTH ) xpos = xpos+2;
   if(theBall.x< xpos ) xpos = xpos - 2;
  }
}