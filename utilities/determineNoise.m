function [sigma,FI] = determineNoise(I,pad)

% this code is a very accurate way to determine the noise levels in images
% for deconvolution.  This idea is that the blurry image is low pass
% filtered, so the only thing left near the end of the spectrum is the
% noise.  Make sure to add a pad to the edge of the image to avoid and
% "edge."  

% written by Toby Sanders @Lickenbrock Tech.
% 1/16/2020

if nargin < 2
    pad = 30;
end
[d10,d20,d3] = size(I);
if d3>1, error('input should be 2D image'); end
I = padEdges(I,pad); % pad image
[d1,d2] = size(I);

% average the square magnitude of the unitary FT of the rows and columns
% FIx = mean(abs(fft(I,d2,2)).^2,1)/d2;
% FIy = mean(abs(fft(I,d1,1)).^2,2)/d1;
FI = abs(fft2(I)).^2/d10/d20;

width2 = round(d2/6);
width1 = round(d1/6);
sigma = sqrt(mean(mean(FI(round(d1/2)-width1:round(d1/2)+width1,round(d2/2)-width2:round(d2/2)+width2))));
% sigma = sqrt(mean([FIx(round(d2/2)-width2:round(d2/2)+width2),FIy(round(d1/2)-width1:round(d1/2)+width1)']));



