function histEq_2(imageName)

I = imread(imageName);     % 'Q_1_1.tif' & 'Q_1_2.tif'
[height,width] = size(I);  
NumPixel = zeros(1,256);
for i = 1:height  
    for j = 1: width  
        NumPixel(I(i,j) + 1) = NumPixel(I(i,j) + 1) + 1;
    end  
end
% NumPixel represents the histogram of origin image
ProbPixel = zeros(1,256);  
for i = 1:256  
    ProbPixel(i) = NumPixel(i) / (height * width * 1.0);  
end 
% ProbPixel represents the normalized histogram
CumuPixel=zeros(1,256);   
S1=zeros(1,256);  
S2=zeros(1,256);  
tmp=0;  
for i=1:256  
    tmp=tmp+ProbPixel(i);  
    S1(i)=tmp;  
    S2(i)=round(S1(i)*256);  
end

for i=1:256  
    CumuPixel(i)=sum(ProbPixel(find(S2==i)));  
end
% CumuPixel represents the histogram after histogram equalization

newGrayPic=I;
for i=1:256  
    newGrayPic(find(I==(i-1)))=S2(i);  
end
% get new image after histogram equalization

% show result image
figure, imshow(newGrayPic)