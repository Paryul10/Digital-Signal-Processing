clear all;close all ;clc


%%% variable declartions

N = 8;
image1 = rgb2gray(double(imread('8_8_bunny.jpeg')));
image2 = double(imread('LAKE.TIF'));
image3 = imread('circuit.tif');
% image2 = rgb2gray((imread('8_8_bunny.jpeg')));
fig_count = 1;
qm = [141,144,141,133,104,51,38,51;144,146,133,134,79,44,48,51;152,140,129,125,42,45,49,54;149,140,142,86,40,51,43,58;142,140,141,50,45,48,48,62;138,138,110,43,54,46,52,70;136,138,70,44,51,48,50,70;149,107,39,45,47,50,54,63];
q_mtx =     [16 11 10 16 24 40 51 61; 
            12 12 14 19 26 58 60 55;
            14 13 16 24 40 57 69 56; 
            14 17 22 29 51 87 80 62;
            18 22 37 56 68 109 103 77;
            24 35 55 64 81 104 113 92;
            49 64 78 87 103 121 120 101;
            72 92 95 98 112 100 103 99];
c = 2;

%%%%%%%% 1.1.a %%%%%%%%%x
my_dct_mtx = create_mat_dct(N);
F = my_dct_mtx;
inb_dct_mtx = dctmtx(N);
G = inb_dct_mtx;
%%%%%%%% 1.1.a %%%%%%%%% 

%%%%%%%% 1.1.b %%%%%%%%% 
my_dct_image = myDCT(abs(image1),my_dct_mtx);
inbu_dct_img = dct2(image1);
figure(fig_count); imshow(my_dct_image); title('My dct_image'); fig_count = fig_count + 1;
figure(fig_count); imshow(dct2(image1)); title('Inb dct_image'); fig_count = fig_count + 1;
%%%%%%%% 1.1.b %%%%%%%%%

%%%%%%%% 1.1.c %%%%%%%%% 
my_idct_image = myIDCT(my_dct_image,my_dct_mtx);
figure(fig_count); imshow(my_idct_image); title('My idct_image'); fig_count = fig_count + 1;
figure(fig_count); imshow(idct2(my_dct_image)); title('Inb idct_image'); fig_count = fig_count + 1;
%%%%%%%% 1.1.c %%%%%%%%%

%%%%%%%% 1.1.d %%%%%%%%% 
disp(myDCT_quantization(my_dct_mtx, qm, c));
%%%%%%%% 1.1.d %%%%%%%%% 

%%%%%%%% 1.1.e %%%%%%%%% 
disp(myDCT_dequantization(my_dct_mtx, qm, c));
%%%%%%%% 1.1.e %%%%%%%%% 

%%%%%%%% 1.1.f %%%%%%%%%
rmse_error = RMSE(image2,qm);
disp('RMSE_Error');
disp(rmse_error);
%%%%%%%% 1.1.f %%%%%%%%% 

%%%%%%%% 1.1.g %%%%%%%%% ]
disp('Value from Inbulit Entropy Function')
disp(entropy((image3)));
disp('Value from My_entropy')
disp(My_entropy(image3));
%%%%%%%% 1.1.g %%%%%%%%% 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1.2  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tfc1x = 420; tfc1y = 45;
tfc2x = 427; tfc2y = 298;
tfc3x = 30; tfc3y = 230;

new1 = double(image2(tfc1x:tfc1x + 7 , tfc1y:tfc1y+7));
% new1 = new1.*255;
new2 = double(image2(tfc2x:tfc2x + 7 , tfc2y:tfc2y+7));
% new2 = new2.*255;
new3 = double(image2(tfc3x:tfc3x + 7 , tfc3y:tfc3y+7));
% new3 = new3.*255;

figure(fig_count); imshow(uint8(new1)); title('New1'); fig_count = fig_count + 1; pause(1);
figure(fig_count); imshow(uint8(new2)); title('New2'); fig_count = fig_count + 1; pause(1);
figure(fig_count); imshow(uint8(new3)); title('New3'); fig_count = fig_count + 1; pause(1);

dct_new1 = myDCT((new1),my_dct_mtx);
% inbu = dct2(new1);
dct_new2 = myDCT((new2),my_dct_mtx);
dct_new3 = myDCT((new3),my_dct_mtx);

figure(fig_count); imshow(myDCT((new1),my_dct_mtx)); title('New1_dct'); fig_count = fig_count + 1; pause(1);
figure(fig_count); imshow(myDCT((new2),my_dct_mtx)); title('New2_dct'); fig_count = fig_count + 1; pause(1);
figure(fig_count); imshow(myDCT((new3),my_dct_mtx)); title('New3_dct'); fig_count = fig_count + 1; pause(1);

% nq_mtx = q_mtx./255;
qdct_new1 = myDCT_quantization(dct_new1,q_mtx,2);
qdct_new2 = myDCT_quantization(dct_new2,q_mtx,2);
qdct_new3 = myDCT_quantization(dct_new3,q_mtx,2);

figure(fig_count); imshow(myDCT_quantization(dct_new1,q_mtx,2)); title('New1_qdct'); fig_count = fig_count + 1; pause(1);
figure(fig_count); imshow(myDCT_quantization(dct_new2,q_mtx,2)); title('New2_qdct'); fig_count = fig_count + 1; pause(1);
figure(fig_count); imshow(myDCT_quantization(dct_new3,q_mtx,2)); title('New3_qdct'); fig_count = fig_count + 1; pause(1);

