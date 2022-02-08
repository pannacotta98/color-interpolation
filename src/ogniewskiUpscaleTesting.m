clear
addpath('./../ext/fig-utils') % showmethefigs
addpath('./ogniewski')

%%
%im = im2double(imread('./../data/jens/vikings_baelog_input.png'));
im = loadTestImage();

%%
imshow(im);

%%
clc % TEMP

scaledIm = ogniewskiUpscale(im, 10);
% test = imresize(im, 20, 'nearest');
% diff = scaledIm - test;
% imshow(diff);
%scaledIm = eq1Interpolate(im, 200);
imshow(scaledIm);