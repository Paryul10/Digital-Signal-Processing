clear all;close all; clc;
fig_count = 1;
[one , Fs_one] = audioread('1.wav');
front_array = cell(1,5);
[two , Fs_two] = audioread('2.wav');
rear_array = cell(1,5);
[thr , Fs_thr] = audioread('3.wav');
debug_flag = 0;
[fou , Fs_fou] = audioread('4.wav');
order_of_packets = zeros(1,5);
[fiv , Fs_fiv] = audioread('5.wav');
max_array = zeros(1,5);
time_interval = 5;  %% how many seconds overlap.
flag = 0;

fft_one = fft(one);
% figure(fig_count);stem(abs(fft_one));title('One');fig_count = fig_count + 1;


filtered_one = abs(smoothdata(one,'gaussian'));
% figure(fig_count);stem(abs(fft(filtered_one)));title('Filtered One');fig_count = fig_count + 1;
filtered_two = abs(smoothdata(two,'gaussian'));
% figure(fig_count);stem(abs(fft(filtered_two)));title('Filtered Two');fig_count = fig_count + 1;
filtered_thr = abs(smoothdata(thr,'gaussian'));
% figure(fig_count);stem(abs(fft(filtered_thr)));title('Filtered Thr');fig_count = fig_count + 1;
filtered_fou = abs(smoothdata(fou,'gaussian'));
% figure(fig_count);stem(abs(fft(filtered_fou)));title('Filtered Fou');fig_count = fig_count + 1;
filtered_fiv = abs(smoothdata(fiv,'gaussian'));
% figure(fig_count);stem(abs(fft(filtered_fiv)));title('Filtered Fiv');fig_count = fig_count + 1;

temp1=find_fft(one);
temp2=find_fft(two);
temp3=find_fft(thr);
temp4=find_fft(fou);
temp5=find_fft(fiv);

front_array{1} = temp1(1:time_interval*Fs_one,1);
front_array{2} = temp2(1:time_interval*Fs_two,1);
front_array{3} = temp3(1:time_interval*Fs_thr,1);
front_array{4} = temp4(1:time_interval*Fs_fou,1);
front_array{5} = temp5(1:time_interval*Fs_fiv,1);

disp(front_array);

rear_array{1} = temp1(size(temp1,1)-time_interval*Fs_one:size(temp1,1),1);
rear_array{2} = temp2(size(temp2,1)-time_interval*Fs_two:size(temp2,1),1);
rear_array{3} = temp3(size(temp3,1)-time_interval*Fs_thr:size(temp3,1),1);
rear_array{4} = temp4(size(temp4,1)-time_interval*Fs_fou:size(temp4,1),1);
rear_array{5} = temp5(size(temp5,1)-time_interval*Fs_fiv:size(temp5,1),1);

disp(rear_array);

for i=1:5
    curr_ind = i;
    max_val = 0;
    min_val = 0;
    for j=1:5
        if i ~=j
            if max(xcorr(front_array{i},rear_array{j})) > max_val
                max_val = max(xcorr(front_array{i},rear_array{j}));
            end
        end
    end
    max_array(i) = max_val;
    curr_ind = j;
    [x,y] = min(max_array);
    order_of_packets(1) = y;
    min_val = max_array(curr_ind);
end

for i=2:5
    curr_ind = i;
    next_ind = reorderDatagram(front_array,order_of_packets(i-1),rear_array);
    order_of_packets(curr_ind) = next_ind(1);
end

final_sound = vertcat(temp3,temp5,temp1,temp2,temp4);
disp(order_of_packets);
% sound(final_sound,Fs_fiv);

function next_ind = reorderDatagram(front_array,index,rear_array)
    min_val = -999;
    next_ind = 0; max_val = 0;
    for i=1:5
        if min_val < max_val
            if i ~= index
                if max(xcorr(rear_array{index},front_array{i})) > max_val
                    max_val = max(xcorr(rear_array{index},front_array{i}));
                    next_ind = i;
                end
            end
        end
    end
end

function res = find_fft(y)
    y2 = fftshift(fft(y(:,1)));
    y2 = smoothdata(y2,'gaussian');
    ifft_shifted_sound = ifftshift(y2);
    ifft_sound = ifft(ifft_shifted_sound);
    res = abs(ifft_sound);
end

