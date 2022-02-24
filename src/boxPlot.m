load('../data/color-space-eval/objValues.mat');

figure
boxplot(SSIM,'Labels',{'sRGB','Lin RGB','HSV','YCbCr','CIELAB','XYZ'})
ylabel('SSIM index')
title('SSIM value for the color spaces')

figure
boxplot(PSNR,'Labels',{'sRGB','Lin RGB','HSV','YCbCr','CIELAB','XYZ'})
ylabel('PSNR value')
title('PSNR value for the color spaces')

figure
boxplot(SCIELAB,'Labels',{'sRGB','Lin RGB','HSV','YCbCr','CIELAB','XYZ'})
ylabel('Mean error')
title('s-CIELAB value for the color spaces')

