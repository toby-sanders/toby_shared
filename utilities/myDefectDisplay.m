function [RGB] = myDefectDisplay(I,S,mm0,mm1)

% overlay defects locations onto original image (I)
% S is a binary indicating defect locations
% 0<=mm0<mm1<=1, can be used to adjust the constract

if nargin<2, error('not enough inputs');
elseif nargin<4, mm0 = 0;mm1 = 1; end
if numel(find(S==0)) + numel(find(S)==1) ~= numel(S)
    error('S should be binary');
end
if mm0>mm1, error('mm0 should be less than mm1');
elseif mm0<0 || mm1>1, errors('mm0 and mm1 should be between 0 and 1');end

% dilate the defects, S
S2 = imfilter(double(S),ones(5),'replicate');
S2 = logical(S2);
% find the edges of the dilated image by taking gradient
[Ix,Iy] = gradient(S2);
G = Ix+Iy;
% G = edge(S2,'sobel');
G = find(G);

% put image and edge set into RGB map
RGB = repmat(I./max(I(:)),1,1,3);
RGB = max(min(RGB,mm1),mm0);
[d1,d2] = size(I);
RGB = reshape(RGB,d1*d2,3);

RGB(G,1) = 0;RGB(G,2) = mm1;RGB(G,3) = 0;
RGB = reshape(RGB,d1,d2,3)/mm1;
% figure(101);
% imagesc(RGB/mm1);
