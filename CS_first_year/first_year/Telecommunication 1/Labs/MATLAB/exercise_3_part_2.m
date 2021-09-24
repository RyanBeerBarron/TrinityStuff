load('array.mat');
x = (0:1/fs:time-1/fs);
plot(x,y);

F = fftshift(abs(fft(y,N)));
x2 = -fs/2:fs/N:fs/2-fs/N;
plot(x2, F);