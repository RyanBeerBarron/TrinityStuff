class Bullet {
  /* Insert the code for your Bullet class here.
You need: variables to store the position aand appearance of the bullet.
A constructor
A method to move the bullet
A method to draw the bullet
A method to check for collisions
*/
  int positionX, positionY;
  color bulletcolor = color(0);
  Bullet(int x, int y)
  {
    positionX = x+CANNONWIDTH/2-BULLETWIDTH/2;
    positionY = y-CANNONHEIGHT;
  }
  void move()
  {
    positionY=positionY-3;
  }  
  void draw()
  {
    fill(bulletcolor);
    rect(positionX, positionY, CANNONWIDTH, CANNONHEIGHT);
  }
  void collide(Alien[] myAliens)
  {
    for(int i =0; i<myAliens.length; i++)
    {
      if((positionX>myAliens[i].x && positionX<myAliens[i].x+myAliens[i].normalImg.width) || (positionX+BULLETWIDTH>myAliens[i].x &&positionX+BULLETWIDTH<myAliens[i].x+myAliens[i].normalImg.width))
      {
        if((positionY+BULLETHEIGHT>=myAliens[i].y && positionY+BULLETHEIGHT<=myAliens[i].y+myAliens[i].normalImg.height) || (positionY>=myAliens[i].y && positionY<=myAliens[i].y+myAliens[i].normalImg.height))
        {
          myAliens[i].die();
        }  
      }
    } 
  }
}