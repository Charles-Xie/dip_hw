img = imread('Q_1_1.tif');
eqImg = histeq(img);
figure, imshow(eqImg)

img2 = imread('Q_1_2.tif');
eqImg2 = histeq(img);
figure, imshow(eqImg)