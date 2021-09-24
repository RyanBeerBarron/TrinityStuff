[notes,fsampling]   = audioread('exercise notes.wav');
plot(notes);
note1 = notes(1:6500);
note2 = notes(6500:10001);


N = 45000;
F = fftshift(abs(fft(note1,N)));
x = -fsampling/2:fsampling/N:fsampling/2-fsampling/N;
subplot(2,1,1);
plot(x, F);

F = fftshift(abs(fft(note2,N)));
subplot(2,1,2);
plot(x, F);