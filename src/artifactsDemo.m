%% Demonstration of artifacts that can occur when interpolating color
clear
addpath('./../ext/fig-utils') % showmethefigs
im = loadTestImage();
scaleFactor = 30;

%% === RINGING ===
clf
ringing = imresize(im, scaleFactor, 'lanczos3');
imshow(ringing);
disp(['Max value in ringing image: ', num2str(max(ringing, [], 'all'))]);
disp(['Min value in ringing image: ', num2str(min(ringing, [], 'all'))]);

%% === CLIPPING ===
clf
clipping = imresize(im, scaleFactor, 'bicubic');
imshow(clipping);
disp(['Max value in clipping image: ', num2str(max(clipping, [], 'all'))]);
disp(['Min value in clipping image: ', num2str(min(clipping, [], 'all'))]);

%% one plot
yPlotRange = [-0.2; 1.2];

clf
plot(clipping(size(clipping,1)/2, :, 1), 'r'); ylim(yPlotRange)
hold on
plot(clipping(size(clipping,1)/2, :, 2), 'g'); ylim(yPlotRange)
plot(clipping(size(clipping,1)/2, :, 3), 'b'); ylim(yPlotRange)
grid on
hold off

%% one plot actual clipping
clippingClipped = max(0, min(1, clipping));

clf
plot(clippingClipped(size(clipping,1)/2, :, 1), 'r'); ylim(yPlotRange)
hold on
plot(clippingClipped(size(clipping,1)/2, :, 2), 'g'); ylim(yPlotRange)
plot(clippingClipped(size(clipping,1)/2, :, 3), 'b'); ylim(yPlotRange)
grid on
hold off

%% separate plots
clf

subplot(221)
plot(clipping(size(clipping,1)/2, :, 1), 'r');
ylim(yPlotRange)
grid on

subplot(222)
plot(clipping(size(clipping,1)/2, :, 2), 'g')
ylim(yPlotRange)
grid on

subplot(223)
plot(clipping(size(clipping,1)/2, :, 3), 'b');
ylim(yPlotRange)
grid on

%% seperate plots actually clipped
clf

subplot(221)
plot(clippingClipped(size(clippingClipped,1)/2, :, 1), 'r');
ylim(yPlotRange)
grid on

subplot(222)
plot(clippingClipped(size(clippingClipped,1)/2, :, 2), 'g')
ylim(yPlotRange)
grid on

subplot(223)
plot(clippingClipped(size(clippingClipped,1)/2, :, 3), 'b');
ylim(yPlotRange)
grid on

%% surface plot
clf
mesh(clipping(:,:,1)); zlim(yPlotRange);
%%
clf
mesh(clippingClipped(:,:,1)); zlim(yPlotRange);

%% === DISCOLORING ===


%% === GRADIENT DISCREPANCY ===
clf
% Use gradtest to see it
gradDiscrep = eq1Upscale(im, scaleFactor);
imshow(gradDiscrep);

%%
clf
plot(gradDiscrep(size(gradDiscrep,1)/2, :, 1), 'r');

%%
clf
mesh(gradDiscrep(:,:,1));








