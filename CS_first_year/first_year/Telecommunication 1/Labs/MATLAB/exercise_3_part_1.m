fs = 100;
time = 2;
frequency = 10;
x1 =(0:1/fs:time-1/fs);
y = sin(2*pi*frequency*x1);
subplotnumber = 1;
for N = [64, 128, 256]
    F = fftshift(abs(fft(y,N)));
    x2= -fs/2:fs/N:fs/2-fs/N;
    subplot(2, 2, subplotnumber);
    title(['FFT with ' num2str(N) ' points']);
    hold;
    plot(x2, F);
    subplotnumber = subplotnumber + 1;
end;