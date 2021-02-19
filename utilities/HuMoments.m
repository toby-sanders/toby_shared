function out = HuMoments(I)

% computing Hu's 7 invariant moments "Hu moments", which are translation,
% scale, and rotationally invariant
% in doing so, we also obtain the ordinary moments (M's),
% and the translation invariant moments (mu's),
% and the scale invariant moments (eta's)

% Written by Toby Sanders
% @Lickenbrock Technologies

[m,n,k] = size(I);
M = sum(sum(I,1),2); % mass

% first compute centers of mass
x = linspace(-(n-1)/2,(n-1)/2,n); % x grid
y = linspace(-(m-1)/2,(m-1)/2,m); % y grid
[X,Y] = meshgrid(x,y); 
cx = sum(sum(X.*I,1),2)/M; % center of mass, x
cy = sum(sum(Y.*I,1),2)/M; % center of mass, y

% ordinary moments
out.M10 = cx.*M;
out.M01 = cy.*M;
out.M11 = sum(sum(X.*Y.*I));
out.M20 = sum(sum(X.^2.*I));
out.M02 = sum(sum(Y.^2.*I));
out.M21 = sum(sum(X.^2.*Y.*I));
out.M12 = sum(sum(X.*Y.^2.*I));
out.M30 = sum(sum(X.^3.*I));
out.M03 = sum(sum(Y.^3.*I));

% translation invariant moments (central moments)
out.mu00 = M;
out.mu11 = out.M11 - cx*out.M01;
out.mu20 = out.M20 - cx*out.M10;
out.mu02 = out.M02 - cy*out.M01;
out.mu21 = out.M21 - 2*cx*out.M11 - cy*out.M20 + 2*cx^2*out.M01;
out.mu12 = out.M12 - 2*cy*out.M11 - cx*out.M02 + 2*cy^2*out.M10;
out.mu30 = out.M30 - 3*cx*out.M20 + 2*cx^2*out.M10;
out.mu03 = out.M03 - 3*cy*out.M02 + 2*cy^2*out.M01;

% scale invariant moments
out.eta00 = 1;
out.eta11 = out.mu11/M^2;
out.eta20 = out.mu20/M^2;
out.eta02 = out.mu02/M^2;
out.eta21 = out.mu21/M^2.5;
out.eta12 = out.mu12/M^2.5;
out.eta30 = out.mu30/M^2.5;
out.eta03 = out.mu03/M^2.5;

% Hu moments (shift, scale, and rotationally invariant moments)
out.Hu1 = out.eta20 + out.eta02;
out.Hu2 = (out.eta20 - out.eta02)^2 + 4*out.eta11^2;
out.Hu3 = (out.eta30 - out.eta12)^2 + (3*out.eta21 - out.eta03)^2;
out.Hu4 = (out.eta30 + out.eta12)^2 + (out.eta21 + out.eta03)^2;
out.Hu5 = (out.eta30 - 3*out.eta12)*(out.eta30 + out.eta12)*...
    ((out.eta30 + out.eta12)^2 - 3*(out.eta21 + out.eta03)^2) ...
    + (3*out.eta21 - out.eta03)*(out.eta21 + out.eta03)*...
    (3*(out.eta30 + out.eta12)^2 - (out.eta21 + out.eta03)^2);
out.Hu6 = (out.eta20 - out.eta02)*...
    ((out.eta30 + out.eta12)^2 - (out.eta21 + out.eta03)^2) + ...
    4*out.eta11*(out.eta30 + out.eta12)*(out.eta21 + out.eta03);
out.Hu7 = (3*out.eta21 - out.eta03)*(out.eta30 + out.eta12)*...
    ((out.eta30 + out.eta12)^2 - 3*(out.eta21 + out.eta03)^2) -...
    (out.eta30 - 3*out.eta12)*(out.eta21 + out.eta03)*...
    (3*(out.eta30 + out.eta12)^2 - (out.eta12 + out.eta03)^2);




