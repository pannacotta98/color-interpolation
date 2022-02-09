function inCoord = calcOutCoord(outCoord, scaleFactor)
    % See matlab.images.internal.resize.contributions
    inCoord = outCoord/scaleFactor + 0.5 * (1 - 1/scaleFactor) + 0.5;
end