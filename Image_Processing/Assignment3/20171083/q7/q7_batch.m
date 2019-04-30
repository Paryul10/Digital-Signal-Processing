clear all;close all; clc;
data = csvread('Altitude.csv');
operating_data = [ones(1000,1) , data(:,1:3)];
training_set = operating_data(1:900,1:3);
testing_set = operating_data(901:1000,1:3);
alpha = 0.0002;
iterations = 1000000;
theta = [0,0,0]';
x_vals = training_set;
y_vals = operating_data(1:900,4:4);

testing_x = operating_data(901:1000,1:3);
actual_y = operating_data(901:1000,4:4);
size_ts = size(x_vals,2);
len = length(y_vals);


for i=1:iterations
    h_val = x_vals * theta ;
    y_fin = y_vals * ones(1,size_ts);
    coeff = alpha * (1/len);
    h_fin = h_val * ones(1,size_ts);
    % derivative = ((h_fin-y_fin).*x_vals).';
    % summation = sum(derivative);
    theta = theta - coeff * sum((h_fin - y_fin).*x_vals).';
end

disp(theta);

predicted_y = testing_x*theta;
error = abs((norm(actual_y)-norm(predicted_y))/norm(actual_y)) * 100;
disp(error);
    

