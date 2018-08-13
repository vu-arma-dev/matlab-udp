function XPCUDP_DEPENDENCY()
%%  Long Wang, 2016/6/29
%   This func will exclusively setup the denpendency for IREP xPC model
%   (Matlab 2015 version).
%   There will be generally two libraries needed for any ARMA robot.
%       1) Embedded Common Library
%       2) Custom robot emebedded library, (e.g. in this case, Embedded_Func under model directory)
% %%  Get ECL Path (if not existed, set up one.)
% matlab_version = '2016';
% if strcmp(matlab_version,'2010')
%     path_ECL = SETUP_ENV_PATH('ECL2010');
% else
%     path_ECL = SETUP_ENV_PATH('ECLDIR');
% end
%%  Custom Embdded Library
path_Model = SETUP_ENV_PATH('XPCUDPDIR');
%%  Other dependencies
path_Rob_Init = [path_Model,'\Init_Func'];
path_Rob_simulink = [path_Model,'\m2016'];
%%  Adding all the path
restoredefaultpath;
addpath(  ...
    path_Rob_Init,...
    path_Rob_simulink);

end