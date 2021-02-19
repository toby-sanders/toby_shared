function I = padEdges(I,r)

% pad an image I by interpolating and "rolling off the sides" with a radius
% r.  This padding alleviates artifacts that can occur when deblurring real
% world images where edges do not match.

if nargin<2, r = 30; end
p= size(I,1);
q = size(I,2);
z = size(I,3);

I = cat(1,I,zeros(r,q,z));
I = cat(2,I,zeros(p+r,r,z));

for j = 1:z
    for i = 1:p
        interp1 = linspace(I(i,q,j),I(i,1,j),r);
        I(i,q+1:end,j) = interp1;
    end


    for i = 1:q+r
        interp1 = linspace(I(p,i,j),I(1,i,j),r);
        I(p+1:end,i,j) = interp1;
    end
end