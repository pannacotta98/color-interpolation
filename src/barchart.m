%% Plot color space values
%load('../data/color-space-eval/objValues.mat');

% bar(SCIELAB)
% title("S-CIELAB values for the images in different color spaces")
% ylabel("Mean S-CIELAB error")
% xlabel("Image")
% legend('sRGB','LinRGB','HSV','YCbCr','CIELAB','XYZ')
% 
% figure
% bar(PSNR)
% title("PSNR values for the images in different color spaces")
% ylabel("PSNR value")
% xlabel("Image")
% legend('sRGB','LinRGB','HSV','YCbCr','CIELAB','XYZ')
% 
% figure
% bar(SSIM)
% title("SSIM index for the images in different color spaces")
% ylabel("SSIM index")
% xlabel("Image")
% legend('sRGB','LinRGB','HSV','YCbCr','CIELAB','XYZ')

%% Plot interpolation method values
load('../data/interp-methods-eval/objValues.mat');

bar(SCIELAB)
title("S-CIELAB values for the images using different upscaling methods")
ylabel("Mean S-CIELAB error")
xlabel("Image")
legend('nearest','bilinear','bicubic','lanczos3','Ogniewski')

figure
bar(PSNR)
title("PSNR values for the images using different upscaling methods")
ylabel("PSNR value")
xlabel("Image")
legend('nearest','bilinear','bicubic','lanczos3','Ogniewski')

figure
bar(SSIM)
title("SSIM index for the images using different upscaling methods")
ylabel("SSIM index")
xlabel("Image")
legend('nearest','bilinear','bicubic','lanczos3','Ogniewski')