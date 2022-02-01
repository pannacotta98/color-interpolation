function im = loadTestImage()
list = dir('./../data/**/*.png');
[indx,tf] = listdlg('ListString',{list.('name')}, 'SelectionMode','single');
if tf == 0
    error('No image selected');
end
file = list(indx);
fileName = fullfile(file.folder, file.name);
im = im2double(imread(fileName));
end

