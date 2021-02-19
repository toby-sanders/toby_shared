function [A,x,b,sigma] = my_1D_examples(SNR,n,m,example)

% I've built these examples enough that it should be its own function.
% Here it is.  Input the SNR, the length of the signal (n), and the number
% of samples (m), and which signal to generate.  The function outputs the
% sampling matrix A (mxn), the signal x, the data vector b, and the
% standard deviation of the noise (sigma)

if nargin<2, error('must have at least 2 inputs');
elseif nargin==2, m=n; example = 'sine'; % default example
elseif nargin==3, example = 'sine';
elseif ~sum(strcmp(example,{'boxcar','hat','sine','pwquad'}))
    error('example signal not recognized');
end

% signal
x = zeros(n,1);
switch example
case 'boxcar'
  x(n/4:3*n/4) = 1;
case 'hat'
  x = 1 - 2*abs(linspace(0,1,n)' - 0.5);
case 'sine'
  x = sin(2*pi*linspace(0,1,n))'; m = ceil(n/4);
case 'pwquad'
  x = zeros(n,1);
  x(round(n/6):round(n/6+n/4)) = ...
    2-linspace(-sqrt(2),sqrt(2),numel(round(n/6):round(n/6+n/4))).^2;
  x(round(n/2):round(n/2+n/6)) = 1;
  x(round(n/2+n/6):round(n/2+n/3)) = ...
    linspace(1,0,numel(round(n/2+n/6):round(n/2+n/3)));
end

A = randn(m,n);
b = A*x;
sigma = mean(abs(b))/SNR;
b = b + randn(numel(b),1)*mean(abs(b))/SNR;
    
    