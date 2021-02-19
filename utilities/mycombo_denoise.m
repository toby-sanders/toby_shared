function x = mycombo_denoise(A,R,x,mode)

switch mode
    case 1
        x = A*x;
        x = R.*x;
    case 2
        x = R.*x;
        x = A'*x;
end
