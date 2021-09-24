j=1;
x=-1:0.01:1;
y1 = square(2*pi*x);
for i=[1,3,5,10,50,500]
    subplot(3,2,j);
    j=j+1;
    k=0;
    sum=0;
    while k<i
        sum = sum + sin(2*pi*(2*k+1)*x)/(2*k+1);
        k=k+1;
    end;
    y2 = 4/pi*sum;
    hold on;
    plot(x,y2);
    plot(x,y1,'r');
    
end;