function [] = imageBasic(I,maxP,figNum)

% convenient code for adjusting contrast imaging 
% maxP is the maximum contrast value as a fraction 0<maxP<=1
% figNum is the figure number

if nargin<2, maxP = 1; end
if nargin==3, figure(figNum); end

I = I-min(I(:));
imagesc(I/max(I(:)),[0 maxP]);
    