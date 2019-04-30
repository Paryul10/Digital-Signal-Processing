% %FFT%
f = imread('cameraman.tif');
f = double(f);
y = viv(f);
y = viv(y.').';
figure(1);
imagesc(log(abs((y))))
w = ifft2(y);
figure(2);
imshow(w,[]);
function res = viv(data)
N = size(data,2);
    if N <= 1
        res = data;
    else
        disp(N);
        even = data(:,1:2:end);
        odd = data(:,2:2:end);
        fft_even = viv(even);
        fft_odd = viv(odd);
        b = 0 : 1 : N/2 - 1;
        p = exp((-2*pi*1i*b)/N);
        [p,~] = meshgrid(p,size(data,1));
        W(1:size(data,1),1:N/2) = fft_even + p .* fft_odd;
        W(1:size(data,1),N/2+1:N) = fft_even - p .* fft_odd;
        res = W;
    end
end