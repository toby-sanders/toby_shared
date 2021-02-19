function [x,y] = LaplacianSharpen3D(x,scl)

% apply Laplacian HPF to image x and add to the image to sharpen the edges
% Inputs: 
%   x - original image
%   scl - scaling factor for adding in the HPF image
% Output the sharpened image x, and the HPF image y

if nargin<2, scl = 1; end
if size(x,3)<2, error('input must be 3D'); end
% T = [0 -1 0; -1 4 -1; 0 -1 0]; % negative laplacian operator
T = zeros(3,3,3);
T(2,2,1) = -1;
T(2,2,3) = -1;
T(:,:,2) = [0 -1 0; -1 6 -1; 0 -1 0];
y = imfilter(x,T,'replicate');
x = x + scl*y;
