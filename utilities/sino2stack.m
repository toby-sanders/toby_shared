function stack = sino2stack(sino)


% Written by Toby Sanders @ASU
% School of Math & Stat Sciences
% 06/18/2017


[m,n,k] = size(sino);
stack = zeros(m,k,n);
for i = 1:n
    stack(:,:,i) = squeeze(sino(:,i,:));
end
