function meanError = calcScielab(org_img, interp_img)
% File to calculate s-cielab value of an image and its interpolated version
%inputs:
%   org_img is the original image in rgb
%   interp_img is the interpolated version of original image
%output
% meanError is the mean of the error image

    
%Load the calibration information
sampPerDeg = 23;
load displaySPD;
load SmithPokornyCones;
rgb2lms = cones'* displaySPD;
load displayGamma;
rgbWhite = [1 1 1];
whitepoint = rgbWhite * rgb2lms';
    
% Convert the RGB data to LMS.
    
img1LMS = changeColorSpace(org_img,rgb2lms);
img2LMS = changeColorSpace(interp_img,rgb2lms);
imageformat = 'lms';
    
% Run the scielab function
errorImage = scielab(sampPerDeg, img1LMS, img2LMS, whitepoint, imageformat);
%Get the mean scielab difference
meanError = mean(errorImage(:));
    
%Output difference image    
errorTruncated = min(128*(errorImage/10),128*ones(size(errorImage)));
figure
colormap([gray(127); [1 1 1]])
image(errorTruncated)


%figure(2)
%imshow(org_img)
    
%figure(3)
%imshow(interp_img)

end

