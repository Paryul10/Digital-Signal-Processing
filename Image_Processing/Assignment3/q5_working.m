clear all;close all; clc;
fig_count = 1;
front_array = cell(1,5);
rear_array = cell(1,5);
[one , Fs_one] = audioread('1.wav');
[two , Fs_two] = audioread('2.wav');
[thr , Fs_thr] = audioread('3.wav');
[fou , Fs_fou] = audioread('4.wav');
[fiv , Fs_fiv] = audioread('5.wav');
order_of_packets = zeros(1,5);
max_array = zeros(1,5);
time_interval = 5;  %% how many seconds overlap.


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

% sound(filtered_one,Fs_one);
% fr_one = filtered_one(1:time_interval*Fs_one,1);
% front_array = [front_array , fr_one];
% fr_two = filtered_two(1:time_interval*Fs_two,1);
% front_array = [front_array , fr_two];
% fr_thr = filtered_thr(1:time_interval*Fs_thr,1);
% front_array = [front_array , fr_thr];
% fr_fou = filtered_fou(1:time_interval*Fs_fou,1);
% front_array = [front_array , fr_fou];
% fr_fiv = filtered_fiv(1:time_interval*Fs_fiv,1);
% front_array = [front_array , fr_fiv];


% bk_one = filtered_one(size(filtered_one,1)-time_interval*Fs_one:size(filtered_one,1),1);
% rear_array = [rear_array , bk_one];
% bk_two = filtered_two(size(filtered_two,1)-time_interval*Fs_two:size(filtered_two,1),1);
% rear_array = [rear_array , bk_two];
% bk_thr = filtered_thr(size(filtered_thr,1)-time_interval*Fs_thr:size(filtered_thr,1),1);
% rear_array = [rear_array , bk_thr];
% bk_fou = filtered_fou(size(filtered_fou,1)-time_interval*Fs_fou:size(filtered_fou,1),1);
% rear_array = [rear_array , bk_fou];
% bk_fiv = filtered_fiv(size(filtered_fiv,1)-time_interval*Fs_fiv:size(filtered_fiv,1),1);
% rear_array = [rear_array , bk_fiv];


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

rear_array{1} = temp1(size(temp1,1)-time_interval*Fs_one:size(temp1,1),1);
rear_array{2} = temp2(size(temp2,1)-time_interval*Fs_two:size(temp2,1),1);
rear_array{3} = temp3(size(temp3,1)-time_interval*Fs_thr:size(temp3,1),1);
rear_array{4} = temp4(size(temp4,1)-time_interval*Fs_fou:size(temp4,1),1);
rear_array{5} = temp5(size(temp5,1)-time_interval*Fs_fiv:size(temp5,1),1);

for i=1:5
    max_val = 0;
    for j=1:5
        if i ~=j
            if max(xcorr(front_array{i},rear_array{j})) > max_val
                max_val = max(xcorr(front_array{i},rear_array{j}));
            end
        end
    end
    max_array(i) = max_val;
    [x,y]=min(max_array);
    order_of_packets(1)=y;
end

for i=2:5
    next_ind = reorderDatagram(front_array,order_of_packets(i-1),rear_array);
    order_of_packets(i) = next_ind(1);
end

final_sound = vertcat(temp3,temp5,temp1,temp2,temp4);
disp(order_of_packets);
sound(final_sound,Fs_fiv);

function next_ind = reorderDatagram(front_array,index,rear_array)
    next_ind = 0; max_val = 0;
    for i=1:5
        if i ~= index
            if max(xcorr(rear_array{index},front_array{i})) > max_val
                max_val = max(xcorr(rear_array{index},front_array{i}));
                next_ind = i;
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

