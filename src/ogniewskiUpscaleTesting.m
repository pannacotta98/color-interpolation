clear
addpath('./../ext/fig-utils') % showmethefigs
addpath('./ogniewski')

%%
%im = im2double(imread('./../data/jens/vikings_baelog_input.png'));
im = loadTestImage();
scaleFactor = 4;

%%
imshow(im);

%%
tic
scaledIm = ogniewskiUpscale(im, scaleFactor);
imshow(scaledIm); title('eq5')
toc

%%
tic
scaledIm = eq1Upscale(im, scaleFactor);
imshow(scaledIm); title('eq1')
toc