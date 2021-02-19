function I = specialSharpen(I,alpha)

I = I/max(I(:));
% parameters for histogram equalization
tileSize = 8;
stretchTol = 0.00;
nBins = 7;
Clim = -4;
I = fun_CIT2(I,stretchTol,tileSize,Clim,nBins);
I = I/max(I(:));

if nargin<2, alpha = 2; end
T = [0 -1 0; -1 4 -1; 0 -1 0]; % negative laplacian operator
I = I + alpha*imfilter(I,T,'replicate');

filt = 1 + alpha*abs(fft2(T,size(I,1),size(I,2)));
sigma = 2;
sigmaPSD = (sigma)^2*abs(filt).^2;
I = BM3D(I,sigmaPSD);
