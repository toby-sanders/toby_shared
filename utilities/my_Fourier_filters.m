function V = my_Fourier_filters(k,nlev,p,q,r)

% Written by Toby Sanders @ASU
% School of Math & Stat Sciences
% 09/24/2018

% store eigenvalues of regularization operator 
if k~=0
    vx = zeros(nlev,q); vy = zeros(nlev,p); vz = zeros(nlev,r);
    for i = 1:nlev
        vx(i,:) = 4^k*(sin(2^(i-1)*pi*linspace(0,q-1,q)/q).^(2*k+2))./...
                (sin(pi*linspace(0,q-1,q)/q).^2)*(2^(2-k-i)/nlev)^2;
        vy(i,:) = 4^k*(sin(2^(i-1)*pi*linspace(0,p-1,p)/p).^(2*k+2))./...
            (sin(pi*linspace(0,p-1,p)/p).^2)*(2^(2-k-i)/nlev)^2;
        vz(i,:) = 4^k*(sin(2^(i-1)*pi*linspace(0,r-1,r)/r).^(2*k+2))./...
            (sin(pi*linspace(0,r-1,r)/r).^2)*(2^(2-k-i)/nlev)^2;
    end
    vx(:,1) = 0; vy(:,1) = 0; vz(:,1) = 0;
    vx = sum(vx,1); vy = sum(vy,1); vz = sum(vz,1); 
    V = vy' + vx + reshape(vz,1,1,r);
else
    V = 4*ones(p,q,r);
end