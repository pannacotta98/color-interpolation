addpath('./scielab')
addpath('./ogniewski')
addpath('../data/640x400')
img = loadTestImage();
scalefactor = 4;

%Downscale
img_srgb_ds = upscaleInColorSpace(img,1/scalefactor,'srgb','lanczos2');
img_lin_ds = upscaleInColorSpace(img,1/scalefactor,'linrgb','lanczos2');
img_hsv_ds = upscaleInColorSpace(img,1/scalefactor,'hsv','lanczos2');
img_ycbcr_ds = upscaleInColorSpace(img,1/scalefactor,'ycbcr','lanczos2');
img_lab_ds = upscaleInColorSpace(img,1/scalefactor,'lab','lanczos2');
img_xyz_ds = upscaleInColorSpace(img,1/scalefactor,'xyz','lanczos2');

%Clamp
img_srgb_ds_clamped = clamp(img_srgb_ds,0,1);
img_lin_ds_clamped = clamp(img_lin_ds,0,1);
img_hsv_ds_clamped = clamp(img_hsv_ds,0,1);
img_ycbcr_ds_clamped = clamp(img_ycbcr_ds,0,1);
img_lab_ds_clamped = clamp(img_lab_ds,0,1);
img_xyz_ds_clamped = clamp(img_xyz_ds,0,1);

%Upscale
img_srgb = upscaleInColorSpace(img_srgb_ds_clamped,scalefactor,'srgb','ogniewski');
img_lin = upscaleInColorSpace(img_lin_ds_clamped,scalefactor,'linrgb','ogniewski');
img_hsv = upscaleInColorSpace(img_hsv_ds_clamped,scalefactor,'hsv','ogniewski');
img_ycbcr = upscaleInColorSpace(img_ycbcr_ds_clamped,scalefactor,'ycbcr','ogniewski');
img_lab = upscaleInColorSpace(img_lab_ds_clamped,scalefactor,'lab','ogniewski');
img_xyz = upscaleInColorSpace(img_xyz_ds_clamped,scalefactor,'xyz','ogniewski');


colorSpace = {'SRGB';'LINRGB';'HSV';'YCBCR';'CIELAB';'XYZ'};
SSIM = [ssim(img_srgb,img); ssim(img_lin,img); ssim(img_hsv,img);
        ssim(img_ycbcr,img);ssim(img_lab,img);ssim(img_xyz,img);];
PSNR = [psnr(img_srgb,img); psnr(img_lin,img); psnr(img_hsv,img);
        psnr(img_ycbcr,img);psnr(img_lab,img);psnr(img_xyz,img)];
SCIELAB = [calcScielab(img, img_srgb); calcScielab(img, img_lin);
          calcScielab(img, img_hsv); calcScielab(img, img_ycbcr);
          calcScielab(img, img_lab);calcScielab(img, img_xyz)];

table(colorSpace,SSIM,PSNR,SCIELAB)