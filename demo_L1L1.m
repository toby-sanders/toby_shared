% an example for 2D denoising from salt and pepper noisy
% compares l1-l1 model and l2-l1 model
% the l1-l1 model is signficantly better for handling salt and pepper noise


clear;
d = 500; % signal dimension
nerror = .5;    % percentage of corrupted data points
y = linspace(0,1,d)'; % grid points
mu = 2;  % regularization parameter

% test image
x = phantom(d);

% optimization parameters
clear pat;
pat.iter = 200;
pat.beta = 30;
pat.disp = true;
pat.nonneg = true;
pat.tol = 1e-5;
pat.isreal = true;
pat.mu = mu;
pat.order = 1;


b2 = x(:); % noisy samples

% add in salt and pepper like noise
nerror = round(d^2*nerror);
epsilon2 = randi(d^2,nerror,1);
b2(epsilon2) =  randi([0 1],nerror,1);%(rand(nerror,1)-1/2)*max(b2);


% denoising 
pat.mu = mu;
[rec,out] = HOTV3D_L1L1(speye(d^2),b2,[d,d,1],pat); % l1-l1
pat.mu = mu*2;
[rec2,out2] = HOTV3D(speye(d^2),b2,[d,d,1],pat); % l2-l1

% relative errors
e1 = norm(rec(:)-x(:))/norm(x(:));
e2 = norm(rec2(:)-x(:))/norm(x(:));
% display
%%
figure(30);
subplot(2,2,1);
imagesc(x,[0 1]);title('true');colormap(gray);
subplot(2,2,2);
imagesc(reshape(b2,d,d),[0 1]);title('noisy, salt and pepper');colormap(gray);
subplot(2,2,3);
imagesc(rec,[0 1]);title(['l1-l1 denoised, error =',num2str(e1)]);colormap(gray);
subplot(2,2,4);
imagesc(rec2,[0 1]);title(['l2-l1 denoised, error =',num2str(e2)]);colormap(gray);

