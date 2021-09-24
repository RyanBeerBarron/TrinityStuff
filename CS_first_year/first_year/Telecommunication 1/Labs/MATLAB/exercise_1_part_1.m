x = -2*pi:0.1:2*pi;
y1 = cos(x);
y2 = 0.5*sin(x);
hold on;
plot(x,y1,'k');
stem(x,y2,'r');

