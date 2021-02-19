function [h,hhat] = makeMotionBlur(n,L,theta)

% make a "one-dimensional" motion blur point spread function,
% it is assumed that the motion is constant over the exposure time,
% resulting in a binary PSF.
% INPUTS: 
% n is the image dimension
% L is the length of the bluring kernel
% theta is the angle of the motion

if numel(n)==1, d1 = n; d2 = n;
else d1 = n(1); d2 = n(2); 
end

h = zeros(d1,d2);
h(1,1:L) = 1;
h = circshift(h,[0 -floor(L/2)]);
h = ifftshift(imrotate(fftshift(h),theta,'crop'));
h = h/sum(h(:));
hhat = fft2(h);