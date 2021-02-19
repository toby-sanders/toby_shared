function x = rand_func_gen(d,k,dist_type)

% function to draw a random function from the probability distribution
% function 
% d: dimension of signal
% k: order of the pdf cov. matrix
% dist_type: 'gauss' or 'laplace' distribution

% THIS VERSION USES BOUNDARY CONDITIONS/ BNDRY REGULARITY

% Written by Toby Sanders @ASU
% School of Math & Stat Sciences
% 07/18/2018

if nargin<2
    dist_type = 'gauss';
    k = 1;
elseif nargin<3
    dist_type = 'gauss';
elseif ~sum(strcmp(dist_type,{'gauss','laplace','uniform'}))
    error('prob. distr. not recogized, set to "gauss" or "laplace"');
end

% generate coefficients from PDF
if strcmp(dist_type,'gauss')
    r = randn(d,1);
elseif strcmp(dist_type,'laplace')
    r = log(rand(d,1)./rand(d,1));
elseif strcmp(dist_type,'uniform')
    r = rand(d,1)-1/2;
end

v = exp(-1i*2*pi*(0:d-1)/d)-1;  % e.values of D_k
v = v.^k; v = v';
iv = 1./v; % inverse e.values used for pseudo det
iv(1) = 0; % choose any value for first e.value inverse (0)
% P.inv. of D_k is D_k^+ = F^-1 Lambda^+ F
x = real(2^(k-1)*ifft(iv.*fft(r)));

end