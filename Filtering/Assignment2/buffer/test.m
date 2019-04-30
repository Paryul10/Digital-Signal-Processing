extracted_numbers = extract_numbers('tone.wav');

disp(extracted_numbers);

function [decoded] = extract_numbers(criminal_file)
    freqs_num = [];
    for i = 1:10
        file_name = sprintf('%d.ogg',i-1);
        [y,Fs] = audioread(file_name);

        Y = abs(fft(y));
        [a1,cf1] = max(Y);
        Y(cf1) = -1000;

        [temp,temp_freq] = max(Y);
        Y(temp_freq) = -1000;
        
        [a2,cf2] = max(Y);
        
        freqs_num(i, :) = [cf1 cf2];
       
    end

    num_of_windows = 8;
    [x,Fs] = audioread(criminal_file);
    window_len = size(x,1) / num_of_windows;
    freqs_signal = [];

    for i=1:num_of_windows

        begin_win = (i-1)*window_len+1;
        end_win = i*window_len;

        small_window = x(begin_win: end_win);

        X = abs(fft(small_window));

        [a1,cf1] = max(X);
        X(cf1) = -1000;

        [temp,temp_freq] = max(X);
        X(temp_freq) = -1000;
        
        [a2,cf2] = max(X);
        
        freqs_signal(i, :) = [cf1 cf2];
    end

    %normalise freq;
    freqs_signal = floor(Fs * (freqs_signal)/window_len(1));

    for i=1:10
        n = find(sum(abs((freqs_signal - freqs_num(i,:)).'))<=3);
        decoded(n) = i-1;
    end


end
