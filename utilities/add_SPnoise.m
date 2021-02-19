function [b,pp,sigma] = add_SPnoise(b,SNR)


% add salt and pepper noise to a data vector b, with specified SNR

% Written by Toby Sanders @Lickenbrock Tech
% School of Math & Stat Sciences
% 3/24/2020

sigma = mean(abs(b(:)))/SNR;
pp = 1/SNR;
maxV = max(abs(b(:)));
minV = min(abs(b(:)));
[x,y,z] = size(b);b = b(:);
r = rand(numel(b),1);
[~,r] = sort(r);
S1 = r(1:round(numel(b)*pp/2));
S2 = r(round(numel(b)*pp/2)+1:round(numel(b)*pp));
if isreal(b)
    b(S1) = minV;
    b(S2) = maxV;
else
%     b = b+exp(1i*2*pi*rand(numel(b),1))...
%             .*randn(numel(b),1)*sigma;
    error('this code is not set up for complex data');
end
b = reshape(b,x,y,z);