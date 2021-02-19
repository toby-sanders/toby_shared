function h = constructHood(rx,ry,rz)

xx = linspace(-rx+1/2,rx-1/2,2*rx);
yy = linspace(-ry+1/2,ry-1/2,2*ry);
zz = linspace(-rz+1/2,rz-1/2,2*rz);
[X,Y,Z] = meshgrid(xx,yy,zz);
h = X.^2/rx^2 + Y.^2/ry^2 + Z.^2/rz^2;
h = h<=1;
