clear
addpath('./../ext/fig-utils') % showmethefigs
addpath('./ogniewski')

%%
im = loadTestImage();
whos im

scaleMethods = {'nearest', 'bilinear', 'bicubic', 'lanczos2', 'lanczos3'};
scaleFactor = 10;

for i = 1:length(scaleMethods)
   figure('Name', scaleMethods{i});
   imUp = imresize(im, scaleFactor, scaleMethods{i});
   imshow(imUp);
   title(scaleMethods{i});
end

figure('Name', 'ogniewski');
imUp = ogniewskiUpscale(im, scaleFactor);
imshow(imUp);
title('ogniewski');

figure('Name', 'ogniewski eq 1');
imUp = eq1Upscale(im, scaleFactor);
imshow(imUp);
title('ogniewski eq 1');

disp('done')

%%
showmethefigs(3);

%%
close all