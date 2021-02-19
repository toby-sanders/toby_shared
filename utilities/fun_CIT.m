function [J, errCode] = fun_CIT(I, stretchTol, exp_nTiles, exp_CLim, exp_nBins)

% The first parameter is the image, which should be in 16 bit unsigned int format.
% 
% The second parameter is the stretch tolerance, which is a value from 
% 1-100 usually 1-5.  This help to avoid outlier pixel values from 
% influencing the histogram equalization.
% 
% The third parameter is the number of tiles the image will be broken into.  
% The number of tiles is 2^x, where x is the input parameter.
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

errCode = 0;
try
   %  hWB = waitbar(0, 'Processing','Name', 'CIT');
    nTiles = 2^exp_nTiles;
    CLim = 10^exp_CLim;
    nBins = 2^exp_nBins;
    
    stretchLim = stretchlim(I, [stretchTol/100 1-stretchTol/100]);
    % waitbar(1/4, hWB);
    IO = imadjust(I, stretchLim, []);
    % waitbar(2/4, hWB);

    I_adapthisteq = adapthisteq(IO, 'NumTiles', [nTiles nTiles],...
                    'NBins', nBins ,...
                    'ClipLimit', CLim);
    % waitbar(3/4, hWB);
                
%     sigma = round(min(size(IO))/80/2.35);
%     sigma = max(10, sigma);
%     J = imsharpen(I_adapthisteq, 'Radius', sigma, 'Amount', 0.8);
%     J = single(J);
    J = single(I_adapthisteq);

% waitbar(1, hWB);
  %   close(hWB)
    
catch ME
    errCode = ME;
    J = [];
    return
end
