
% [image1,map1] = imread('3.jpg');
[image1,map1] =   imread('cameraman.tif');
% [image1,map1] = imread('small.jpeg');
fig_count = 1;
figure(fig_count); imshow(image1) ; title('image'); fig_count = fig_count + 1;

f = fft2(image1);
figure(fig_count); imshow(abs(f),[]) ; title('fft of image'); fig_count = fig_count + 1;

ff = fft2(f);
figure(fig_count); imshow(abs(ff),[]) ; title('fft of fft image'); fig_count = fig_count + 1;

% figure(fig_count); fig_count = fig_count + 1;
% subplot(1,2,1), imshow(image1,map1);

%In the frequency domain (i.e after taking the first fft, we manually flip the image wrt to both x and y direction since we know (by observation))
% that the final image is flipped in both x and y.



% I2 = flipdim(f ,2);           %# horizontal flip
I3 = flipdim(f ,1);           %# vertical flip
I4 = flipdim(I3,2);    %# both directions flipped.

worked_image = fft2(I4);

% figure(fig_count); imshow(image1); fig_count = fig_count + 1;
% figure(fig_count); imshow(I2); fig_count = fig_count + 1;
% figure(fig_count); imshow(I3); fig_count = fig_count + 1;
figure(fig_count); imshow(abs(worked_image),[]);  title('fft of flipped fft image'); fig_count = fig_count + 1;


t = timer('TimerFcn', 'stat=false; disp(''Timer!'')',... 
                 'StartDelay',10);
start(t)

stat=true;
while(stat==true)
%   disp('.')
  pause(1)
end

clear all; close all; clc