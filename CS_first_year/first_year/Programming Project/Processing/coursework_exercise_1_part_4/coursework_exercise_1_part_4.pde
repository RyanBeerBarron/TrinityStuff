int x1 = 50;
int y1 = 50;
int x2 = 50;
int y2 = 150;

void setup()
{
  size(200,360);
  background(255);
}
void draw()
{
  background(255);
  fill(255,0,0);
  rect(x1,y1,50,50);
  x1 = x1+1;
  if (x1+50>=width)
    rect(0,y1,(x1+50-width),50);
  if (x1>=width)
    x1=0;
  fill(0,255,0);
  rect(x2,y2,50,50);
  x2 = x2-1;
  if (x2<0)
    rect(width+x2, y2, 50,50);
  if (x2<-50)
    x2= width+x2;
}