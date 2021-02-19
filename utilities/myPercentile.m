function y = myPercentile(x,p)

n = numel(x);
x = sort(x(:));
v = (.5:1:n-.5)/n;
if p<=v(1)
    y = x(1);
elseif p>=v(end)
    y = x(end);
else
    z = sum(v<p);
    d = v(z+1)-v(z);
    w1 = 1-(p-v(z))/d
    w2 = 1-(v(z+1)-p)/d
    y = x(z+1)*w2 + x(z)*w1;  
end
