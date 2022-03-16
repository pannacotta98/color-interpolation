clear
addpath('./scielab')
addpath('./ogniewski')
addpath('../data/color-space-eval/')

png = dir('./../data/color-space-eval/*.png');
jpg = dir('./../data/color-space-eval/*.jpg');
scalefactor = 4;

f = vertcat(jpg,png);
files={f.name};
for k=1:numel(files)
    files{k}
    Im{k}=imread(files{k});
    img = im2double(imread(files{k}));

    downscaleAllInSameSpace = true;
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

    SSIM{k} = cellfun(@(scaled) mean(ssim(scaled,img,'DataFormat','SSC')), out);
    PSNR{k} = cellfun(@(scaled) psnr(scaled,img), out);
    SCIELAB{k} = cellfun(@(scaled) calcScielab(scaled,img), out);
    meanDeltaE{k} = cellfun(@(scaled) mean(deltaE(scaled, img), 'all'), out);
    medianDeltaE{k} = cellfun(@(scaled) median(deltaE(scaled, img), 'all'), out);

    table(spaces, SSIM{k}, PSNR{k}, SCIELAB{k}, meanDeltaE{k}, medianDeltaE{k})


end

    SSIM = transpose(cell2mat(SSIM)); PSNR = transpose(cell2mat(PSNR)); 
    SCIELAB = transpose(cell2mat(SCIELAB)); meanDeltaE = transpose(cell2mat(meanDeltaE));
    medianDeltaE = transpose(cell2mat(medianDeltaE));

    %Uncomment to save variables
    %save('../data/color-space-eval/objValues.mat','SSIM','PSNR','SCIELAB', ...
    %    'meanDeltaE','medianDeltaE','-append');