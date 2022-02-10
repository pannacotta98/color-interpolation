function scaledIm = eq1Upscale(im, scaleFactor)
[height, width, inCoordX, inCoordY] = calcNewGeometry(im, scaleFactor);
scaledIm = zeros(height, width, 3);

for y = 1:height % Pixel indices in upscaled image
for x = 1:width
    yin = inCoordY(y);
    xin = inCoordX(x);

    % Positions in input space
    h = min(size(im,1), max(1, floor(yin)));
    g = min(size(im,2), max(1, floor(xin)));

    bx = xin - floor(xin) - 0.5;
    by = yin - floor(yin) - 0.5;
    signx = sign(bx);
    signy = sign(by);
    bx = abs(bx);
    by = abs(by);

    % 3x3 neighborhood colors
    bc = zeros(3,3,3);
    for dy = 1:3
    for dx = 1:3
        ty = (dy - 2) * signy + h;
        tx = (dx - 2) * signx + g;
        
        % Restrict to valid range
        ty = max(1, min(size(im, 1), ty));
        tx = max(1, min(size(im, 2), tx));
        
        % This is much faster than `bc(dy, dx, :) = im(ty, tx, :);`
        % Why? No idea
        bc(dy, dx, 1) = im(ty, tx, 1);
        bc(dy, dx, 2) = im(ty, tx, 2);
        bc(dy, dx, 3) = im(ty, tx, 3);
    end
    end
    
    wx = [0; (1-2*bx^2); 2*bx^2];
    wy = [0; (1-2*by^2); 2*by^2];

    tc = sum(sum(bc .* (wy * wx'), 1), 2);
    
    % Clamp final value to valid range
    scaledIm(y, x, :) = min(1, max(0, tc));
end
end

end

