% a simple demo for using Tikhonov regularization

d = 500; % signal dimension
m = 300; % number of samples
SNR = 5;    % SNR, with mean zero i.i.d. Gaussian noise

% generate a simple test signal
x = sin(3*pi*linspace(0,1,d)');
A = randn(m,d); % random sampling matrix

% generate samples and add noise
b = A*x;
b = b + randn(m,1)*mean(abs(b))/SNR;

% algorithm parameters
tik.mu = 1/5; % regularization balancing parameter
tik.order = 1;  % order of the finite differencing scheme
tik.iter = 150; % maximum number of iterations
tik.tol = 1e-6; % convergence tolerance

% compute solution
[rec,out] = Tikhonov(A,b,[d,1,1],tik);
tik.order = 2;
[rec2,out2] = Tikhonov(A,b,[d,1,1],tik);

% display
figure(53);hold off;
plot(x,'linewidth',2);hold on;
plot(rec,'linewidth',2);
plot(rec2,'linewidth',2);
legend({'true','recovered k = 1','recovered, k = 2'});
