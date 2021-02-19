function I = myImCompile(A,d,n,buff)

% This code is written to compile a series of images into a cube of size
% nxn for demonstration purpose.  The cube can be either a 3D stack of
% images or a series of images concatenated along the x-dimension (2nd
% dimension of the matrix)
% 
% Inputs: 
% A - images to be compiled
% d - image dimensions (necessary when data concatenated along x-dim)
% n - number of images along each direction of the compiled image
% buff - (buffer) number of pixels for spacing between the images
if numel(d)==1, d = d*ones(2,1); end
if numel(n)==1, n = n*ones(2,1); end
d1 = d(1); d2 = d(2);
n1 = n(1); n2 = n(2);
if size(A,3)~=1, A = reshape(A,d1,d2*size(A,3)); end

I = ones(d1*n1+buff*(n1-1),d2*n2+buff*(n2-1));
for i = 1:n1
    for j = 1:n2
        tmp = A(:,(i-1)*d2*n2+(j-1)*d2+1:j*d2+(i-1)*d2*n2);
        tmp = tmp./max(tmp(:));
        I((i-1)*d1+(i-1)*buff+1:i*d1+(i-1)*buff,(j-1)*d2+(j-1)*buff+1:j*d2+(j-1)*buff)...
            = tmp;
    end
end
