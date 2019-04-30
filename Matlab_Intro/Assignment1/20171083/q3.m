f1 = rgb2gray(imread('F1.jpg'));
faces = rgb2gray(imread('Faces.jpg'))
imshowpair(f1,faces,'montage');
c = normxcorr2(f1,faces);
figure,surf(c),shading flat;
[ypeak, xpeak] = find(c==max(c(:)));
yoffSet = ypeak-size(f1,1);
xoffSet = xpeak-size(f1,2);
figure , imshow(faces),imrect(gca, [xoffSet+1, yoffSet+1, size(f1,2), size(f1,1)]);