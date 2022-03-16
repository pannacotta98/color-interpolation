addpath('./scielab')
addpath('./ogniewski')
addpath('../data/color-space-eval/')
img = loadTestImage();

scalefactor = 4;

%Downscale
img_ds = imresize(img,1/scalefactor,'lanczos2');

%Upscale
img_near = imresize(img_ds,scalefactor,'nearest');
img_bil = imresize(img_ds,scalefactor,'bilinear');
img_bic = imresize(img_ds,scalefactor,'bicubic');
img_lanc = imresize(img_ds,scalefactor,'lanczos2');
img_og = ogniewskiUpscale(img_ds, scalefactor);

interpMethod = {'nearest';'bilinear';'bicubic';'lanczos2';'Ogniewski'};
SSIM = [mean(ssim(img_near,img,'DataFormat','SSC')); mean(ssim(img_bil,img,'DataFormat','SSC'));
    mean(ssim(img_bic,img,'DataFormat','SSC')); mean(ssim(img_lanc,img,'DataFormat','SSC'));
    mean(ssim(img_og,img,'DataFormat','SSC'));];
PSNR = [psnr(img_near,img);psnr(img_bil,img); psnr(img_bic,img); psnr(img_lanc,img);
        psnr(img_og,img)];
SCIELAB = [calcScielab(img, img_near); calcScielab(img, img_bil); calcScielab(img, img_bic);
          calcScielab(img, img_lanc); calcScielab(img, img_og)];

table(interpMethod,SSIM,PSNR,SCIELAB)

figure('Name', 'nearest');
imshow(img_near)
figure('Name', 'bilinear');
imshow(img_bil)
figure('Name', 'bicubic');
imshow(img_bic)
figure('Name', 'lanczos2');
imshow(img_lanc)
figure('Name', 'ogniewski');
imshow(img_og)

%%
diff = img_og - img;
diffGray = im2gray(diff);
imshow(abs(fftshift(fft2(diffGray))), [0 100])

