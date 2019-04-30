clear all;close all ;clc
fig_count = 1;
right_pad = 64;
bottom_pad = 64;
image1 = imread('Icon.jpg');
fft_image1 = fft2(image1);

% figure(fig_count);imshow(image1);title('64*64 image');fig_count = fig_count + 1;
subplot(2,2,1);imshow(fft_image1);title('FFT 64*64 image');


image2 = padarray(image1,[right_pad,bottom_pad],'post');
fft_image2 = fft2(image2);
% figure(fig_count);imshow(image2);title('128*128 image');fig_count = fig_count + 1;
subplot(2,2,2);imshow(fft_image2);title('FFT 128*128 image');

right_pad = 192;
bottom_pad = 192;
image3 = padarray(image1,[right_pad,bottom_pad],'post');
fft_image3 = fft2(image3);
% figure(fig_count);imshow(image3);title('256*256 image');fig_count = fig_count + 1;
subplot(2,2,3);imshow(fft_image3);title('FFT 256*256 image');


right_pad = 448;
bottom_pad = 448;
image4 = padarray(image1,[right_pad,bottom_pad],'post');
fft_image4 = fft2(image4);
% figure(fig_count);imshow(image4);title('512*512 image');fig_count = fig_count + 1;
subplot(2,2,4);imshow(fft_image4);title('512*512 image');

fig_count = fig_count + 1;

figure(fig_count);stem(abs(rgb2gray(fft_image1)));title('64*64 image');fig_count = fig_count + 1;
figure(fig_count);stem(abs(rgb2gray(fft_image2)));title('128*128 image');fig_count = fig_count + 1;
figure(fig_count);stem(abs(rgb2gray(fft_image3)));title('256*256 image');fig_count = fig_count + 1;
figure(fig_count);stem(abs(rgb2gray(fft_image4)));title('512*512 image');fig_count = fig_count + 1;

