int x = 50;
int y = 50;


void setup()
{
  size(640,360);
  background(255);
}
void draw()
{
  background(255);
  fill(255,0,0);
  rect(x,y,50,50);
  x = x+1;
  if (x+50>=width)
    rect(0,y,(x+50-width),50);
  if (x>=width)
    x=0;
    
}