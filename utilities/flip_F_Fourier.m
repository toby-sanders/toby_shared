function F = flip_F_Fourier(F)

[m,n] = size(F);
if m~=n, error('this is set up for square domains only');end

F(1) = real(F(1));
F(n/2+1,n/2+1) = real(F(n/2+1,n/2+1));
F(1,n/2+1) = real(F(1,n/2+1));
F(n/2+1,1) = real(F(1,n/2+1));

% main flip
F(2:end,n/2+2:end) = conj(fliplr(flipud(F(2:end,2:n/2))));

% small flips
F(n/2+2:end,1) = conj(flipud(F(2:n/2,1)));
F(1,n/2+2:end) = conj(fliplr(F(1,2:n/2)));
% F(n/2+1,n/2+2:end) = conj(fliplr(F(n/2+1,2:n/2)));
F(n/2+2:end,n/2+1) = conj(flipud(F(2:n/2,n/2+1)));
