function y = fft_partial_transforms(x,mode,N,ind)


switch mode
    case 1
        x = reshape(x,N);
        y = fftn(x);
        y = col(y(ind));
    case 2
        y = zeros(N);
        y(ind) = x;
        y = prod(N)*col(ifftn(y));
end

