I = [1,5,9;
2,6,10;
3 ,7, 11;
4, 8, 12]

I = bsxfun(@minus, double(I) , mean(I));