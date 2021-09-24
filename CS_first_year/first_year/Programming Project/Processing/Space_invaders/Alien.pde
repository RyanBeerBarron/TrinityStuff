final int ALIEN_ALIVE=0;
final int ALIEN_DEAD=16;
final int FORWARD=0;
final int BACKWARD=1;

class Alien {
  int x, y, direction;
  int status;
  PImage normalImg, explodeImg;
  Bomb aBomb;
  boolean hasBomb= false;
  float r;
// The constructor is passed the position of the Alien on screen
// and the images to use
  Alien (int xpos, int ypos, PImage okImg, PImage exImg){
    x = xpos; 
    y = ypos;
    status = ALIEN_ALIVE;
    normalImg=okImg; 
    explodeImg=exImg;
    direction=FORWARD;
  }

/*If we are moving forward, check to see if we have hit the right
 hand side of the window, if moving backward, check to see if we
 have hit the left hand side of the window. */
  void move(){
    if(direction==FORWARD){
      if(x+normalImg.width<SCREENX-MARGIN-1)
        x++;
      else{
        direction=BACKWARD;
        y+=normalImg.height+GAP;
      }
    }
    else if(x>MARGIN+1) x--;
    else {
      direction=FORWARD;
      y+=normalImg.height+GAP;
    }
  r = random(100);
  if(status == ALIEN_ALIVE&&!hasBomb && r>=1 && r<2)
  {
    aBomb = new Bomb(x+normalImg.width/2-BOMBWIDTH/2, y+normalImg.height); 
    hasBomb = true;
  }
}
/* If we are alive, draw the alien
 if we are exploding, draw the explosion
 and move on to the next "exploding" state
 if we are dead, don't draw anything. */
  void draw(){
    if(status==ALIEN_ALIVE)
      image(normalImg, x, y);
    else if(status!=ALIEN_DEAD){
      image(explodeImg, x, y);
      status++;
    }
    // otherwise dead, don't draw anything
  }
  
/* Start exploding. */
  void die(){
    if(status==ALIEN_ALIVE)
      status++;
  }
  
  Bomb getBomb()
  {
    return aBomb;
  }  
  
}