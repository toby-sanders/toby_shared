% demo for image deconvolution
%
% Written by Toby Sanders @Lickenbrock Tech. 
% 10-15-2020

clear;
d = 512; % image dimension
omega = 2; % standard deviation of Gaussian blurring kernel
SNR = 30; % snr of data
order = 2; % hotv order 
levels = 1; % number of levels

% get original image and blur and add noise
x = im2double(rgb2gray(imread('peppers2.png')));
[h,hhat] = makeGausPSF(d,omega);
b = ifft2(fft2(x).*hhat);
b = add_Wnoise(b,SNR);

% set hotv options
opts.mode = 'deconv'; % set mode to deconvolution
opts.mu = 2500;
opts.iter = 150;
opts.nonneg = true;
opts.order = 1;
opts.levels = 1;
opts.automateMu = true; % option to automate parameter selection

% perform reconstructions
[recTV,out] = HOTV3D(h,b,[d,d,1],opts);
opts.order = order;
opts.levels = levels;
[recH,out] = HOTV3D(h,b,[d,d,1],opts);

% display results
figure(234);colormap(gray);
subplot(2,2,1);imagesc(x,[0 1]);title('original');
subplot(2,2,2);imagesc(b,[0 1]);title('blurred noisy');
subplot(2,2,3);imagesc(recTV,[0 1]);title('TV deblurred');
subplot(2,2,4);imagesc(recH,[0 1]);title('MHOTV deblurred');