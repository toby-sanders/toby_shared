function y = fft_partial_dims(x,mode,N1,N2,ind)

switch mode
    case 1
        x = reshape(x,N1);
        y = fftn(x,N2);
        y = col(y(ind));
    case 2
        y = zeros(N2);
        y(ind) = x;
        y = prod(N2)*ifftn(y);
        y = col(y(1:N1(1),1:N1(2),1:N1(3)));
        % y = prod(N2)*col(ifftn(y)); 
end

