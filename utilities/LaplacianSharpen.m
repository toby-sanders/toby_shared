function [x,y] = LaplacianSharpen(x,scl)

% apply Laplacian HPF to image x and add to the image to sharpen the edges
% Inputs: 
%   x - original image
%   scl - scaling factor for adding in the HPF image
% Output the sharpened image x, and the HPF image y

if nargin<2, scl = 1; end
T = [0 -1 0; -1 4 -1; 0 -1 0]; % negative laplacian operator
y = imfilter(x,T,'replicate');
x = x + scl*y;
