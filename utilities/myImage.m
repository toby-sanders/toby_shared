function [minV,maxV] = myImage(I,p)

% display an image in grayscale with small contrast adjustment
% p is the percentage used for the contrast adjustment
if nargin<2, p = .01; end

if numel(p)==1, p = ones(2,1)*p; end

N = numel(I);
S = sort(I(:));
minV = S(round(p(1)*N)+1);
maxV = S(round((1-p(2))*N));
if minV == maxV
    imagesc(I);
else
    imagesc(I,[minV,maxV]);
end
colormap(gray);colorbar;