function y = my_conv_opers(x,mode,Hhat,n)


switch mode
    case 1
        y = col(ifftn(fftn(reshape(x,n)).*Hhat));
    case 2
        y = col(ifftn(fftn(reshape(x,n)).*conj(Hhat)));
end


