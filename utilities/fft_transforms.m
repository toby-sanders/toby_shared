function y = fft_transforms(x,mode,N)


switch mode
    case 1
        x = reshape(x,N);
        y = fftn(x);
        y = y(:);
    case 2
        x = reshape(x,N);
        y = ifftn(x);
        y = y(:)*prod(N);
end
