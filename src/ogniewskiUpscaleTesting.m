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

scaleFactor = 20;

scaledIm = ogniewskiUpscale(im, scaleFactor);
% test = imresize(im, 20, 'nearest');
% diff = scaledIm - test;
% imshow(diff);
%scaledIm = eq1Interpolate(im, 200);

scaledOther = imresize(im, scaleFactor, 'bilinear');

subplot(1,2,1);
imshow(scaledIm); title('Ours')

subplot(1,2,2);
imshow(scaledOther); title('Built-in')