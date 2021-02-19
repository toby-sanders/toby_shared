function I = padEdgesColorIm(I,r)

% pad an image I by interpolating and "rolling off the sides" with a radius
% r.  This padding alleviates artifacts that can occur when deblurring real
% world images where edges do not match.

if nargin<2, r = 30; end
p= size(I,1);
q = size(I,2);
C = size(I,3);
z = size(I,4);

I = cat(1,I,zeros(r,q,C,z));
I = cat(2,I,zeros(p+r,r,C,z));
for k = 1:C
    for j = 1:z
        for i = 1:p
            interp1 = linspace(I(i,q,k,j),I(i,1,k,j),r);
            I(i,q+1:end,j) = interp1;
        end


        for i = 1:q+r
            interp1 = linspace(I(p,i,k,j),I(1,i,k,j),r);
            I(p+1:end,i,k,j) = interp1;
        end
    end
end