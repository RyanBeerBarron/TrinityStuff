final  int  SCREENX  =  320;  
final  int  SCREENY  =  240;  
final  int  PADDLEHEIGHT  =  15;  
final  int  PADDLEWIDTH  =  50;  
final  int  MARGIN  =  10; 

boolean paused = false;
PFont font;
Player  thePlayer;
Ball  theBall;
Computer theComputer;


void  settings()
{  
    size(SCREENX,  SCREENY);
}  
void  setup()
{  
  thePlayer  =  new  Player(SCREENY-MARGIN-PADDLEHEIGHT);  
  theBall  =  new  Ball();
  theComputer = new Computer(MARGIN);
  ellipseMode(RADIUS); 
  font=createFont("Arial", 16,true);
}  

void  draw() 
{  
  background(255);    
  theBall.move();
  thePlayer.move(mouseX);
  theComputer.move();
  theBall.collide(thePlayer);
  theBall.collide(theComputer);
  thePlayer.draw();  
  theBall.draw();
  theComputer.draw();
  if ( theBall.y > SCREENY || theBall.y < 0 )
  {
    paused =true;
  }
  if(paused == true);
  {
    reset();
  }  
}

void reset()
{
    stroke(175);
    textFont(font);
    if(theBall.y>=SCREENY)
    {
      thePlayer.playerLives = thePlayer.playerLives-1;
      if(thePlayer.playerLives == 0)
      {
      textAlign(CENTER);
      text("Gane over, the computer wins.", width/2, height/2); 
      stop();
      }
    }  
    if(theBall.y<=0)
    {
      theComputer.computerLives = theComputer.computerLives-1;
      if(theComputer.computerLives == 0 )
      {
        textAlign(CENTER);
        text("Game over, you win.", width/2, height/2); 
        stop();
      }  
    }
    else textAlign(CENTER);
    text("Game over, click to start again.", width/2, height/2); 
    {
      if(mousePressed==true)
      {
        loop();
        theBall  =  new  Ball(); 
      }    
  }
}