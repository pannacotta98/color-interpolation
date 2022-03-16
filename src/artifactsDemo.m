%% Demonstration of artifacts that can occur when interpolating color
clear
addpath('./ogniewski/')
addpath('./../ext/fig-utils') % showmethefigs
addpath('./../ext/matlab2tikz/src');
im = loadTestImage();
scaleFactor = 30;

%% === ORIG NEAREST ===
near = imresize(im, scaleFactor, 'nearest');
imshow(near)

%% === STEP IMG ===
im = 0.2 .* ones(4, 32);
im(:,1:16) = 0.8;

%%
im = 0.3 .* ones(4, 10);
im(:,1:5) = 0.7;

%% === RINGING 1 ===
clf
ringing = imresize(im, scaleFactor, {@(x) lanczos(x,5), 10});
imshow(ringing);
disp(['Max value in ringing image: ', num2str(max(ringing, [], 'all'))]);
disp(['Min value in ringing image: ', num2str(min(ringing, [], 'all'))]);

%%
clf
yPlotRange = [0; 1];
plot(near(size(near,1)/2, :, 1), 'r'); ylim(yPlotRange)
hold on
plot(ringing(size(ringing,1)/2, :, 1), 'b'); ylim(yPlotRange)
grid on
hold off

%% ?
clf
ringing = imresize(im, scaleFactor, {@(x) lanczos(x,5), 10});
subplot(311)
imshow(ringing);
title('Ringing')

subplot(313)
imshow(im);
title('Original')

subplot(312)
yPlotRange = [0; 1];
plot(near(size(near,1)/2, :, 1), 'r'); ylim(yPlotRange)
hold on
plot(ringing(size(ringing,1)/2, :, 1), 'b'); ylim(yPlotRange)
xlim('tight')
%grid on
hold off



%% === RINGING 2 ===
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

%%
imwrite(clipping, './../output/clipping.png');

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

%% only one channel
plot(clipping(size(clipping,1)/2, :, 3), 'b');
ylim(yPlotRange)
ylabel('Pixel intensity')
xlabel('Horizontal pixel position')
grid on

%%
plot(clippingClipped(size(clippingClipped,1)/2, :, 3), 'b');
ylim(yPlotRange)
ylabel('Pixel intensity')
xlabel('Horizontal pixel position')
grid on

%% surface plot
clf
mesh(clipping(:,:,1)); zlim(yPlotRange);
%%
clf
mesh(clippingClipped(:,:,1)); zlim(yPlotRange);

%% === DISCOLORING ===
clf
discoloring = imresize(im, scaleFactor, 'lanczos3');
imshow(discoloring);

%%
imwrite(discoloring, './../output/discoloring.png');

%% === GRADIENT DISCREPANCY ===
clf
% Use gradtest to see it
gradDiscSrc = zeros(2,6,3);
for x = 1:size(gradDiscSrc, 2)
    gradDiscSrc(:,x,:) = (x-1) * 1/(size(gradDiscSrc,2)-1) * 0.98;
end
gradDiscrep = eq1Upscale(gradDiscSrc, scaleFactor);
imshow(gradDiscrep);

%%
clf
imshow(imresize(gradDiscSrc,scaleFactor, 'nearest'));

%%
clf
imshow(imresize(gradDiscSrc,scaleFactor, 'bilinear'));

%%
clf
plot(gradDiscrep(size(gradDiscrep,1)/2, :, 1), 'r');

%%
clf
mesh(gradDiscrep(:,:,1));

%% Custom filters
function f = lanczos(x,a)
f = a*sin(pi*x) .* sin(pi*x/a) ./ ...
    (pi^2 * x.^2);
f(abs(x) > a) = 0;
f(x == 0) = 1;
end









