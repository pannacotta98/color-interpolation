function out = upscaleInColorSpace(in, scaleFactor, colorSpace, method)
    if strcmp(colorSpace, 'srgb')
        % Do nothing
        transf = @(x) x;
        invTransf = @(x) x;
    elseif strcmp(colorSpace, 'linrgb')
        transf = @rgb2lin;
        invTransf = @lin2rgb;
    elseif strcmp(colorSpace, 'lab')
        transf = @rgb2lab;
        invTransf = @lab2rgb;
    elseif strcmp(colorSpace, 'ycbcr')
        transf = @rgb2ycbcr;
        invTransf = @ycbcr2rgb;
    elseif strcmp(colorSpace, 'hsv')
        transf = @rgb2hsv;
        invTransf = @hsv2rgb;
    elseif strcmp(colorSpace, 'xyz')
        transf = @rgb2xyz;
        invTransf = @xyz2rgb;
    end

    in = transf(in);

    if strcmp(method, 'ogniewski')
        out = ogniewskiUpscale(in, scaleFactor);
    elseif strcmp(method, 'eq1')
        out = eq1Upscale(in, scaleFactor);
    else
        out = imresize(in, scaleFactor, method);
    end

    out = invTransf(out);
end

