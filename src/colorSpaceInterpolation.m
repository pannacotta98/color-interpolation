clear
clf
addpath('./../ext/fig-utils') % showmethefigs
addpath('./ogniewski')

%%
%im = im2double(imread('./../data/jens/vikings_baelog_input.png'));
im = loadTestImage();
scaleFactor = 16;

%%
colSpaces = {'srgb', 'linrgb', 'lab', 'ycbcr', 'hsv', 'xyz'};
for i = 1:length(colSpaces)
    imOut = upscaleInColorSpace(im, scaleFactor, colSpaces{i}, 'ogniewski');
    figure;
    imshow(imOut);
    title(colSpaces{i});
end

%%
close all