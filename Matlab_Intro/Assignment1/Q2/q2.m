myvoice = audiorecorder(44100, 24, 1);
disp('Start speaking');
recordblocking(myvoice, 5);
disp('End of Recording');
voicedata = getaudiodata(myvoice);

figure(1);plot(voicedata);title('original');

% sound(voicedata,44100);
% pause(6);

of = 44100;
f1 = 24000;
y1 = resample(voicedata,f1,of);
figure(2);plot(y1);title(['freq =' num2str(f1)]);
% sound(y1, f1);
% pause(6);
 
f2 = 16000;
y2 = resample(voicedata,f2,of);
figure(3);plot(y2);title(['freq =' num2str(f2)]);
% sound(y2, f2);
% pause(6);

f3 = 8000;
y3 = resample(voicedata,f3,of);
figure(4);plot(y3);title(['freq =' num2str(f3)]);
% sound(y3, f3);
% pause(6);

f4 = 4000;
y4 = resample(voicedata,f4,of);
figure(5);plot(y4);title(['freq =' num2str(f4)]);
% sound(y4, f4);
% pause(6);

% [han,fs] = audioread('handel.wav');

disp('Small Church');
[h1, Fs] = audioread('Small_Church.wav');
% sound(h1, Fs);
convo = conv2(voicedata, h1)
env1 = audioplayer(convo, Fs);
figure(6);plot(convo);title('In small church');
% play(env1);
% pause(6);

disp('Large Hall');
[h2, Fs] = audioread('Big_Hall.wav');
% sound(h2, Fs);
convo = conv2(voicedata, h2)
env2 = audioplayer(convo, Fs);
figure(7);plot(convo);title('In large hall');
% play(env2);
% pause(6);

disp('Wide Hall');
[h3, Fs] = audioread('Wide_Hall.wav');
% sound(h3, Fs);
convo = conv2(voicedata, h3)
env3 = audioplayer(convo, Fs);
figure(8);plot(convo);title('In wide hall');
% play(env3);
% pause(6);

