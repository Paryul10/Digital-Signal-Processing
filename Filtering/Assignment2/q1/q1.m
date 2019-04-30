image1 = imread('cameraman.tif');
image2= imread('inp1.png');
fig_count = 1;

% PART 1
% 
% 
% N = 1000;
% sigma = 5;
% G_filter = my_gaussian_filter(N,sigma);
% figure(fig_count);imshow(image1);title('original');fig_count = fig_count + 1;
% my_g_image = imfilter(image1,G_filter);
% figure(fig_count);imshow(my_g_image);title('My gaussian filter');fig_count = fig_count + 1;
% 
% fpecial_gaussian_filter = fspecial('gaussian',N,sigma);
% fspecial_image = imfilter(image1,fpecial_gaussian_filter);
% figure(fig_count);imshow(my_g_image);title('Fspecial gaussian filter');fig_count = fig_count + 1;
% 
% PART 2
% 
% N2 = 2;
% my_f_image = my_median_filter(image2,N2);
% figure(fig_count);imshow(my_f_image);title('My median filter');fig_count = fig_count + 1;
% 
% 
% PART 4
% 
% G_filter = my_gaussian_filter(N,sigma);
% my_g_image = imfilter(image2,G_filter);
% figure(fig_count);imshow(my_g_image);title('My gaussian filter');fig_count = fig_count + 1;
% 
% fpecial_average_filter = fspecial('average',5);
% fspecial_average_image = imfilter(image2,fpecial_average_filter);
% figure(fig_count);imshow(fspecial_average_image);title('Fspecial averagefilter'); fig_count = fig_count + 1;
% 
% median_filtered_image = medfilt2(image2);
% figure(fig_count);imshow(median_filtered_image);title('Median filtered'); fig_count = fig_count + 1;

%PART 5

image3 = imread('inp2.png');
fft_image = fft2(image3);
figure(fig_count);imshow(image3);   title('Original'); fig_count = fig_count + 1;
fft_shift_image = fftshift(fft_image);
figure(fig_count);imagesc(log(abs(fft_shift_image)));title('Fft'); fig_count = fig_count + 1;

fft_shift_image(1:30,115:125) = 0;
fft_shift_image(25:60,110:130) = 0;
fft_shift_image(76:90,110:130) = 0;

fft_shift_image(90:110,105:132) = 0;
fft_shift_image(203:228,105:135) = 0;
fft_shift_image(228:242,110:130) = 0;

fft_shift_image(268:284,110:130) = 0;
fft_shift_image(284:319,116:123) = 0;

% fft_shift_image(86:116,100:130) = 0;
% fft_shift_image(206:236,100:130) = 0;
% fft_shift_image(264:294,100:130) = 0;
% fft_shift_image(288:318,100:130) = 0;
% fft_shift_image(2:32,100:130) = 0;
% fft_shift_image(27:57,100:130) = 0;

figure(fig_count);imagesc(log(abs(fft_shift_image)));title('Fft with reduced noise'); fig_count = fig_count + 1;

unshift_image = ifftshift(fft_shift_image);
final_image = uint8(abs(ifft2(unshift_image)));
figure(fig_count);imshow(final_image);title('Image with reduced noise'); fig_count = fig_count + 1;




% t = timer('TimerFcn', 'stat=false; disp(''Timer!'')',...
%                  'StartDelay',100);
% start(t)
% 
% stat=true;
% while(stat==true)
% %   disp('.')
%   pause(1)
% end
% clear all; close all; clc



function f =  my_gaussian_filter(N,sigma)

    index = floor(-N/2):floor(N/2);
    [X,Y] = meshgrid(index,index);
    df = 2*sigma*2;
    %evaluates value for each cell
    f = exp(-(X.^2+Y.^2)/df );
    f = f / sum(f(:));
end

function m = my_median_filter(I,N)
    
    %to calculate the median at border points we need to have points.So we pad   
    pad_size = floor(N/2);
    padded_image = padarray(I, [pad_size pad_size]);
%     size_im = size(padded_image)
    %columise the image . each column represents the pixel values of the
    %neighbourhood. Without this i would have to run 4 for loops.
    columnised_matrix = im2col(padded_image, [N N], 'sliding');
    %compute the values (median) to replace .
    median_values = median(columnised_matrix);
    %replace.
    m = col2im(median_values, [N N], size(padded_image), 'sliding');
end



