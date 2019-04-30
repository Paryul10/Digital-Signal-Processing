load handel.mat

filename = 'handel.wav';
audiowrite(filename,y,Fs);
clear y Fs
[y,Fs] = audioread('handel.wav');

fast=resample(y,1,2);
slow=resample(y,2,1);
sound(y,Fs);
figure(1)
plot(y); title('original'); 
figure(2)
plot(slow);title('slow');
figure(3)
plot(fast);title('fast');

pause(10);

sound(fast,Fs);
pause(5);

sound(slow,Fs);
% pause(8);

% figure(1)
% plot(y); title('original'); 
% figure(2)
% plot(slow);title('slow');
% figure(3)
% plot(fast);title('fast');
