[yy,Fs] = audioread('signal_3.wav');
fig_count = 1;



fl = 1000;
figure(fig_count); stem(yy); title('Original_3'); fig_count = fig_count + 1;

nfl = (fl / (Fs/2));



% [z,p,k] = butter(9,2100/(Fs/2)),'high');
% sos = zp2sos(z,p,k);
% fvtool(sos,'Analysis','freq')

% filtered_sound_0 = highpass(y,2100/(Fs/2));
% figure(fig_count); fig_count = fig_count + 1;
% % freqz(b,a)

% YY = fft(filtered_sound_0);
% figure(fig_count); stem(abs(YY)); title('FFT high'); fig_count = fig_count + 1;

[b,a] = butter(6,nfl,'low');
filtered_sound = filter(b,a,yy);
% figure(fig_count); fig_count = fig_count + 1;

% freqz(b,a)


figure(fig_count); stem(filtered_sound); title('Filtered'); fig_count = fig_count + 1;

sound(yy,Fs);
pause(15);
sound(filtered_sound,Fs);
pause(15);



% freq_dist_y = fftshift(fft(y));

% Y_abs = abs(freq_dist_y);
% % Y_abs = abs(freq_dist_y);

% figure(2); stem(Y_abs);

% len = size(y,1);
% figure(3);
% subplot(2,1,1);stem(1:len, y(:,1));title('Left Channel');
% subplot(2,1,2);stem(1:len, y(:,2));title('Right Channel');

% freq_res = Fs / len;
% w = (-(len/2):(len/2)-1)*freq_res;
% y1 = fft(y(:,1), len) / len; % For normalizing, but not needed for our analysis
% y2 = fftshift(y1);
% figure(4);plot(w,abs(y2));

% n = 7;
% beginFreq = 10 / (Fs/2);
% endFreq = 700 / (Fs/2);
% [b,a] = butter(n, [beginFreq, endFreq], 'bandpass');

% fout = filter(b, a, y);
% sound(fout);



% Fn = Fs/2;                                              % Nyquist Frequency (Hz)
% Wp = 1000/Fn;                                           % Passband Frequency (Normalised)
% Ws = 1010/Fn;                                           % Stopband Frequency (Normalised)
% Rp =   1;                                               % Passband Ripple (dB)
% Rs = 150;                                               % Stopband Ripple (dB)
% [n,Ws] = cheb2ord(Wp,Ws,Rp,Rs);                         % Filter Order
% [z,p,k] = cheby2(n,Rs,Ws,'low');                        % Filter Design
% [soslp,glp] = zp2sos(z,p,k);                            % Convert To Second-Order-Section For Stability
% figure(3)
% freqz(soslp, 2^16, Fs)                                  % Filter Bode Plot
% filtered_sound = filtfilt(soslp, glp, y);
% sound(filtered_sound, Fs)
