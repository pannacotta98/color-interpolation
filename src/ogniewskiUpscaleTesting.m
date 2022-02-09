clear
addpath('./../ext/fig-utils') % showmethefigs
addpath('./ogniewski')

%%
%im = im2double(imread('./../data/jens/vikings_baelog_input.png'));
im = loadTestImage();

%%
imshow(im);

%%
scaleFactor = 10;
scaledIm = ogniewskiUpscale(im, scaleFactor);
imshow(scaledIm);
