clear all;close all ;clc
load('Q4.mat')
fig_count = 1;
sound(X ,Fs);
pause(5);

fft_sound = fft(X);
figure(fig_count);plot(X);title('Noisy Signal');fig_count = fig_count + 1;
figure(fig_count);plot(abs(fft_sound));title('FFT- Noisy Signal');fig_count = fig_count + 1;

denoised = smoothdata(X,'gaussian');
figure(fig_count);plot(denoised);title('Denoised Signal');fig_count = fig_count + 1;
figure(fig_count);plot(abs(fft(denoised)));title('FFT- Denoised Signal');fig_count = fig_count + 1;
sound(denoised,Fs);