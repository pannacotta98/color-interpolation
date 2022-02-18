addpath('./scielab')
addpath('./ogniewski')
addpath('../data/640x400')
img = loadTestImage();
scalefactor = 4;

%Downscale
img_srgb = upscaleInColorSpace(img,1/scalefactor,'srgb','lanczos2');
img_lin = upscaleInColorSpace(img,1/scalefactor,'linrgb','lanczos2');
img_hsv = upscaleInColorSpace(img,1/scalefactor,'hsv','lanczos2');
img_ycbcr = upscaleInColorSpace(img,1/scalefactor,'ycbcr','lanczos2');
img_lab = upscaleInColorSpace(img,1/scalefactor,'lab','lanczos2');
img_xyz = upscaleInColorSpace(img,1/scalefactor,'xyz','lanczos2');

%Clamp
img_srgb = clamp(img_srgb,0,1);
img_lin = clamp(img_lin,0,1);
img_hsv = clamp(img_hsv,0,1);
img_ycbcr = clamp(img_ycbcr,0,1);
img_lab = clamp(img_lab,0,1);
img_xyz = clamp(img_xyz,0,1);

%Upscale
img_srgb = upscaleInColorSpace(img_srgb,scalefactor,'srgb','ogniewski');
img_lin = upscaleInColorSpace(img_lin,scalefactor,'linrgb','ogniewski');
img_hsv = upscaleInColorSpace(img_hsv,scalefactor,'hsv','ogniewski');
img_ycbcr = upscaleInColorSpace(img_ycbcr,scalefactor,'ycbcr','ogniewski');
img_lab = upscaleInColorSpace(img_lab,scalefactor,'lab','ogniewski');
img_xyz = upscaleInColorSpace(img_xyz,scalefactor,'xyz','ogniewski');


colorSpace = {'SRGB';'LINRGB';'HSV';'YCBCR';'CIELAB';'XYZ'};
SSIM = [ssim(img_srgb,img); ssim(img_lin,img); ssim(img_hsv,img);
        ssim(img_ycbcr,img);ssim(img_lab,img);ssim(img_xyz,img);];
PSNR = [psnr(img_srgb,img); psnr(img_lin,img); psnr(img_hsv,img);
        psnr(img_ycbcr,img);psnr(img_lab,img);psnr(img_xyz,img)];
SCIELAB = [calcScielab(img, img_srgb); calcScielab(img, img_lin);
          calcScielab(img, img_hsv); calcScielab(img, img_ycbcr);
          calcScielab(img, img_lab);calcScielab(img, img_xyz)];

table(colorSpace,SSIM,PSNR,SCIELAB)