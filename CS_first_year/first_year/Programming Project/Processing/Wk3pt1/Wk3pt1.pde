final int SCREENX = 400;
final int SCREENY = 400;
PImage  myimage;  


/* Declare an Alien */
class Alien {
 /* declare variables for alien position, direction of movement and appearance */
int x, y; int dx, dy; PImage appearance; boolean hitWall; int goDown; int center;
 /* Constructor is passed the x and y position where the alien is to
 be created, plus the image to be used to draw the alien */
 
 Alien(int xpos, int ypos, PImage alienImage){
  /* set up the new alien object */ 
  x=xpos;
  y=ypos;
  appearance = alienImage;
  if(x+appearance.width < SCREENX && x >=0){hitWall=false; dx=1; dy=0;}
  else {hitWall=true; dx=0; dy=1; goDown=appearance.height;}
  if(x+appearance.width>SCREENX){dx=-1;center= x+appearance.width-SCREENX;}
  if(x < 0){dx=1; center = x;}
 }
  
 void move(){
  /* Move the alien according to the instructions in the exercise */
  x=x+dx; y=y+dy;
  if(center !=0){center = center+dx;if(center==0){dx=0;}}
  if(hitWall) 
  {
      goDown=(goDown-dy); 
      if(goDown < 0)
      {
        hitWall=false;dy=0; 
        if(x>SCREENX/2)
        {
          dx=-1;
        }
          else{dx=1;}
      }
  }
  else if(x+appearance.width >= SCREENX || x <= 0)
  {
    dx=0; dy=1;
    goDown=appearance.height; 
    hitWall=true;
  }
}
  
  void draw(){
    /* Draw the alien using the image() method demonstrated in class */
  image(appearance, x, y);
  }
}
Alien myAlien;
void setup(){
 /* create a new alien object */
 size(400,  400 );  background(255);
 PImage img = loadImage("spacer.GIF");
 myAlien = new Alien(10, 10, img);
 println(myAlien.appearance.height);
}

void draw(){
 background(255); /* clear the screen */
  myAlien.move();/* move the alien */
  myAlien.draw();/* draw the alien */
  println(myAlien.appearance.height);
}