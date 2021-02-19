function x = superResOpers(x,mode,p,q)

% Written by Toby Sanders @ Lickenbrock Tech.
% 2/12/20

% inputs
% p,q - dimensions of the image to be reconstructed (3 times the data)


switch mode
    case 1
        % blur, downsample, then replicate nF times
        x = reshape(x,p,q);
        x = x(2:3:end,2:3:end);
        x = x(:);
    case 2
        % upsample, conj. blur, then sum over frames
        x = reshape(x,p/3,q/3);
        y = zeros(p,q);
        y(2:3:end,2:3:end,:) = x;
        x = y(:);
end