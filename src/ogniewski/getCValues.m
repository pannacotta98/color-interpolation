function alphas = getCValues(im)
% Corresponds to calc_cvalues in origininal C implementation

height = size(im, 1);
width = size(im, 2);

alphas = zeros(height, width, 2);

%% Corresponding to first if
d0 = im(:, 2:end-1, :) - im(:, 1:end-2, :);
d1 = im(:, 3:end, :) - im(:, 2:end-1, :);

% Don't know how this correlates to the paper...
td = 0.5 * (d0 + d1);
tempAlphas = 0.5 * ones(height, width-2, 3);
mask = abs(d0) < abs(td);
tempAlphas(mask) = abs(d0(mask)) ./ abs(td(mask)) * 0.5;
mask = abs(d1) < abs(td);
tempAlphas(mask) = abs(d1(mask)) ./ abs(td(mask)) * 0.5;

% Disregard if both zero
tempAlphas((d0 == 0) & (d1 == 0)) = NaN;
% Set to zero if different signs
tempAlphas(sign(d0) ~= sign(d1)) = 0;

alphas(:, 2:end-1, 1) = min(tempAlphas, [], 3);

%% Corresponding to second if
d0 = im(2:end-1, :, :) - im(1:end-2, :, :);
d1 = im(3:end, :, :) - im(2:end-1, :, :);

% Don't know how this correlates to the paper...
td = 0.5 * (d0 + d1);
tempAlphas = 0.5 * ones(height-2, width, 3);
mask = abs(d0) < abs(td);
tempAlphas(mask) = abs(d0(mask)) ./ abs(td(mask)) * 0.5;
mask = abs(d1) < abs(td);
tempAlphas(mask) = abs(d1(mask)) ./ abs(td(mask)) * 0.5;

% Disregard if both zero
tempAlphas((d0 == 0) & (d1 == 0)) = NaN;
% Set to zero if different signs
tempAlphas(sign(d0) ~= sign(d1)) = 0;

alphas(2:end-1, :, 2) = min(tempAlphas, [], 3);

%% Set all disregarded to zero
alphas(isnan(alphas)) = 0;


end

