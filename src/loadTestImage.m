function im = loadTestImage()
pngList = dir('./../data/**/*.png');
jpegList = dir('./../data/**/*.jpeg');
jpgList = dir('./../data/**/*.jpg');

list = vertcat(pngList, jpgList, jpegList);
[indx,tf] = listdlg('ListString',{list.('name')}, ...
    'SelectionMode','single', 'ListSize',[500,500]);
if tf == 0
    error('No image selected');
end
file = list(indx);
fileName = fullfile(file.folder, file.name);
disp(['Loaded ', fileName]);
im = im2double(imread(fileName));
end

