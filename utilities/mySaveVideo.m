function mySaveVideo(vFileName, vVar, frameRate, vFileSuffix)


% function for writing a series of frames into a video file
% INPUTS:
% vFileName - name to save the video file
% vVar - video frames (4D for color)
% frameRate - number of frames per second
% vFileSuffix - file type (e.g. avi or mp4)

% written by Toby Sanders @Lickenbrock Tech.

% check input arguments
if nargin ==1
    error('Too few inputs!');
elseif nargin == 2
    frameRate = 30;
    vFileSuffix = 'avi';
    vFileFormat = 'Motion JPEG AVI';
elseif nargin ==3
    vFileSuffix = 'avi';
    vFileFormat = 'Motion JPEG AVI';
else
    if strcmp(vFileSuffix, 'avi')
        vFileFormat = 'Motion JPEG AVI';
    elseif strcmp(vFileSuffix, 'mp4')
        vFileFormat = 'MPEG-4';
    else
        error('video format type not recognized');
    end
end

% add file extension to save name
vFileName = [vFileName '.' vFileSuffix];
disp(vFileFormat)

% write video
vFile = VideoWriter(vFileName, vFileFormat);
vFile.FrameRate = frameRate; % set frame rate
vFile.Quality = 0;   % set video quality, integer between [0,100]
[p,q,r,s] = size(vVar);
open(vFile);
if s==1
    writeVideo(vFile,reshape(vVar,p,q,1,r));
else
    writeVideo(vFile, vVar);
end
close(vFile);

