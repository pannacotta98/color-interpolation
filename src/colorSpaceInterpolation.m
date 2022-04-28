clear
close all
addpath('./../ext/fig-utils') % showmethefigs
addpath('./ogniewski')

%%
% im = im2double(imread('https://entropymine.com/imageworsener/gamma/g/rasp-grayator.png'));
im = loadTestImage();
scaleFactor = 32;
images = {};

%%
% colSpaces = {'srgb', 'linrgb', 'lab', 'ycbcr', 'hsv', 'xyz'};
colSpaces = {'srgb', 'linrgb', 'lab', 'ycbcr', 'xyz'};
%colSpaces = {'srgb', 'linrgb', 'ycbcr', 'xyz'};
for i = 1:length(colSpaces)
    imOut = upscaleInColorSpace(im, scaleFactor, colSpaces{i}, 'ogniewski', true);
    figure('Name', colSpaces{i});
    imshow(imOut, 'Border', 'tight');
    title(colSpaces{i});
    images{i} = imOut;
%     imwrite(imOut, ['../output/smol-king-32-', colSpaces{i}, '.png']);
end

%%
showmethefigs(3)

%%
close all
%%
figure
%%
% diff = images{1}-imresize(im, scaleFactor, 'nearest');
diff = images{1}-images{2};
disp(max(diff(:)));
imshow(rescale(diff));

%% DeltaE diff
diff = deltaE(images{1}, images{4});
imagesc(diff); colorbar

%% DeltaE image
diff = deltaE(images{2}, images{5});
maxDiff = max(diff(:))
imshow(diff ./ maxDiff)

%%
imshowpair(images{1}, images{2}, 'checkerboard');

%%
for i = 1:length(colSpaces)
    figure('Name', colSpaces{i});
    xyz = rgb2xyz(images{i});
    y = xyz(:,:,2);
    imshow(y.^(1/2.2), 'Border', 'tight');
    title(colSpaces{i});
end
