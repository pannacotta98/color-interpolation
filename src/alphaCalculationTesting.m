clear
addpath('./../ext/fig-utils') % showmethefigs
addpath('./ogniewski')

%%
%im = im2double(imread('./../data/jens/vikings_baelog_input.png'));
im = loadTestImage();

%%
alphas = getCValues(im);
visualizeAlpha(alphas);

function visualizeAlpha(alphas)
    rgb = 2 * cat(3, alphas, alphas(:,:,1));
    imshow(rgb);
end