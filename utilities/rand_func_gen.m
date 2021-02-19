function x = rand_func_gen(d,k,dist_type)

% function to draw a random function from the probability distribution
% function 
% d: dimension of signal
% k: order of the pdf cov. matrix
% dist_type: 'gauss' or 'laplace' distribution

% Written by Toby Sanders @ASU
% School of Math & Stat Sciences
% 02/4/2018

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
% we can invert just using cumsum below
% % finite difference matrix with initial condition
% D = zeros(d);
% D(1) = 1;
% D(2:d+1:end) = - 1;
% D(d+2:d+1:end) = 1;
% Dk = D^k; % order k differences
% 
% % invert coefficients
% % x2 = Dk\r;
x = r;
for i = 1:k
    x = cumsum(x);
end
xd = cumsum(r);
x = x*2^(k-1);

% x = x/max(abs(x));
% figure(99);hold off;
% plot(x);hold on;
% plot(r/max(abs(r)),':');
% plot(xd/max(abs(xd)));
% legend('function','coefficients','first order function');
% hold off;

end