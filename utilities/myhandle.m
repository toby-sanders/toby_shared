function x = myhandle(A,B,x,mode)

switch mode
    case 1
        x = col(A(x));
    case 2
        x = col(B(x));
end