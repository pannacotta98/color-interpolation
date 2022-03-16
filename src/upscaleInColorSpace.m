function out = upscaleInColorSpace(in, scaleFactor, colorSpace, method, verbose)
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
        outInColorSpace = ogniewskiUpscale(in, scaleFactor);
    elseif strcmp(method, 'eq1')
        outInColorSpace = eq1Upscale(in, scaleFactor);
    else
        outInColorSpace = imresize(in, scaleFactor, method);
    end

    out = invTransf(outInColorSpace);

    if nargin == 5 && verbose
        disp(['=== ', method, ' == ' colorSpace, ' ==='])
        disp(['Min/max value in color space: ' ...
            num2str(min(outInColorSpace, [], 'all')), '/' ...
            num2str(max(outInColorSpace, [], 'all'))]);
        disp(['Min/max value in final image in srgb: ' ...
            num2str(min(out, [], 'all')), '/' ...
            num2str(max(out, [], 'all'))]);

    end
end
