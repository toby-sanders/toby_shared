function [U,out] = inpaint_3D_shear(bb,S,d,opts)



% Written by Toby Sanders @ASU
% School of Math & Stat Sciences
% 09/22/2016



if numel(d)<3
    d(end+1:3) = 1;
elseif numel(d)>3
    error('n can have at most 3 dimensions');
end
%p = d(1);q = d(2); r = d(3);

if size(S,2)==3
    S = sub2ind(d,S(:,1),S(:,2),S(:,3));
end

if numel(S)~=numel(bb)
    error('number of data points and specified indices dont match');
end


shear_sys = SLgetShearletSystem2D(0,d(1),d(2),4);

A = @(x,mode)subdata_select(x,mode,S,d);

opts.D = @(x)shearlet_transform(x,shear_sys,1);
opts.Dt = @(x)shearlet_transform(x,shear_sys,2);
[U,out] = l1optimo(A,bb,d,opts);








function x = subdata_select(x,mode,S,d)

switch mode
    case 1
        x = x(S);
    case 2
        y = zeros(d);
        y(S) = x;
        x = y(:);
end