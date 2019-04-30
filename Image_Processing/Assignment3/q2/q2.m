clear all;close all ;clc
fig_count = 1;
pad_val_1 = 128;
pad_val_2 = 127;
f = double(rgb2gray(imread('image1.jpeg')));
h = imread('image2.png');

F = fft2(f);
H = fft2(h);

ifft_image = ifft2(F.*H);
figure(fig_count);imshow(abs(ifftshift(ifft_image)),[]);title('IFFT IMAGE');fig_count = fig_count + 1;

conv_image = conv2(f,h);
centre_image = conv_image(128:383 , 128:383);
figure(fig_count);imshow(abs((centre_image)),[]);title('Centre convoluted IMAGE');fig_count = fig_count + 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if centre_image == ifft_image
    disp('Images Correspond');
else 
    disp('Images do not Correspond');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

error_b = mean(mean((ifft_image-centre_image).*(ifft_image-centre_image)));
disp('Error:'); disp(error_b);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%PART C
pad_val_2 = 255;
f_padded = padarray(f,[pad_val_2,pad_val_2],'post');
h_padded = padarray(h,[pad_val_2,pad_val_2],'post');

F_padded = fft2(f_padded);
H_padded = fft2(h_padded);

ifft_padded_image = ifft2(F_padded.*H_padded);

figure(fig_count);imshow(abs((ifft_padded_image)),[]);title('IFFT Padded IMAGE');fig_count = fig_count + 1;
figure(fig_count);imshow(abs(conv_image),[]);title('Convoluted Image');fig_count = fig_count + 1;

error_c = mean(mean((ifft_padded_image-conv_image).*(ifft_padded_image-conv_image)));
disp('Error after padding:'); disp(error_c);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
