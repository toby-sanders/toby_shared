function [ssimval] = my_SSIM(X,Y)

% structural similarity index measures (SSIM)

mux = mean(X(:));
muy = mean(Y(:));
sigmax = var(X(:));
sigmay = var(Y(:));
sigmaxy = cov(X(:),Y(:));
sigmaxy = sigmaxy(2);

c1 = 1;c2 = 1;
ssimval = (2*mux*muy+c1)*(2*sigmaxy+c2)...
    ./(mux^2 + muy^2+c1)/(sigmax + sigmay + c2);

end

