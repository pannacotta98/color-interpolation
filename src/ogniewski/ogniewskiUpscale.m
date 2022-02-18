function scaledIm = ogniewskiUpscale(im, scaleFactor)
%OGNIEWSKIUPSCALE Upscale image using the Ogniewski method
%   Based on the paper "Artifact-Free Color Interpolation" by Jens
%   Ogniewski.

alphas = getCValues(im);

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

        ax0 = alphas(h, g, 1)*(1-2*by^2) + alphas(ty,g, 1)*2*by^2;
        ax1 = alphas(h, tx,1)*(1-2*by^2) + alphas(ty,tx,1)*2*by^2;
        ay0 = alphas(h, g, 2)*(1-2*bx^2) + alphas(h, tx,2)*2*bx^2;
        ay1 = alphas(ty,g, 2)*(1-2*bx^2) + alphas(ty,tx,2)*2*bx^2;
    end
    end
    
    % Inside the parenthesis of last term eq 4 divided by 4
    ad4x = 3*bx^2 - 4*bx^3;
    ad4y = 3*by^2 - 4*by^3;

    wx = [ax0 .* (bx^2 - bx + ad4x)
		  1 - bx^2 - (1 + ax0.*2 - ax1.*2) * ad4x
		  (1 - ax0).*bx^2 + ax0.*bx + ((1 + ax0.*2 - ax1.*2) - ax0).*ad4x];
    wy = [ay0 .* (by^2 - by + ad4y)
		  1 - by^2 - (1 + ay0.*2 - ay1.*2) .* ad4y
		  (1 - ay0).*by^2 + ay0.*by + ((1 + ay0.*2 - ay1.*2) - ay0).*ad4y];

    tc = sum(sum(bc .* (wy * wx'), 1), 2);
    
    % Clamp final value to valid range
    % scaledIm(y, x, :) = min(1, max(0, tc));

    % Or dont
    scaledIm(y, x, :) = tc;
end
end
disp('Dont forget to clamp final result for measurements!')
% Actually i guess it isn't supposed to clip anyways
end