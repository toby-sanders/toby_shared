function polarOut = CartesianToPolarTransform(cartIn, offsets, scales)

% Assumes square image
[M1, M2] = size(cartIn);

N = ceil(M1/2);

fwdtfm  = @(U,T) [sqrt(U(:,1).^2 + U(:,2).^2) atan2(U(:,2),U(:,1))];
invtfm  = @(X,T) [X(:,1).*cos(X(:,2)) X(:,1).*sin(X(:,2))];
T       = maketform('custom',2,2,fwdtfm,invtfm,[]);

polarOut = imtransform(cartIn,T,'udata',[-N N] + offsets(1),'vdata',[-N N] + offsets(2),'size',ceil([N/scales(2) N/scales(2)]/scales(1)),'xdata',[0 ceil(N/scales(1))],'ydata',[-pi pi]);