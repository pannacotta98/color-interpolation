function [height, width, inCoordX, inCoordY] = calcNewGeometry(im, scaleFactor)
height = ceil(size(im, 1) * scaleFactor);
width = ceil(size(im, 2) * scaleFactor);
outCoordX = (1:width)';
outCoordY = (1:height)';
inCoordX = calcOutCoord(outCoordX, scaleFactor);
inCoordY = calcOutCoord(outCoordY, scaleFactor);
end