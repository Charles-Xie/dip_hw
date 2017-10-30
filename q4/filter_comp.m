function filter_comp(imageName)
    im = imread(imageName);
    
    % 1: original
    figure
    subplot(331)
    imshow(im)
    title('original')
    
    % 2: average, size = [3, 3]
    h2 = fspecial('average', [3, 3]);
    im2 = imfilter(im, h2);
    subplot(332)
    imshow(im2)
    title('average, size=3')
    
    % 3: average, size = [5, 5]
    h3 = fspecial('average', [5, 5]);
    im3 = imfilter(im, h3);
    subplot(333)
    imshow(im3)
    title('average, size=5')
    
    % 4: gaussian, size = [3, 3], sigma = 0.5
    h4 = fspecial('gaussian', [3, 3]);
    im4 = imfilter(im, h4);
    subplot(334)
    imshow(im4)
    title('gaussian, size=3, sigma=0.5')
    
    % 5: gaussian, size = [3, 3], sigma = 1
    h5 = fspecial('gaussian', [3, 3], 1);
    im5 = imfilter(im, h5);
    subplot(335)
    imshow(im5)
    title('gaussian, size=3, sigma=1')
    
    
    % 6: gaussian, size = [5, 5], sigma = 0.5
    h6 = fspecial('gaussian', [5, 5]);
    im6 = imfilter(im, h6);
    subplot(336)
    imshow(im6)
    title('gaussian, size=5, sigma=0.5')
    
    
    % 7: median filter, size=[3, 3]
    im7 = medfilt2(im);
    subplot(337)
    imshow(im7)
    title('median filter, size=3')
    
    % 7: median filter, size=[5, 5]
    im8 = medfilt2(im, [5, 5]);
    subplot(338)
    imshow(im8)
    title('median filter, size=5')
    
    % adaptive median filter
    im9 = ada_med_filter(imageName);
    subplot(339)
    imshow(im9)
    title('adaptive median filter')
    

function im_res = ada_med_filter(img_name)
% Adaptive Median Filter
% @param img_name: the name of the image file
% apply adaptive median filter to an image and show filtered image
% together with the original image

im = imread(img_name);

S_MIN = 3;      % the min size of the filter
S_MAX = 11;     %  the max size of the filter
z_min = 0;      % the min grey level in region
z_max = 255;    % the max grey level in region
z_med = 0;      % the median grey level in region
z_xy = 0;       % the grey level at the center pixel
IMG_SIZE = size(im);
HEIGHT = IMG_SIZE(1);
WIDTH = IMG_SIZE(2);
im_res = zeros(HEIGHT, WIDTH);
pad_size = (S_MAX - 1) / 2;
% padding the image with zero, size = 5
im_pad = padarray(im, [pad_size, pad_size]);

% apply filter to a specific pixel
for r = (1 + pad_size): (HEIGHT + pad_size)
    for c = (1 + pad_size): (WIDTH + pad_size)
        z_xy = im_pad(r, c);
        % get z_xy
        for s_filt = S_MIN: 2: S_MAX
            % apply filter to this pixel
            % reshape this region
            half_filt = (s_filt - 1)/2;
            unsorted = reshape(im_pad(r - half_filt: r + half_filt, c - half_filt: c + half_filt), 1, []);
            % sort
            sorted = sort(unsorted);
            % get z_med, z_min, z_max
            z_min = sorted(1);
            z_max = sorted(length(sorted));
            z_med = sorted((length(sorted) + 1)/2);
            z_max;
            z_med;
            z_min;
            x = z_med-z_min;
            y = z_max-z_med;
            if z_med - z_min > 0 & z_max - z_med > 0
                z_med - z_min;
                z_max - z_med;
                z_med - z_max;         % this is strange because it is restricted to be at least 0
                % go to stage B
                if z_xy - z_min > 0 & z_max - z_xy > 0
                    % output z_xy
                    im_res(r - pad_size, c - pad_size) = z_xy;
                else
                    % output z_med
                    im_res(r - pad_size, c - pad_size) = z_med;
                end
                break;
            end
        end
        % output z_med
        im_res(r - pad_size, c - pad_size) = z_med;
    end
end
im_res = im_res/256