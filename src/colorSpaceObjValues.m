clear
addpath('./scielab')
addpath('./ogniewski')
addpath('../data/color-space-eval/')
%img = loadTestImage();
scalefactor = 4;

downscaleMethod = 'lanczos2';
upscaleMethod = 'ogniewski';

%Downscale
img_srgb_ds = upscaleInColorSpace(img,1/scalefactor,'srgb',downscaleMethod);
img_lin_ds = upscaleInColorSpace(img,1/scalefactor,'linrgb',downscaleMethod);
img_hsv_ds = upscaleInColorSpace(img,1/scalefactor,'hsv',downscaleMethod);
img_ycbcr_ds = upscaleInColorSpace(img,1/scalefactor,'ycbcr',downscaleMethod);
img_lab_ds = upscaleInColorSpace(img,1/scalefactor,'lab',downscaleMethod);
img_xyz_ds = upscaleInColorSpace(img,1/scalefactor,'xyz',downscaleMethod);

%Clamp
img_srgb_ds_clamped = clamp(img_srgb_ds,0,1);
img_lin_ds_clamped = clamp(img_lin_ds,0,1);
img_hsv_ds_clamped = clamp(img_hsv_ds,0,1);
img_ycbcr_ds_clamped = clamp(img_ycbcr_ds,0,1);
img_lab_ds_clamped = clamp(img_lab_ds,0,1);
img_xyz_ds_clamped = clamp(img_xyz_ds,0,1);

%Upscale
img_srgb = upscaleInColorSpace(img_srgb_ds_clamped,scalefactor,'srgb',upscaleMethod);
img_lin = upscaleInColorSpace(img_lin_ds_clamped,scalefactor,'linrgb',upscaleMethod);
img_hsv = upscaleInColorSpace(img_hsv_ds_clamped,scalefactor,'hsv',upscaleMethod);
img_ycbcr = upscaleInColorSpace(img_ycbcr_ds_clamped,scalefactor,'ycbcr',upscaleMethod);
img_lab = upscaleInColorSpace(img_lab_ds_clamped,scalefactor,'lab',upscaleMethod);
img_xyz = upscaleInColorSpace(img_xyz_ds_clamped,scalefactor,'xyz',upscaleMethod);


colorSpace = {'SRGB';'LINRGB';'HSV';'YCBCR';'CIELAB';'XYZ'};
SSIM = [mean(ssim(img_srgb,img,'DataFormat','SSC')); mean(ssim(img_lin,img,'DataFormat','SSC'));
    mean(ssim(img_hsv,img,'DataFormat','SSC')); mean(ssim(img_ycbcr,img,'DataFormat','SSC'));
    mean(ssim(img_lab,img,'DataFormat','SSC')); mean(ssim(img_xyz,img,'DataFormat','SSC'));];
PSNR = [psnr(img_srgb,img); psnr(img_lin,img); psnr(img_hsv,img);
        psnr(img_ycbcr,img);psnr(img_lab,img);psnr(img_xyz,img)];
SCIELAB = [calcScielab(img, img_srgb); calcScielab(img, img_lin);
          calcScielab(img, img_hsv); calcScielab(img, img_ycbcr);
          calcScielab(img, img_lab);calcScielab(img, img_xyz)];
meanDeltaE = [mean(deltaE(img, img_srgb),'all'); mean(deltaE(img, img_lin),  'all');
              mean(deltaE(img, img_hsv), 'all'); mean(deltaE(img, img_ycbcr),'all');
              mean(deltaE(img, img_lab), 'all'); mean(deltaE(img, img_xyz),  'all')];
medianDeltaE = [median(deltaE(img, img_srgb),'all'); median(deltaE(img, img_lin),  'all');
                median(deltaE(img, img_hsv), 'all'); median(deltaE(img, img_ycbcr),'all');
                median(deltaE(img, img_lab), 'all'); median(deltaE(img, img_xyz),  'all')];

table(colorSpace,SSIM,PSNR,SCIELAB,meanDeltaE, medianDeltaE)

%%
bar(reordercats(categorical(colorSpace),colorSpace), SCIELAB)

%%
close all
%% Plot images
figure; imshow(img_srgb); title('srgb');
figure; imshow(img); title('original')
figure; imshow(img_lin); title('lin');
figure; imshow(img_hsv); title('hsv');
figure; imshow(img_ycbcr); title('ycbcr');
figure; imshow(img_lab); title('lab');
figure; imshow(img_xyz); title('xyz');
%% Diff imgs delta E
sc = 0.01;
figure;imshow(sc * deltaE(img_srgb, img));title('srgb')
figure;imshow(sc * deltaE(img_lin, img));title('lin')

