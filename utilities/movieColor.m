function [] = movieColor(stacks,cycles)


%MOVIESTACK and MOVIESTACKG

%DESCRIPTION:
    %these functions are for 2D visualizations of 3D volumes.  They will
    %scroll through orthogonal slices of an input 3D volume.
    
%NOTATION:
    %moviestack(stack,cycles,direction,map)
    
%INPUTS:
    %stack - 3D volume to be visualized
    %cycles - number of cycles through the volume.  Default is 10.
    %direction - specifies the direction which to scroll through the
        %volume.  Set to either 1, 2, or 3.  1 will scroll through the z
        %direction, 2 will scroll through the x direction and 3 will scroll
        %through the y direction.  Default is 1.
    %map - a string input specifying the colormap.  Some of the best are
    %'gray', 'jet', 'hot', and 'bone'.  Default is 'gray'.
    
    
% Written by: Toby Sanders @ LickenbrockTech INC.
% last update: 02/20/2020

if nargin<2, cycles = 10; end

if isa(stacks,'double') || isa(stacks,'single')
    scl = max(stacks(:));
else
    scl = max(stacks(:))/255;
end

for i = 1:cycles
    if mod(i,2)==1
        for j = 1:size(stacks,3)
            figure(1);imagesc(stacks(:,:,:,j)/scl);colorbar;
            title(j);pause;
        end
    else
        for j = size(stacks,3):-1:1
            figure(1);imagesc(stacks(:,:,:,j)/scl);colorbar;
            title(j);pause;
        end
    end
end