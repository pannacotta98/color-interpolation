function out_imgs = convertCSpace(in_imgs,cSpace)
%Converts multiple images to a specified color space.
%inputs:
%   in_imgs: should be a cell array of rgb images
%   cSpace: The desired color space, for example 'cielab'
%Outputs:
%   out_imgs: Cell array of images in new color space
addpath('./../ext/fig-utils') % showmethefigs

out_imgs = cell(1,length(in_imgs));

if strcmp(cSpace,'linear')
    for i = 1:length(out_imgs)
        figure;
        out_imgs{i} = rgb2lin(in_imgs{i});
        imshow(out_imgs{i});
    end
elseif strcmp(cSpace,'cielab')
    for i = 1:length(out_imgs)
        figure;
        out_imgs{i} = rgb2lab(in_imgs{i});
        imshow(out_imgs{i});
    end
elseif strcmp(cSpace,'ycbcr')
    for i = 1:length(out_imgs)
        figure;
        out_imgs{i} = rgb2ycbcr(in_imgs{i});
        imshow(out_imgs{i});
    end
elseif strcmp(cSpace,'hsv')
    for i = 1:length(out_imgs)
        figure;
        out_imgs{i} = rgb2hsv(in_imgs{i});
        imshow(out_imgs{i});
    end
end
    
    showmethefigs(3);
    close all
end
