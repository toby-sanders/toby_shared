% This package includes algorithms primarily for solving inverse problems 
% with a particular focus on tomographic reconstruction and regularization.
% Also included are image alignment algorithms
%
% To get started, please look at the read-me PDF file. Run this script 
% to REMOVE these folders to your MATLAB paths.
% Demos are included for each code of interest
%
%
%
% Written by Toby Sanders @ASU
% School of Math & Stat Sciences
% 12/15/2016
%
% Please email any bugs or inquires to toby.sanders@asu.edu

mainpath = pwd;

rmpath([mainpath,'/solvers']);
rmpath([mainpath,'/solvers/L1']);
rmpath([mainpath,'/solvers/L1/Transforms']);
rmpath([mainpath,'/solvers/L1/Transforms/multiscale']);
rmpath([mainpath,'/solvers/L1/Transforms/wave_shear']);
rmpath([mainpath,'/solvers/L1/utilities']);
rmpath([mainpath,'/solvers/L1/inpaint']);
rmpath([mainpath,'/solvers/tikhonov']);
rmpath([mainpath,'/tomography/SIRT']);
rmpath([mainpath,'/tomography/JOHANN_RADON']);
rmpath([mainpath,'/tomography/Align']);
rmpath([mainpath,'/tomography/Align/subroutines'])
rmpath([mainpath,'/tomography/DART']);
rmpath([mainpath,'/tomography/DART/subroutines'])
rmpath([mainpath,'/utilities']);