function intensity_transform(imageName, i_min_max)
im = imread(imageName);
if numel(size(im)) == 3
    im = rgb2gray(im);
end

% use histogram equalization first
im = histeq(im);

i_min = i_min_max(1);
i_max = i_min_max(2);
% change type to double
im = im2double(im);
im = im * (i_max - i_min);
im = im + i_min;

% change back type to unit8
im = uint8(im);
figure
imshow(im);