function U = MHOTVfunctionDer(U,k,levels)


% this code computes the functional derivative for multiscale higher order
% total variation (MHOTV) operators 
% k is the order of the transform
% levels is the number of scales used for the FD transforms
% recommended 3 levels
%
% Written by Toby Sanders @Lickenbrock Tech.
% 09/19/2019

epDenom = 1e-1; % padding for division
p = size(U,1); q = size(U,2);
tic;
l = 0:levels-1; l = 2.^l;
VX = zeros(p,q,levels); VY = VX; 
for ii = 1:levels % wavelet like filters
    vx = (-1)^k*[0,1/l(ii)*((exp(-1i*2*pi*(1:q-1)*l(ii)/q)-1).^(k+1))./(exp(-1i*2*pi*(1:q-1)/q)-1)];
    vy = (-1)^k*[0,1/l(ii)*((exp(-1i*2*pi*(1:p-1)*l(ii)/p)-1).^(k+1))./(exp(-1i*2*pi*(1:p-1)/p)-1)];
    [VX(:,:,ii),VY(:,:,ii)] = meshgrid(vx,vy);
end
toc;

% Transform data into frequency domain along each dimension
% and allocate FD matrices for storage
X = fft(U,q,2).*VX; % no need to loop
Y = fft(U,p,1).*VY;
X = 2^(1-k)/levels*ifft(X,q,2); % transform back to real space
Y = 2^(1-k)/levels*ifft(Y,p,1);

% "normalization" step
AbsGrads = sqrt(X.^2 + Y.^2) + epDenom;
X = X./AbsGrads;
Y = Y./AbsGrads;

% transpose operation
% conjugate filtering for each level and dimension
X = fft(X,q,2).*conj(VX); 
Y = fft(Y,p,1).*conj(VY);
X = ifft(X,q,2); % transform filtered data back to real space
Y = ifft(Y,p,1);

% finish transpose operation by summing
U = real(sum(X+Y,3))*2^(1-k)/levels;

        

    
    
    
    