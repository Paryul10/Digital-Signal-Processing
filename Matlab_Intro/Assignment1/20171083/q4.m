original = imread('2.jpg');

% bl(original,2);
nni(original,5);
% for h = 1:3
%     s(:,:,h) = bl(original(:,:,h), 2);
% end
figure(1);imagesc(original);colormap default;  %IF GREY THEN CHAMGE DEFAULT TO GREY

function [enlarged] = nni(original,sf)
% original = imread('1.png');
[r,c] = size(original);
% sf = 0.5;        

enlarged = zeros(sf*r,sf*c, class(original));  % class initialises the array with logical values, as of the original image

for i=1:sf*r
    for j=1:sf*c
        oj = round( (j-1)*(c-1)/(sf*c-1)+1 );
        oi = round( (i-1)*(r-1)/(sf*r-1)+1 );
        enlarged(i,j) = original(oi,oj);
    end
end

figure, imshow(enlarged) ; title(['Nni:SF: ' num2str(sf)]);
% figure, imshow(original) ; title(['Original']);
end


function [enlarged] = nni(original,sf)
scale = [sf sf];              %# The resolution scale factors: [rows columns]
originalsize = size(original);             
enlargedsize = max(floor(scale.*originalsize(1:2)),1);  %# Compute the new image size

rowIndex = min(round(((1:enlargedsize(1))-0.5)./scale(1)+0.5),originalsize(1));
colIndex = min(round(((1:enlargedsize(2))-0.5)./scale(2)+0.5),originalsize(2));

%# Index old image to get new image:

enlarged = original(rowIndex,colIndex,:);
% figure(2), imshow(enlarged) ; title(['Nni:SF: ' num2str(sf)]);
figure(2), imagesc(enlarged);colormap default ; title(['NNI:SF: ' num2str(sf)]);

end



function [enlarged] = bl(original,sf)
    [r, c,~] = size(original);

    er = r * sf;
    ec = c * sf;

    [cf, rf] = meshgrid(1 : ec, 1 : er);
    cf = cf / sf;
    rf = rf / sf;

    c_get = floor(cf);
    r_get = floor(rf);

    r_get(r_get < 1) = 1;
    c_get(c_get < 1) = 1;
    r_get(r_get > r - 1) = r - 1;
    c_get(c_get > c - 1) = c - 1;

    delta_R =  rf - r_get;
    delta_C =  cf - c_get;

    in1_ind = sub2ind([r, c], r_get, c_get);
    in4_ind = sub2ind([r, c], r_get+1, c_get+1);       
    in2_ind = sub2ind([r, c], r_get+1,c_get);
    in3_ind = sub2ind([r, c], r_get, c_get+1);
 
    enlarged = zeros(er, ec, size(original, 3));
    
    enlarged = cast(enlarged, 'like', original);
    for idx = 1 : size(original, 3)
        chan = double(original(:,:,idx)); 
        tmp = chan(in1_ind).*(1 - delta_R).*(1 - delta_C) + ...
                       chan(in2_ind).*(delta_R).*(1 - delta_C) + ...
                       chan(in3_ind).*(1 - delta_R).*(delta_C) + ...
                       chan(in4_ind).*(delta_R).*(delta_C);
        enlarged(:,:,idx) = cast(tmp,'like',original);
    end

    figure(2), imagesc(enlarged);colormap default ; title(['BI:SF: ' num2str(sf)]);

end

