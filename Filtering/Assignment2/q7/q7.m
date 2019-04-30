%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PART 1- MY SPECTOGRAM %%%%%%%%%%%%%%%%%%%%%%
fig_count = 1;

windowsize = 1000;
stride = 500;
nfft = 2048;

[y,Fs] = audioread('chirp.wav');
% sound(y,Fs);
my_spec = myspectrogram(y, windowsize, stride,nfft);
figure(fig_count); plot(abs(my_spec)); title('My Spectogram') ; fig_count = fig_count + 1;
inbuilt_spec = spectrogram(y, windowsize, stride, nfft);
figure(fig_count); plot(abs(inbuilt_spec)); title('Inbuilt Spectogram');fig_count = fig_count + 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PART 2 - DARTH VEDAR %%%%%%%%%%%%%%%%%%%%%

[yy,FFs] = audioread('message.wav');
joker = spectrogram(yy, 700, 200 , 1024);
figure(fig_count); imshow(joker); title('HA HA HA!!!'); fig_count = fig_count + 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PART 3 - AUDIO GENERATION %%%%%%%%%%%%%%%%
roll_no = 20171083;
arr = dial_tone(roll_no);
audio_spec = spectrogram(arr, 500, 100 , 1024);
figure(fig_count); imshow(audio_spec); title('Dial Tone Spectogram'); fig_count = fig_count + 1;




t = timer('TimerFcn', 'stat=false; disp(''Timer!'')',...
                 'StartDelay',10);
start(t)

stat=true;
while(stat==true)
%   disp('.')
  pause(1)
end
clear all; close all; clc



function spec = myspectrogram(x, windowsize, stride, nfft)
    
    w = hamming(windowsize); % rect function
    n_rows = ceil((nfft + 1) / 2);
    col = 1;
    n_cols = 1 + fix((size(x, 1) - windowsize) / (windowsize-stride));  % fix - round toward zero
    i = 0;
    spec = zeros(n_rows, n_cols);
    len = size(x,1);
    while 1
        if i + windowsize > len
            break
        end
        begin = i + 1;
        fin = i + windowsize;
        currWindow = x(begin:fin);
        currWindow = currWindow.*w;
        X = fft(currWindow, nfft);
        spec(:, col) = X(1:n_rows);  
        jump = windowsize-stride;
        col = col + 1;
        i = i + jump;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%2nd Function%%%%%%%%%%%%%%%%%%%5


function [tune] = dial_tone(num)
    roll_num = [];
    tune = [];
    fs = 4e3;
    s = num2str(num);
    freqs_num = [941 1336];
    freqs_num = [freqs_num ; 697 1209]; 
    freqs_num = [freqs_num ; 697 1336]; 
    freqs_num = [freqs_num ; 697 1477]; 
    freqs_num = [freqs_num ; 770 1209]; 
    freqs_num = [freqs_num ; 770 1336]; 
    freqs_num = [freqs_num ; 770 1477]; 
    freqs_num = [freqs_num ; 852 1209]; 
    freqs_num = [freqs_num ; 852 1336]; 
    freqs_num = [freqs_num ; 852 1477];

    
    for i=1:8
        roll_num(i) = str2double(s(i:i));
    end
        
    t = 0:1/fs:0.5-1/fs;
    
    for i = 1:8
        freq_1 = freqs_num(roll_num(i)+1,1);
        freq_2 = freqs_num(roll_num(i)+1,2);
        dial_tone_num = sum(sin(2*pi*[freq_1;freq_2].*t))';
        tune = [tune;dial_tone_num;zeros(size(dial_tone_num))];
    end

    file = 'sample.wav';
    audiowrite(file, tune, fs);
end

