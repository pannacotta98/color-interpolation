clear
addpath('./scielab')
addpath('./ogniewski')
addpath('../data/color-space-eval/')

png = dir('./../data/color-space-eval/*.png');
jpg = dir('./../data/color-space-eval/*.jpg');
scalefactor = 4;

downscaleMethod = 'lanczos2';
upscaleMethods = {'nearest','bilinear','bicubic','lanczos3','ogniewski'}';

f = vertcat(jpg,png);
files={f.name};
for k=1:numel(files)
    files{k}
    Im{k}=imread(files{k});
    img = im2double(imread(files{k}));

    %Downscale
    img_ds = imresize(img,1/scalefactor,downscaleMethod);
    img_ds = clamp(img_ds, 0, 1);
    
    %Upscale
    out = cell(length(upscaleMethods), 1);
    for i=1:length(upscaleMethods)
        upscaled = upscaleInColorSpace(img_ds, scalefactor, 'srgb', upscaleMethods{i});
        out{i} = clamp(upscaled, 0, 1);
    end

    SSIM{k} = cellfun(@(scaled) mean(ssim(scaled,img,'DataFormat','SSC')), out);
    PSNR{k} = cellfun(@(scaled) psnr(scaled,img), out);
    SCIELAB{k} = cellfun(@(scaled) calcScielab(scaled,img), out);
    meanDeltaE{k} = cellfun(@(scaled) mean(deltaE(scaled, img), 'all'), out);
    medianDeltaE{k} = cellfun(@(scaled) median(deltaE(scaled, img), 'all'), out);
    NIQE{k} = cellfun(@(scaled) niqe(scaled),out);
    BRISQUE{k} = cellfun(@(scaled) brisque(scaled),out);

    table(upscaleMethods, SSIM{k}, PSNR{k}, SCIELAB{k}, meanDeltaE{k}, medianDeltaE{k}, NIQE{k}, BRISQUE{k})
end

SSIM = transpose(cell2mat(SSIM)); PSNR = transpose(cell2mat(PSNR)); 
SCIELAB = transpose(cell2mat(SCIELAB)); meanDeltaE = transpose(cell2mat(meanDeltaE));
medianDeltaE = transpose(cell2mat(medianDeltaE));

%Uncomment to save variables
%save('../data/interp-methods-eval/objValues.mat','SSIM','PSNR','SCIELAB', ...
 %   'meanDeltaE','medianDeltaE','-append');
