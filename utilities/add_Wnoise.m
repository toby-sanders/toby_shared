function [b,sigma] = add_Wnoise(b,SNR)


% add Gaussian white noise to a data vector b, with speicified SNR

% Written by Toby Sanders @ASU
% School of Math & Stat Sciences
% 11/1/2018

sigma = mean(abs(b(:)))/SNR;
[x,y,z,w] = size(b);b = b(:);
if isreal(b)
    b = b+randn(numel(b),1)*sigma;
else
    b = b+exp(1i*2*pi*rand(numel(b),1))...
            .*randn(numel(b),1)*sigma;
end
b = reshape(b,x,y,z,w);