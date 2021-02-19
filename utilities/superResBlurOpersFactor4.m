function x = superResBlurOpers(x,mode,p,q,ghat)

switch mode
    case 1
        x = reshape(x,p,q);
        x = ifft2(fft2(x).*ghat);
        x = x(1:2:end,1:2:end);
        x = x(:);
    case 2
        x = reshape(x,p/2,q/2);
        y = zeros(p,q);
        y(1:2:end,1:2:end) = x;
        x = ifft2(fft2(y).*conj(ghat));
        x = x(:);
end