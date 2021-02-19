function flag = mySaveUtility(flist,thisFile)

% this code automatically saves all of the files in flist to a new folder
% you select. I created this function for code sharing and reproducibility,
% so that when a list of .m files is given as dependencies to run a code,
% they are then all saved together, and the code is then saved and easily
% shared with someone else. To get the list of all codes needed, run the
% following command at the top of your file:
% fList = matlab.codetools.requiredFilesAndProducts(files);

flag = 1;
try
    SaveName = datestr(datetime);
    % mSaveDir = ['C:\Users\toby.sanders\Documents\NGA_ResultsAndData\autoSavedResults',filesep,mSaveName];
    SaveDir = uigetdir;
    SaveDir = strcat(SaveDir,filesep,SaveName);
    tmp = strfind(SaveDir,':');
    SaveDir(tmp(2:end)) = '-';
    mkdir(SaveDir);

    if nargin==2
        copyfile([thisFile,'.m'],SaveDir);
    end
    for i = 1:numel(flist)
        if strcmp('.m',flist{i}(end-1:end))
            copyfile(flist{i},SaveDir); 
        end
    end
    msgbox(sprintf('files Saved to %s',SaveDir));
catch
    msgbox('file saving failed');
    flag = 0;
end
        