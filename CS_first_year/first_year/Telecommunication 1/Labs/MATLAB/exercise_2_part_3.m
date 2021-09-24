j=1;
for i=[1,3,5,10,50,500]
    subplot(3,2,j);
    j=j+1;
    k=1;
    l=0;
    amp=0;
    for k=1:1:i;
        y=4/pi/(2*l+1)
        hold on
        stem(k,y,'b')
        l=l+1
    end;
end;