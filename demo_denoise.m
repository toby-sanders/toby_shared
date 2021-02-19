% demo for basic image denoising for RGB image
%
% Written by Toby Sanders @ASU
% School of Math and Stat Sciences
% 06/14/2017
d = 500;
SNR = 10; % noise level

% read image and add noise
X = im2double(imread('surfer.jpg'));
X = imresize(X,[d,d]);
[m,n,k] = size(X);
Xn = add_Wnoise(X,SNR);

% L1 optimization options
opts.nonneg = true;
opts.mu = 15;
opts.iter = 150;
opts.tol = 1e-4;
opts.disp = false;
opts.order = 2;
opts.mode = 'deconv'; % treat denoising like a special case of deconvolution
opts.automateMu = false; % automate parameter selection

% construct blurring kernel, in this case just a delta
h = zeros(m,n);
h(1) = 1;

% reconstruct with order 1 (TV) and order 2 (HOTV)
rec1 = zeros(m,n,k);
rec2 = zeros(m,n,k);
for i = 1:k
    opts.order = 1;
    opts.levels = 1;
    rec1(:,:,i) = HOTV3D(h,Xn(:,:,i),[m,n,1],opts);
    opts.order = 2;
    opts.levels = 3;
    rec2(:,:,i) = HOTV3D(h,Xn(:,:,i),[m,n,1],opts);
end
%% display results
figure(44);
subplot(2,2,1);imagesc(X);title('original')
subplot(2,2,2);imagesc(Xn);title('noisy');
subplot(2,2,3);imagesc(rec1);title('TV denoised');
subplot(2,2,4);imagesc(rec2);title('MHOTV denoised');