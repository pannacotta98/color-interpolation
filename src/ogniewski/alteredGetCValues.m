function alphas = alteredGetCValues(im)
% Corresponds to calc_cvalues in origininal C implementation

height = size(im, 1);
width = size(im, 2);

alphas = zeros(height, width, 2);

%% Corresponding to first if
d0 = im(:, 2:end-1, :) - im(:, 1:end-2, :);
d1 = im(:, 3:end, :) - im(:, 2:end-1, :);

% tempAlphas = ones(height, width-2, 3);
tempAlphas = d1 ./ d0;

mask = abs(d1) > abs(d0);
tempAlphas(mask) = d0(mask) ./ d1(mask);

tempAlphas(tempAlphas < 0) = 0;
% tempAlphas(tempAlphas < 0.000001) = NaN;

alphas(:, 2:end-1, 1) = min(tempAlphas, [], 3);

%% Corresponding to second if
d0 = im(2:end-1, :, :) - im(1:end-2, :, :);
d1 = im(3:end, :, :) - im(2:end-1, :, :);

tempAlphas = d1 ./ d0;

mask = abs(d1) > abs(d0);
tempAlphas(mask) = d0(mask) ./ d1(mask);

tempAlphas(tempAlphas < 0) = 0;
% tempAlphas(tempAlphas < 0.000001) = NaN;

alphas(2:end-1, :, 2) = min(tempAlphas, [], 3);

%% Set all disregarded to zero
alphas(isnan(alphas)) = 0;
alphas = alphas * 0.5;
end

