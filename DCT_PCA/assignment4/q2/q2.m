clear all;close all ;clc;
%%%%%%%%%%%%%%%%%%%%%% READING THE DATASET FROM THE DIRECTORY %%%%%%%%%%%%%%%%
load data_allEx.mat;
% dirData = dir('dataset/*.jpg'); 
% % disp(dirData);
% fileNames = {dirData.name};
% data_all = [];
% for k = 1:length(dirData) 
%      filename = dirData(k).name;
%      data1 = imread(filename);
% %      data_all{k} = data1(:);
%     mdata1 = (data1(:));
%     data_all  = horzcat(data_all , mdata1);
% end
% save data_allEx data_all
%%%%%%%%%%%%%%%%%%%%% READING THE DATASET FROM THE DIRECTORY %%%%%%%%%%%%%%%%%


% data = cov(data_all);
A = bsxfun(@minus,double(data_all),(mean(data_all)));


%%% eign of A * A' = co-variance matrix
[V,D] = eig(A' * A);

[d ,ind] = sort(diag(D) , 'descend');
Ds = D(ind,ind);
Vs = V(:,ind);

eign_cov = A * Vs;

pc = eign_cov(: ,1:35);
compressed = A' * pc;

% A = bsxfun(@minus,double(data_all),(mean(data_all)));
% imshow(reconstructed);











    

