clear
addpath('./../ext/fig-utils') % showmethefigs

%%
im = imread('./../data/pixel-cube.png');

scaleMethods = {'nearest', 'bilinear', 'bicubic', 'lanczos2', 'lanczos3'};
scaleFactor = 100;

for i = 1:length(scaleMethods)
   figure('Name', scaleMethods{i});
   imUp = imresize(im, scaleFactor, scaleMethods{i});
   imshow(imUp);
   title(scaleMethods{i});
end

showmethefigs(3);

close all