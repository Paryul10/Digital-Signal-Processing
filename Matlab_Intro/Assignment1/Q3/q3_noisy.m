f2_old = rgb2gray(imread('F2.jpg'));
f2 = imgaussfilt(f2_old,2);
faces = rgb2gray(imread('Faces.jpg'))
imshowpair(f2,faces,'montage');
c = normxcorr2(f2,faces);
figure,surf(c),shading flat;
[ypeak, xpeak] = find(c==max(c(:)));
yoffSet = ypeak-size(f2,1);
xoffSet = xpeak-size(f2,2);
figure , imshow(faces),imrect(gca, [xoffSet+1, yoffSet+1, size(f2,2), size(f2,1)]);