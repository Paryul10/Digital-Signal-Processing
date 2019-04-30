clear all;close all; clc;
fig_count = 1;
image1 = imread('cameraman.tif');
figure(fig_count);stem(abs(fft2(image1)));title('FFT Original');fig_count = fig_count + 1;

window_size = 10;
output = mean_filter(image1,window_size);
% figure(fig_count);imshow(uint8(output));title('Averaging/Low pass filter');fig_count = fig_count + 1;

figure(fig_count);stem(abs(fft2(output)));title('FFT Filtered');fig_count = fig_count + 1;

out = pbj(image1,window_size);
figure(fig_count);stem(abs(fft2(out)));title('FFT Filtered fast');fig_count = fig_count + 1;

function output = mean_filter(I,N)
padding = floor(N/2);
padded_image = padarray(I, [padding,padding]);
col_vec = im2col(padded_image,[N,N],'sliding');
col_mean = mean(col_vec);
output = col2im(col_mean,[N,N],size(padded_image),'sliding');
end


function out = pbj(I,k)
    [m,n] = size(I);
    out = double(zeros(m,n));
    filt1 = zeros(k) + 1/(k^2);
    filt2 = zeros(k,1) + 1/(k^2);
    if mod(k,2) == 1
        p = (k-1)/2;
    else
        p = k/2;
    end
    input = double(padarray(I,[p,p]));
    [m,n] = size(I);
    for i = 1:m
        for j = 1:n
            s = i;
            e = i + k - 1;
            if j == 1
                temp = input(s:e,j:k);
                out(i,j) = sum(temp.*filt1,'all');
            else
                left = sum(input(s:e,j-1).*filt2);
                right = sum(input(s:e,j+k-1).*filt2);
                out(i,j) = out(i,j-1) + right - left; 
            end
        end
    end
end