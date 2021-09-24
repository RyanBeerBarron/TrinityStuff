int x1 = 50;
float y1 = 180;
int x2 = 50;
float y2 = 200;

void setup()
{
  size(200,360);
  background(255);
}
void draw()
{
  background(255);
  fill(50+Math.abs(150*sin(y1/25)),50+Math.abs(50*sin(y1/25)),100+Math.abs(100*sin(y1/25)));
  rect(x1,80+50*sin(y1/25),50,50);
  x1 = x1+1;
  y1 = y1+1;
  if (x1+50>=width)
    rect(0,80+50*sin(y1/25),(x1+50-width),50);
  if (x1>=width)
    x1=0;
  fill(70+Math.abs(120*sin(y1/25)),20+Math.abs(150*sin(y1/25)),60+Math.abs(135*sin(y1/25)));
  rect(x2,180+50*sin(y2/25),50,50);
  x2 = x2-1;
  y2 = y2+1;
  if (x2<0)
    rect(width+x2, 180+50*sin(y2/25), 50,50);
  if (x2<-50)
    x2= width+x2;
}