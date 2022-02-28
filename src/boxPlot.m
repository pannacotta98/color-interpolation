%% Plot color space values
%load('../data/color-space-eval/objValues.mat');

% figure
% boxplot(SSIM,'Labels',{'sRGB','Lin RGB','HSV','YCbCr','CIELAB','XYZ'})
% ylabel('SSIM index')
% title('SSIM value for the color spaces')
% 
% figure
% boxplot(PSNR,'Labels',{'sRGB','Lin RGB','HSV','YCbCr','CIELAB','XYZ'})
% ylabel('PSNR value')
% title('PSNR value for the color spaces')
% 
% figure
% boxplot(SCIELAB,'Labels',{'sRGB','Lin RGB','HSV','YCbCr','CIELAB','XYZ'})
% ylabel('Mean error')
% title('S-CIELAB value for the color spaces')

%% Plot interpolation method values
load('../data/interp-methods-eval/objValues.mat');

figure
boxplot(SSIM,'Labels',{'nearest','bilinear','bicubic','lanczos3','Ogniewski'})
ylabel('SSIM index')
title('SSIM value for the interpolation methods')

figure
boxplot(PSNR,'Labels',{'nearest','bilinear','bicubic','lanczos3','Ogniewski'})
ylabel('PSNR value')
title('PSNR value for the interpolation methods')

figure
boxplot(SCIELAB,'Labels',{'nearest','bilinear','bicubic','lanczos3','Ogniewski'})
ylabel('Mean error')
title('S-CIELAB value for the intepolation methods')