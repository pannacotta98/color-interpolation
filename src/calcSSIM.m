function calcSSIM(img)

scaleMethods = {'nearest', 'bilinear', 'bicubic', 'lanczos2', 'lanczos3'};
scaleFactor = 8;

for i = 1:length(scaleMethods)
   figure('Name', scaleMethods{i});
   mod_img = imresize(imresize(img,1/scaleFactor,scaleMethods{i}),scaleFactor,scaleMethods{i});
   value = ssim(mod_img,img);
   S = [scaleMethods{i}, ' ssim: ', num2str(value)]; 
   disp(S)
   imshow(mod_img);
   title(scaleMethods{i});
end

showmethefigs(3);
close all

end