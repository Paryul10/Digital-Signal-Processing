[a,Fs] = audioread('sa_re_ga_ma.mp3');
b = smoothdata(a);
c = smoothdata(a,'gaussian');
d = smoothdata(a,'sgolay');
e = smoothdata(a,'loess');
f = smoothdata(a,'lowess');
g = smoothdata(a,'movmedian');


figure;plot(a);title('orginal');
sound(a,Fs);
pause(30);

figure;plot(b);title('smoothened');
sound(b,Fs);
pause(30);


figure;plot(c);title('smoothened-gaussian');
sound(c,Fs);
pause(30);

figure;plot(d);title('smoothened-sgolay');
sound(d,Fs);
pause(30);


figure;plot(e);title('loess');
sound(e,Fs);
pause(30);


figure;plot(f);title('lowess');
sound(f,Fs);
pause(30);

figure;plot(g);title('move-median');
sound(g,Fs);
pause(30);


