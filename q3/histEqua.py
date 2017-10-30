# -*- coding: utf-8 -*-

from PIL import Image
# from PIL.Image import core as _imaging
from pylab import *

# get image
im = array(Image.open('Q_1_1.tif').convert('L'))   # also Q_1_2.tif

# hist(im.flatten(),256)

imhist,bins = histogram(im.flatten(),256,normed=True)

cdf = imhist.cumsum()

cdf = cdf*255/cdf[-1]


im2 = interp(im.flatten(),bins[:256],cdf)

im2 = im2.reshape(im.shape)


# hist(im2.flatten(),256)

gray()

subplot(121)
imshow(im)

subplot(122)
imshow(im2)

show()