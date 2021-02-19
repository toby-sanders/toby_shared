function x = superResBlurOpers(x,mode,p,q,ghat)

switch mode
    case 1
        x = reshape(x,p,q);
        x = ifft2(fft2(x).*ghat);
        x = x(2:3:end,2:3:end);
        x = x(:);
    case 2
        x = reshape(x,p/3,q/3);
        y = zeros(p,q);
        y(2:3:end,2:3:end) = x;
        x = ifft2(fft2(y).*conj(ghat));
        x = x(:);
end