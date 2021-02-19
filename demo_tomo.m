% demo for simulating tomographic reconstruction using this package
%
% Written by Toby Sanders @ASU
% School of Math & Stat Sciences
% 05/17/2016

clear;
n = 256;  % image dimension
angles = -75:5:75;  % projection angles for tomography
SNR = 5;

P = phantom(n);  % generate shepp logan phantom
r = radon(P,-angles); %generate radon data using matlab's radon
scale = size(r,1)/n; % scaling needed to generate data matrix
bb = r(:);  %stack the data as a data vector bb
bb = add_Wnoise(bb,SNR); % add noise
W = radonmatrix(angles,n,size(r,1),scale); % generate sparse tomography matrix


clear pat;  % clear options

% set the desired options into the pat structure for the HOTV code
% for a description of each option, read through check_HOTV_opts
pat.order = 1;
pat.iter = 200;
pat.mu = 250;
pat.disp=true;
pat.nonneg=true;
pat.L1type = 'isotropic';

% run HOTV code 
[U,~] = HOTV3D(W,bb,[n,n,1],pat);
% higher order
pat.order = 3;
[U5,~] = HOTV3D(W,bb,[n,n,1],pat);
% multiscale approach
pat.levels = 3;
[U7,~] = HOTV3D(W,bb,[n,n,1],pat);

%% compare with least squares (solved using CGLS)
U2 = run_cgs(W,bb,1e-5,50);
U2 = reshape(U2,n,n);


% compare with algebraic technique using nonnegativity
% (basically just gradient decent)
[U3,~] = SIRT(bb,W,n,100,0);

%% compare with Tikhonov regularized solution
opts.order = 3;
opts.mu = 1;
opts.iter = 150;
opts.tol = 1e-5;
ops.scale_A = true;
opts.scale_b = true;
opts.nonneg = true;
[U4,~] = Tikhonov(W,bb,[n,n,1],opts);

% compare with filtered backprojection
U6 = iradon(reshape(bb,size(r,1),size(r,2)),-angles);

%% display results
figure(1);
subplot(2,3,1);imagesc(U,[0 1]);colormap(gray);title('TV');
subplot(2,3,2);imagesc(U5,[0 1]);colormap(gray);title('HOTV3');
subplot(2,3,3);imagesc(U7,[0 1]);colormap(gray);title('MHOTV3');
subplot(2,3,4);imagesc(U3,[0 1]);colormap(gray);title('SIRT');
subplot(2,3,5);imagesc(U4,[0 1]);colormap(gray);title(['Tikhonov, order ',num2str(opts.order)]);
subplot(2,3,6);imagesc(U6,[0 1]);colormap(gray);title('Filerted Backprojection');
colormap(pink);

figure(2);
subplot(2,1,1);imagesc(P,[0 1]);colormap(gray);title('phantom');
subplot(2,1,2);imagesc(angles,size(r,1),reshape(bb,size(r,1),size(r,2)));
colormap(gray);title('noisy sinogram');
xlabel('angle');
colormap(pink);
