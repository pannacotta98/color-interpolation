addpath('./scielab')
img = loadTestImage();
scalefactor = 4;

%Downscale
img_srgb = upscaleInColorSpace(img,1/scalefactor,'srgb','lanczos2');
img_lin = upscaleInColorSpace(img,1/scalefactor,'linrgb','lanczos2');
img_hsv = upscaleInColorSpace(img,1/scalefactor,'hsv','lanczos2');
img_ycbcr = upscaleInColorSpace(img,1/scalefactor,'ycbcr','lanczos2');

%Upscale
img_srgb = upscaleInColorSpace(img_srgb,scalefactor,'srgb','ogniewski');
img_lin = upscaleInColorSpace(img_lin,scalefactor,'linrgb','ogniewski');
img_hsv = upscaleInColorSpace(img_hsv,scalefactor,'hsv','ogniewski');
img_ycbcr = upscaleInColorSpace(img_ycbcr,scalefactor,'ycbcr','ogniewski');


colorSpace = {'SRGB';'LINRGB';'HSV';'YCBCR'};
SSIM = [ssim(img_srgb,img); ssim(img_lin,img); ssim(img_hsv,img); ssim(img_ycbcr,img)];
PSNR = [psnr(img_srgb,img); psnr(img_lin,img); psnr(img_hsv,img); psnr(img_ycbcr,img)];
SCIELAB = [calcScielab(img, img_srgb); calcScielab(img, img_lin);
          calcScielab(img, img_hsv); calcScielab(img, img_ycbcr)];
table(colorSpace,SSIM,PSNR,SCIELAB)