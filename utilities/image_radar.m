function [] = image_radar(X,dyn_range,scene_range)

% Written by Toby Sanders @ASU
% School of Math & Stat Sciences
% 02/26/2016

%for displaying radar imagery in db (20*log10) scale
if ~exist('dyn_range','var')
    dyn_range = 70;
end
if ~exist('scene_range','var')
    scene_range = 10;
end

s = scene_range/2;
xvec = linspace(-s,s,size(X,2));
yvec = linspace(-s,s,size(X,1));
%figure
imagesc(xvec,yvec,20*log10(abs((X))./...
    max(max(abs(X)))),[-dyn_range 0]);
% axis xy image;
set(gca,'XTick',linspace(-s,s,5),'YTick',linspace(-s,s,5));
h = xlabel('x (m)');
set(h,'FontSize',10,'FontWeight','Bold');
h = ylabel('y (m)');
set(h,'FontSize',10,'FontWeight','Bold');
set(gca,'FontSize',10,'FontWeight','Bold');
colormap gray
colorbar
