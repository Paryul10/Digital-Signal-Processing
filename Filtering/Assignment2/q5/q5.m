% image1 = imread('3.jpg');
fig_count = 1;


image1 = imread('cameraman.tif');
image2 = imread('earth.jpg');
image3 = imread('3.jpg');

% Your jpg image is read as integer ( uint8 most likely) and matlab 
% is not that good at manipulating pure integers as per the error message.
% The simplest way to solve this is to convert the integers to doubles:


image1 = imread('cameraman.tif');
% figure(fig_count); imshow(image1); title('org'); fig_count = fig_count + 1;
image1_dub = (double(image1));

tic
my_2d_dft_image = my_2d_dft(image1_dub);
figure(fig_count); imagesc(log(abs((my_2d_dft_image)))); title('My DFT IMAGE'); fig_count = fig_count + 1;
toc

tic
inbu_dft_image = fft2(image1_dub); 
figure(fig_count); imagesc(log(abs((inbu_dft_image)))); title('Inbuilt FFt image'); fig_count = fig_count + 1;
toc

tic
my_fft_image = myfft(image1_dub); 
my_fft_new = myfft(my_fft_image.').';
figure(fig_count); imagesc(log(abs((my_fft_new)))); title('My FFt image'); fig_count = fig_count + 1;
toc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% figure(fig_count); imshow(image2); title('org'); fig_count = fig_count + 1;
image2 = rgb2gray(image2);
image2_dub = (double(image2));

tic
my_2d_dft_image_2 = my_2d_dft(image2_dub);
figure(fig_count); imagesc(log(abs((my_2d_dft_image_2)))); title('My DFT IMAGE 2'); fig_count = fig_count + 1;
toc

tic
inbu_dft_image_2 = fft2(image2_dub); 
figure(fig_count); imagesc(log(abs((inbu_dft_image_2)))); title('Inbuilt FFt image 2'); fig_count = fig_count + 1;
toc

tic
my_fft_image_2 = myfft(image2_dub);
my_fft_new_2 = myfft(my_fft_image_2.').'; 
figure(fig_count); imagesc(log(abs((my_fft_new_2)))); title('My FFt image 2'); fig_count = fig_count + 1;
toc
 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% figure(fig_count); imshow(image3); title('org'); fig_count = fig_count + 1;
image3 = rgb2gray(image3);
image3_dub = (double(image3));

tic
my_2d_dft_image_3 = my_2d_dft(image3_dub);
figure(fig_count); imagesc(log(abs((my_2d_dft_image_3)))); title('My DFT IMAGE 3'); fig_count = fig_count + 1;
toc

tic
inbu_dft_image_3 = fft2(image3_dub); 
figure(fig_count); imagesc(log(abs((inbu_dft_image_3)))); title('Inbuilt FFt image 3'); fig_count = fig_count + 1;
toc

tic
my_fft_image_3 = myfft(image3_dub);
my_fft_new_3 = myfft(my_fft_image_3.').'; 
figure(fig_count); imagesc(log(abs((my_fft_new_3)))); title('My FFt image 3'); fig_count = fig_count + 1;
toc


% t = timer('TimerFcn', 'stat=false; disp(''Timer!'')',...
%                  'StartDelay',20);
% start(t)

% stat=true;
% while(stat==true)
% %   disp('.')
%   pause(1)
% end
% clear all; close all; clc



function [f] = my_2d_dft(image)

    [N , M , ~] = size(image);
    exp1 = exp(-1i * 2 * pi/N);
    exp2 = exp(-1i * 2 * pi/M);
    
    n1 = 0:N-1;
    n2 = 0:N-1;

    wn = n1'*n2;
    
    m1 = 0:M-1;
    m2 = 0:M-1;

    wm = m1'*m2;

    W_N = exp1.^wn;
    W_M = exp2.^wm;

    % W_N = dftmtx(N);
    % W_M = dftmtx(M);

    % semi_image = W_N * image;
    f = W_N * image * W_M;

    % figure(2); imshow(final_image);

end


function [y] = myfft(a)   
    if size(a,2) == 1 
        y = a;
    else 
        n = size(a,2);
        % disp(n);
        odd = myfft(a(:,1:2:n));
        even = myfft(a(:,2:2:n));
        k = 0:1:n/2-1;
        mat = exp(-2*pi*1i/n).^k;
        z = mat.*even;
        y = [odd+z,odd-z];
        
    end
    end

