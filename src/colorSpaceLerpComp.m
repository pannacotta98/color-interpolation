%%
% Blue to yellow creates magenta-ish in lab?
% from = [0 0 1];
% to = [1 1 0];
from = uisetcolor();
to = uisetcolor();
in = zeros(1,2,3);
in(1,1,:) = from;
in(1,2,:) = to;
scaleFactor = 200;

colorSpaces = {'srgb', 'linrgb', 'lab', 'ycbcr', 'hsv', 'xyz'};
for i = 1:length(colorSpaces)
    subplot(3, 2, i);
    im = upscaleInColorSpace(in, scaleFactor, colorSpaces{i}, 'bilinear');
    % Crop constant parts, and some height for displaying purposes
%     im = im(50:150, (size(im,2)/4):(3*size(im,2)/4+1), :);
    imshow(im);
    title(colorSpaces{i});
    
    % Save to file
    fileName = ['./../output/lerp-color-' colorSpaces{i} '.png'];
    imwrite(im, fileName);
end















