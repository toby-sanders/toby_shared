function out = myPSNR(Iref,Irec,maxI)

% evaluate the PSNR between the reference image, Iref, and the
% reconstructed image, Irec
% maxI is the maximum allowed valued in the image, typically 1 or 255

if nargin<3
    maxI = max(Iref(:));
end

MSE = sum((Iref(:)-Irec(:)).^2)/numel(Iref);
out = 10*log10(maxI^2/MSE);