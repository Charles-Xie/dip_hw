function my_gaussian(imageName)

im = imread(imageName);
im = rgb2gray(im);
[ori_row,ori_col] = size(im);

sigma = 4;   
N = 2;           
row_num = 4;

H = [];                                 
for i = 1:row_num
    for j = 1:row_num
        tmp = double((i-N-1)^2+(j-N-1)^2);
        H(i,j) = exp(-tmp/(2*sigma*sigma))/(2*pi*sigma);
    end
end
H = H/sum(H(:));              % make sum = 1

result = zeros(ori_row,ori_col);          
tmp_img2 = zeros(ori_row+2*N,ori_col+2*N);

for i = 1:ori_row                           % padding with zero
    for j = 1:ori_col
        tmp_img2(i+N,j+N) = im(i,j);
    end
end
tmp_img = [];
for ai = N+1:ori_row+N
    for aj = N+1:ori_col+N
        tmp_img_row = ai-N;
        tmp_img_col = aj-N;
        tmp_img = 0;
        for bi = 1:row_num
            for bj = 1:row_num
                tmp_img = tmp_img+(tmp_img2(tmp_img_row+bi-1,tmp_img_col+bj-1)*H(bi,bj));
            end
        end
        result(tmp_img_row,tmp_img_col) = tmp_img;
    end
end

% to show it normaly
result = uint8(result);

figure
subplot(1,2,1);
imshow(im);
title('origin');

subplot(1,2,2);
imshow(result);
title('result');