function [sigma,sigmas] = determineNoise(I,pad)

% determine the noise level, sigma, for an input image I
% loop over patches of the image of size "subSize" and determine for each
% patch using spectrum analysis

% written by Toby Sanders @Lickenbrock Tech.
% 11/21/2019

if nargin < 2
    pad = 30;
end
subSize = 100;

[d1,d2,d3] = size(I);
if d3>1, error('input should be 2D image'); end
sigmas = [];

% loop over subimages and determine sigmas
for i = pad:subSize/2:d1-pad-subSize
    for j = pad:subSize/2:d2-pad-subSize
        % unitary FFT of columns and find maximum near end of spectrum
        subImage = I(i+1:i+subSize,j+1:j+subSize);
        FI = mean(abs(fft(subImage)),2)/sqrt(subSize); 
        sigmas = [sigmas;max(FI(subSize/2-10:subSize/2+10))];
    end
end
sigma = median(sigmas); % take the median sigma
