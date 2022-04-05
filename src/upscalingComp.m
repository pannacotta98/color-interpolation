clear
addpath('./../ext/fig-utils') % showmethefigs
addpath('./ogniewski')
%%
close all
%% Load test image directly
im = loadTestImage();
whos im

%% Or let the image be scaled down
% im = loadTestImage();
% preferredWidth = 

%%

scaleMethods = {'nearest', 'bilinear', 'bicubic', 'lanczos2', 'lanczos3'};
scaleFactor = 5;

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