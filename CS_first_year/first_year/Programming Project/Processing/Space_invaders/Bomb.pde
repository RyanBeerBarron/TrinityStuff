class Bomb{

  int positionX,  positionY;
  boolean collide = false;
  color bombColor = color(80);
  Bomb(int x, int y)
  {
    positionX = x;
    positionY = y;
  }
  void move()
  {
    positionY+=1;
  }
  void draw()
  {
    fill(bombColor);
    rect(positionX, positionY, BOMBWIDTH, BOMBHEIGHT);
  }
  boolean offScreen()
  {
    return (positionY > SCREENY);
  }
  boolean collide(int x, int y)
  {
    if((positionX>=x && positionX<x+PADDLEWIDTH)||(positionX+BOMBWIDTH>x && positionX+BOMBWIDTH<=x+PADDLEWIDTH))
    {
      if((positionY>=y && positionY<y+PADDLEHEIGHT)||(positionY+BOMBHEIGHT>y && positionY+BOMBHEIGHT<=y+PADDLEHEIGHT))
      {
        collide=true;
        return collide;
      }
    }
    collide = false;
    return collide;
  }  
}  