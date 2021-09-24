final int SCREENX = 400;
final int SCREENY = 400;
final int PADDLEHEIGHT = 15;  
final int PADDLEWIDTH = 52;
final int CANNONHEIGHT = 15;
final int CANNONWIDTH = 10;
final int MARGIN = 10;
final int GAP = 5;
final int BULLETWIDTH=5;
final int BULLETHEIGHT=5;
final int BOMBWIDTH = 10;
final int BOMBHEIGHT = 10;

Alien myAliens[];
Player thePlayer;
Bullet bullet;
Bomb bomb;
PImage spacer; 
PImage explosion;
PImage alternateSpacer;
boolean bulletOnScreen=false;
void setup()
{
  size(400, 400); background(255);
  myAliens=new Alien[10];
  thePlayer = new Player(SCREENY-MARGIN-PADDLEHEIGHT);
  bomb = new Bomb(200,200);
  spacer = loadImage("spacer.GIF");
  explosion = loadImage("exploding.GIF");
  init_aliens(myAliens, spacer, explosion);
}
void init_aliens(Alien myAliens[],PImage img, PImage explode )
{
  for(int i=0; i<myAliens.length; i++)
    myAliens[i] = new Alien(10+(i*30), 10, img, explode);  
}
void draw()
{
  if(mousePressed==true && !bulletOnScreen )
  {
    bullet = new Bullet(thePlayer.cannonXPos, thePlayer.cannonYPos);
    bulletOnScreen=true;
  }
  background(255);
  thePlayer.move(mouseX);
  move_Aliens(myAliens);
  
  if(bulletOnScreen)
  {
    bullet.move();
    bullet.collide(myAliens);
  }
  thePlayer.draw();
  if(bulletOnScreen)
  {
    bullet.draw();
  }
  draw_Aliens(myAliens);
  if(bulletOnScreen)
  {
    if(bullet.positionY<=0)
    {
      bulletOnScreen = false;
    }
  }
  winCondition();
}
void draw_Aliens(Alien myAliens[])
{
  for(int i=0; i<myAliens.length; i++)
  {
    myAliens[i].draw();
     
  }
}

void move_Aliens(Alien myAliens[])
{
  for(int i=0; i<myAliens.length; i++)
  {
    myAliens[i].move();
    if(myAliens[i].hasBomb)
    {
      Bomb aBomb = myAliens[i].getBomb();
      aBomb.move();
      aBomb.draw();
      if(aBomb.collide(thePlayer.xpos, thePlayer.ypos))
      {
        gameOver();
      }  
      if(aBomb.offScreen())
      {
        myAliens[i].hasBomb = false;
      }  
    }  
  }  
}
void gameOver()
{
  noLoop();
  text("GAME OVER", SCREENX/2, SCREENY/2);
}

void winCondition()
{
  boolean allAliensDead = true;
  for( int i = 0; i<myAliens.length; i++)
  {
    if(myAliens[i].status == ALIEN_ALIVE)
    {
      allAliensDead = false;
    }  
  }  
  if(allAliensDead)
  {
    noLoop();
    text("you win", SCREENX/2, SCREENY/2);
  }
}  