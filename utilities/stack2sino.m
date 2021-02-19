function bb = stack2sino(stack)

% Written by Toby Sanders @ASU
% School of Math & Stat Sciences
% 06/18/2017

[m,n,k] = size(stack);
bb = zeros(m,k,n);

for i = 1:n
    bb(:,:,i) = squeeze(stack(:,i,:));
end
