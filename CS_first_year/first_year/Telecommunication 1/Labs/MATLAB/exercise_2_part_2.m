j=1;
x=-1:0.01:1;
y1 = sawtooth(2*pi*(x+0.25),0.5);
for i =[1,2,3,5,10,50]
    subplot(3,2,j)
    j=j+1
    k=0
    sum=0
    while k<i
        odd = 2*k+1
        sum = sum + ((-1)^k)*sin(2*pi*odd*x)/(odd^2)
        k=k+1;
    end;    
    y2 = 8/(pi^2) * sum;
    hold on
    plot(x, y1, 'r')
    plot(x, y2);
end;    