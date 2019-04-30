clear all ; close all ; clc;

A = im2double(imread('rice.png'));
imshow(A);

disp(size(A,1));

D = dctmtx(size(A,1));

dct = D*A*D';
imshow(dct)