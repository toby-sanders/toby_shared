function J = fun_CIT(I, stretchTol, tileSize, CLim, exp_nBins)

% The first parameter is the image, which should be in 16 bit unsigned int format.
% 
% The second parameter is the stretch tolerance, which is a value from 
% 1-100 usually 1-5.  This help to avoid outlier pixel values from 
% influencing the histogram equalization.
% 
% The third parameter is the tile size
% 
% The fourth parameter is the clip limit.  It is best to look at the 
% “adapthisteq” built-in function to understand this parameter.  The clip 
% limit is 10^x, where x is the input parameter.
% 
% The fifth parameter is the number of bins used in the histograms.  The 
% number of bins is 2^x, where x is the input parameter.
% 
% In general, the “adapthisteq” function help will be useful for default 
% parameter selection.

if abs(max(I(:))) <= 1
    I = im2uint16(I);
elseif abs(max(I(:))) < 2^16
    I = uint16(I);
end

M = max(round(size(I,1)/tileSize),2);
N = max(round(size(I,2)/tileSize),2);
% CLim = 10^exp_CLim;
nBins = 2^exp_nBins;

stretchLim = stretchlim(I, [stretchTol 1-stretchTol]);

IO = imadjust(I, stretchLim, []);


I_adapthisteq = adapthisteq(IO, 'NumTiles', [M N],...
                'NBins', nBins ,...
                'ClipLimit', CLim);

J = single(I_adapthisteq);


