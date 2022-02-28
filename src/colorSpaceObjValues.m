clear
addpath('./scielab')
addpath('./ogniewski')
addpath('../data/color-space-eval/')
img = loadTestImage();
scalefactor = 4;

downscaleAllInSameSpace = false;
downscaleSpace = 'srgb'; % if above is true
downscaleMethod = 'lanczos2';
upscaleMethod = 'ogniewski';

spaces = {
    'srgb'  % 1
    'linrgb'% 2
    'hsv'   % 3
    'ycbcr' % 4
    'lab'   % 5
    'xyz'}; % 6

if downscaleAllInSameSpace
    downscaled = upscaleInColorSpace(img, 1/scalefactor, downscaleSpace, downscaleMethod);
    downscaled = clamp(downscaled, 0, 1);
end

out = cell(length(spaces), 1);
for i = 1:length(spaces)
    if ~downscaleAllInSameSpace
        downscaled = upscaleInColorSpace(img, 1/scalefactor, spaces{i}, downscaleMethod);
        downscaled = clamp(downscaled, 0, 1);
    end
    upscaled = upscaleInColorSpace(downscaled, scalefactor, spaces{i}, upscaleMethod);
    out{i} = upscaled;
end

SSIM = cellfun(@(scaled) mean(ssim(scaled,img,'DataFormat','SSC')), out);
PSNR = cellfun(@(scaled) psnr(scaled,img), out);
SCIELAB = cellfun(@(scaled) calcScielab(scaled,img), out);
meanDeltaE = cellfun(@(scaled) mean(deltaE(scaled, img), 'all'), out);
medianDeltaE = cellfun(@(scaled) median(deltaE(scaled, img), 'all'), out);
NIQE = cellfun(@(scaled) niqe(scaled),out);
BRISQUE = cellfun(@(scaled) brisque(scaled),out);

table(spaces, SSIM, PSNR, SCIELAB, meanDeltaE, medianDeltaE, NIQE, BRISQUE)

%%
bar(reordercats(categorical(spaces), spaces), SCIELAB)

%%
close all
%% Plot images
figure; imshow(img); title('original');
for i = 1:length(spaces)
    figure; imshow(out{i}); title(spaces{i});
end
%% Diff imgs delta E
sc = 0.01;
for i = 1:length(spaces)
    figure; imshow(sc * deltaE(out{i}, img)); title(spaces{i});
end

