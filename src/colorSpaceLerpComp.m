%%
from = [1 0 0];
to = [0 1 0];
in = zeros(1,2,3);
in(1,1,:) = from;
in(1,2,:) = to;

colorSpaces = {'srgb', 'linrgb', 'lab', 'ycbcr', 'hsv', 'xyz'};
for i = 1:length(colorSpaces)
    subplot(3, 2, i);
    im = bilinearInColorSpace(in, colorSpaces{i});
    % Crop constant parts, and some height for displaying purposes
%     im = im(50:150, (size(im,2)/4):(3*size(im,2)/4+1), :);
    imshow(im);
    title(colorSpaces{i});
    
    % Save to file
    fileName = ['./../output/lerp-color-' colorSpaces{i} '.png'];
    imwrite(im, fileName);
end


%% Local functions
function out = bilinearInColorSpace(in, colorSpace)
    if strcmp(colorSpace, 'srgb')
        % Do nothing
        transf = @(x) x;
        invTransf = @(x) x;
    elseif strcmp(colorSpace, 'linrgb')
        transf = @rgb2lin;
        invTransf = @lin2rgb;
    elseif strcmp(colorSpace, 'lab')
        transf = @rgb2lab;
        invTransf = @lab2rgb;
    elseif strcmp(colorSpace, 'ycbcr')
        transf = @rgb2ycbcr;
        invTransf = @ycbcr2rgb;
    elseif strcmp(colorSpace, 'hsv')
        transf = @rgb2hsv;
        invTransf = @hsv2rgb;
    elseif strcmp(colorSpace, 'xyz')
        transf = @rgb2xyz;
        invTransf = @xyz2rgb;
    end

    in = transf(in);
    out = imresize(in, 200, 'bilinear');
    out = invTransf(out);
end














