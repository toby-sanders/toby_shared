function e = myrel2(V1,V2,p)

if nargin<3
    p = 2;
end
muV2 = mean(col(V2));
e = norm(col(V1-V2),p)/norm(col(V2)-muV2,p);


