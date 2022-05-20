clear
addpath('./../ext/fig-utils') % showmethefigs
addpath('./ogniewski')

%%
%im = im2double(imread('./../data/jens/vikings_baelog_input.png'));
im = loadTestImage();

%%
alphas = getCValues(im);
visualizeAlpha(alphas);

%% testing different implementations
normalAlpha = getCValues(im);
alteredAlpha = alteredGetCValues(im);
diff = abs(normalAlpha - alteredAlpha);
min(diff(:))
max(diff(:))

visualizeAlpha(diff);

%%
diff = alteredAlpha - normalAlpha;
imagesc(diff(:,:,2));
colorbar;
%%
visualizeAlpha(alteredAlpha)
%%
visualizeAlpha(normalAlpha)
%%
function visualizeAlpha(alphas)
    rgb = 2 * cat(3, alphas, alphas(:,:,1));
    imshow(rgb);
end