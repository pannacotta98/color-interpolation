clear
close all
addpath('./../ext/fig-utils') % showmethefigs
addpath('./ogniewski')

%%
% im = im2double(imread('https://assets.turbologo.com/blog/en/2021/06/14075433/famous-logos-480x288.png'));
im = loadTestImage();
scaleFactor = 16;
images = {};

%%
colSpaces = {'srgb', 'linrgb', 'lab', 'ycbcr', 'hsv', 'xyz'};
% colSpaces = {'srgb', 'linrgb', 'lab', 'ycbcr', 'xyz'};
%colSpaces = {'srgb', 'linrgb', 'ycbcr', 'xyz'};
for i = 1:length(colSpaces)
    imOut = upscaleInColorSpace(im, scaleFactor, colSpaces{i}, 'ogniewski', true);
    figure('Name', colSpaces{i});
    imshow(imOut, 'Border', 'tight');
    title(colSpaces{i});
    images{i} = imOut;
end

%%
showmethefigs(3)

%%
close all

%%
diff = images{1}-images{4};
disp(max(diff(:)));
imshow(rescale(diff));

%%
imshowpair(images{1}, images{4}, 'checkerboard');

%%
for i = 1:length(colSpaces)
    figure('Name', colSpaces{i});
    xyz = rgb2xyz(images{i});
    y = xyz(:,:,2);
    imshow(y, 'Border', 'tight');
    title(colSpaces{i});
end
