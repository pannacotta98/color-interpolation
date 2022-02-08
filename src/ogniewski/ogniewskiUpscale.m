function scaledIm = ogniewskiUpscale(im, scaleFactor)
%OGNIEWSKIUPSCALE Upscale image using the Ogniewski method
%   Based on the paper "Artifact-Free Color Interpolation" by Jens
%   Ogniewski.

alphas = getCValues(im);

%% === Simple temporary outline ===
% Calculate new pixel locations, see matlab.images.internal.resize.contributions
% Interpolate the alpha values
% Do the final interpolation

%%
[height, width, inCoordX, inCoordY] = calcNewGeometry(im, scaleFactor);
scaledIm = zeros(height, width, 3);

% I mightve mixed up x and y, TODO check!

%%
for y = 1:height % pixel indices in upscaled image
for x = 1:width
    yin = inCoordY(y);
    xin = inCoordX(x);
    
    h = round(yin);
    g = round(xin);
    
    %fprintf("h=%i g=%i\n", h, g);

    bx = xin - floor(xin) - 0.5;
    by = yin - floor(yin) - 0.5;
    signx = sign(bx);
    signy = sign(by);
    bx = abs(bx);
    by = abs(by);

    bc = zeros(3,3,3); % 3x3 neighborhood colors
    for dy = 1:3
    for dx = 1:3
        ty = (dy - 2) * signy + h;
        tx = (dx - 2) * signx + g;
        
        % Restrict to valid range
        ty = max(1, min(size(im, 1), ty));
        tx = max(1, min(size(im, 2), tx));
        
        bc(dy, dx, :) = im(ty, tx, :);

        ax0 = alphas(h, g, 1)*(1-2*by^2) + alphas(ty,g, 1)*2*by^2;
        ax1 = alphas(h, tx,1)*(1-2*by^2) + alphas(ty,tx,1)*2*by^2;
        ay0 = alphas(h, g, 2)*(1-2*bx^2) + alphas(h, tx,2)*2*bx^2;
        ay1 = alphas(ty,g, 2)*(1-2*bx^2) + alphas(ty,tx,2)*2*bx^2;
    end
    end
    
    ad4x = 3*bx^2 - 4*bx^3;
    ad4y = 3*by^2 - 4*by^3;

    wx = [
        ax0 .* (bx^2 - bx + ad4x)
		1 - bx^2 - (1 + ax0.*2 - ax1.*2) * ad4x
		(1 - ax0).*bx^2 + ax0.*bx + ((1 + ax0.*2 - ax1.*2) - ax0).*ad4x
    ];
    wy = [
        ay0 .* (by^2 - by + ad4y)
		1 - by^2 - (1 + ay0.*2 - ay1.*2) .* ad4y
		(1 - ay0).*by^2 + ay0.*by + ((1 + ay0.*2 - ay1.*2) - ay0).*ad4y
    ];

    %%

    %disp(wy * wx')
    tc = sum(sum(bc .* (wy * wx'), 1), 2);
    
    % TODO Clamp!

    scaledIm(y, x, :) = tc;

    %% Testing
%         scaledIm(x,y,1) = mod(g, 2);
%         scaledIm(x,y,2) = h * 0.05;

%         scaledIm(x,y,:) = im(g, h,:);

%         scaledIm(y, x, 1) = bx;
%         scaledIm(y, x, 2) = by;

%     scaledIm(y, x, 1) = mod(g, 2);
%     scaledIm(y, x, 2) = bx;
% 
%     scaledIm(y, x, 1) = mod(h, 2);
%     scaledIm(y, x, 2) = by;

%     nearest = round([inCoordY(y), inCoordX(x)]);
%     scaledIm(y, x, :) = im(nearest(1), nearest(2), :);
end
end

end