dqdct_new1 = myDCT_dequantization(qdct_new1,q_mtx,2);
dqdct_new2 = myDCT_dequantization(qdct_new2,q_mtx,2);
dqdct_new3 = myDCT_dequantization(qdct_new3,q_mtx,2);
% 
figure(fig_count); imshow(dqdct_new1); title('New1_dqdct'); fig_count = fig_count + 1;
figure(fig_count); imshow(dqdct_new2); title('New2_dqdct'); fig_count = fig_count + 1;
figure(fig_count); imshow(dqdct_new3); title('New3_dqdct'); fig_count = fig_count + 1;
% 
idct_new1 = myIDCT(dqdct_new1,my_dct_mtx);
idct_new2 = myIDCT(dqdct_new2,my_dct_mtx);
idct_new3 = myIDCT(dqdct_new3,my_dct_mtx);
% 
figure(fig_count); imshow(idct_new1); title('New1_Reconstructed'); fig_count = fig_count + 1; pause(1);
figure(fig_count); imshow(idct_new2); title('New2_Reconstructed'); fig_count = fig_count + 1; pause(1);
figure(fig_count); imshow(idct_new3); title('New3_Reconstructed'); fig_count = fig_count + 1; pause(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1.2  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1.3  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(fig_count); imshow(uint8(image2)); title('Lake'); fig_count = fig_count + 1; pause(1);
image_chunks = @(block_struct) F * block_struct.data * F';
image2_new = image2 - 127;
B = blockproc(image2_new,[8 8],image_chunks);
% nq_mtx = q_mtx;
c1 = 2;
nq_mtx = q_mtx*c1;
B2 = blockproc(B,[8 8],@(block_struct) round((block_struct.data)./nq_mtx));
B3 = blockproc(B2,[8 8],@(block_struct) ((block_struct.data).*nq_mtx));
figure(fig_count); imshow(B3); title('Dct and Quantisation'); fig_count = fig_count + 1; pause(1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1.3  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1.4  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
invdct = @(block_struct) round(F' * double(block_struct.data) * F);
comp_img = blockproc(B3,[8 8],invdct);
comp_img = comp_img + 127;
figure(fig_count); imshow(uint8(comp_img)); title('IDCT'); fig_count = fig_count + 1; pause(1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1.4  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 
%%%%FUNCTIONS%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1.1.a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [my_dct_mtx] = create_mat_dct(N)
    
% N = 8;  %% 8 point

v = 0:N-1;
% Np = 2*N;
u = 1:2:2*N-1;

mm = v'*u;
% disp(mm)

val = pi/(2*N);
% disp(val);

mm = mm.* val;

% disp(mm);

mm = cos(mm);

% disp(mm);

norm_fac = sqrt(2/N);

mm = mm.* norm_fac;

div_fac = sqrt(1/2);

fm = mm;

% disp(mm);

mm = mm(1,:)*div_fac;

% disp(mm);

fm(1,:) = mm;

% disp(fm);
my_dct_mtx = fm;

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1.1.a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1.1.b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [my_dct_image] = myDCT(im,F)
im = im - 127;
my_dct_image = F * im * F';
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1.1.b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1.1.c %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [my_idct_image] = myIDCT(im,F)
my_idct_image = F' * im * F;
my_idct_image = my_idct_image + 127;
% my_imqDCT = my_imqDCT + 127;
my_idct_image = uint8(my_idct_image);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1.1.c %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%idct_new1%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1.1.d %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [my_imqDCT] =  myDCT_quantization(imDCT, qm, c)
nqm = qm*c;
% disp(nqm);
my_imqDCT = round(imDCT./nqm);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1.1.d %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1.1.e %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [my_dct_image] = myDCT_dequantization(imqDCT,qm,c)
nqm = qm*c;
my_dct_image = (imqDCT.*nqm);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1.1.e %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1.1.f %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [rmse_error] = RMSE(im1,im2)
% Image1 = rgb2gray(imread('pillsetc.png'));
% Image2 = (imread('rice.png'));
%%% ASSUMES IM2 IS SMALLER THAN IM1%%

height1 = size(im1,1); %// Change
width1 = size(im1,2); %// Change
height2 = size(im2,1); %// Change
width2 = size(im2,2); %// Change
im1_new  = im1;
im2_new  = im2;

% if height1
im2_new = imresize(im2_new,[height1 , width1]);

% if height1 > height2
%     im2_new = padarray(im2_new,[(height1-height2)/2 , 0]);
% else
%     im1_new = padarray(im1_new,[(height2-height1)/2 ,0]);
% end
% 
% % im3 = padarray(im2,[(height1-height2)/2, (width1-width2)/2]);
% disp(im1_new);
% disp(" --------------------------")
% disp(im2_new);

diff = im1_new - im2_new;
% disp(diff);
diff = diff.^2;
% disp(diff);
mean_diff = mean2(diff);
rmse_error = sqrt(mean_diff);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1.1.f %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1.1.g %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [entropy] = My_entropy(im)
% imhist.
[counts,binlocations] = imhist(im);
% disp(counts);
% disp(counts.*log2(counts));
counts(counts==0) = [];
counts = counts/sum(counts);
entropy = -sum(counts.*log2(counts));
% disp(entropy);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1.1.g %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
