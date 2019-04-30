clear all;close all; clc;

normalizing = 0;
data = csvread('houses.csv');



operating_data = [ ones(47 , 1) , data(:,1:2)];

% if normalizing == 1:

training_set = operating_data(1:42,:);
testing_set = operating_data(43:47,:);
actual_ans = data(43:47,3:3);

     
X = training_set;
Y = data(1:42,3:3);
b = inv(X'*X)*X'*Y;  %this will give the co-efficents.

%%PART A
disp('Constant value:');
disp(b(1));

disp('Coefficent of size of house:');
disp(b(2));

disp('Coefficent of number of rooms:');
disp(b(1));

inp = [1,1400,4];
out = inp*b;
disp('Predicted value of price:');
disp(out);

%%PART B
%Error without norm
predicted_ans = norm(testing_set*b);
actual_ans = norm(actual_ans);
err_wo_n = (abs(actual_ans-predicted_ans)/actual_ans) * 100;
disp('Error without normalising data:');  disp(err_wo_n);


sum_feature_1 = mean(operating_data(:,2));
sum_feature_2 = mean(operating_data(:,3));
stand_dev_1 = std(operating_data(:,2));
stand_dev_2 = std(operating_data(:,3));
training_set_norm_1 = (operating_data(:,2) - sum_feature_1)/stand_dev_1;
training_set_norm_2 = (operating_data(:,3) - sum_feature_2)/stand_dev_2;
X_norm = [ones(47,1),training_set_norm_1,training_set_norm_2];
X_new = X_norm(1:42,:);
b_norm = inv(X_new'*X_new)*X_new'*Y;

predicted_ans_norm = norm(X_norm(43:47,:)*b_norm);
actual_ans_norm = norm(actual_ans);
err_w_n = (abs(actual_ans_norm-predicted_ans_norm)/actual_ans_norm) * 100;
disp('Error with normalising data:');  disp(err_w_n);



%%PART C
mean_feature1 = mean(training_set(:,2));
mean_feature2 = mean(training_set(:,3));
mean_ans = mean(data(1:42,3));

mean_computed = [1,mean_feature1,mean_feature2]*b;

disp('Computed mean:');disp(mean_computed);
disp('Mean:');disp(mean_ans);






