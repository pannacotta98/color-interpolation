clear
clf
addpath('./../ext/matlab2tikz/src');

%%
x = 0:pi/100:2*pi;
y = sin(x);
plot(x,y)

matlab2tikz