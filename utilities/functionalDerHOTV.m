function U = functionalDerHOTV(U, epDenom ,k)

% Written by Toby Sanders @ Lickenbrock technologies
% 7/15/2019

% Discretization of the Euler-Lagrange equations for TV and HOTV.
% For TV the EL equations are given by
%  -div(grad u /| grad u |) 
% In general, if we write the regularization as 
%    J[u] = \int sqrt( (h1*u)^2 + (h2*u)^2 ) dx dy 
% then the functional derivative is given by
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        tilde(h1) * (h1*u/sqrt( (h1*u)^2 + (h2*u)^2 )) 
%      + tilde(h2) * (h2*u/sqrt( (h1*u)^2 + (h2*u)^2 ))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% this code works for general HOTV, where k is the order
if nargin<3, k = 1; end
if k==0, U = sign(U); return; end
% if k==0, U = U./(abs(U) + epDenom); return; end

% forward differences/convolutions
Ux = myLocalFD2D(U,k,2,'forward'); % h1*u
Uy = myLocalFD2D(U,k,1,'forward'); % h2*u
AbsGrad = sqrt(Ux.^2 + Uy.^2) + epDenom;

% normalized gradient images
Ux = Ux./AbsGrad; % h1*u/sqrt( (h1*u)^2 + (h2*u)^2 )
Uy = Uy./AbsGrad; % h2*u/sqrt( (h1*u)^2 + (h2*u)^2 )

% output (k = 1): -div(grad u / | grad u |)
U = myLocalFD2D(Ux,k,2,'adjoint') + myLocalFD2D(Uy,k,1,'adjoint');


function U = myLocalFD2D(U,k,dim,type)

% forward differences/convolutions, h*u
if strcmp(type,'forward')
    if dim==1
        U = diff([U;U(1:k,:)],k,1);
    elseif dim==2
        U = diff([U,U(:,1:k)],k,2);
    end
elseif strcmp(type,'adjoint')
    % adjoint differences/convolutions, tilde(h)*u
    if dim==1
        U = (-1)^k*diff([U(end-k+1:end,:);U],k,1);
    elseif dim==2
        U = (-1)^k*diff([U(:,end-k+1:end),U],k,2);
    end     
end