function ada_med_filt(img_name)
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
figure;
subplot(121);
imshow(im);
title('salt & pepper');

subplot(122);
% attention here: 
% % the type of im is uint
% im_pad: uint
% im_res: double
% imshow(im_res);         % mistake   
% make mistake here, the pic shown is white.
% this is because imshow() set the range of intensity for double type to be
% [0, 1]
% so method 1: imshow(im_res/256);
% method 2: imshow(im_res, []);    % auto-adjust
imshow(im_res, []);
title('adaptive median filter');