function PATH_ENV = SETUP_ENV_PATH(env_var_name,option)
%%  Long Wang 2014/10/31
%   DO NOT EDIT THIS FUNCTION, ONLY USE IT.
%   This func will setup the environment variable for a defined path.
%   There usually will be two libraries needed for any ARMA robot.
%       1) Embedded Common Library
%       2) Custom robot emebedded library, (e.g. Embedded_Func_IREP, Embedded_Func_Parker)
%   Input:  env_var_name: envrioment variable name
%           option, 
%           'f', force to change/overwrite the environment varialbles
%           'd', delete the env var
%   Output: path_ECL, the folder path for Embedded Common Library
%%  Embedded Common Library Directory
%   This procedure will only be required once at the beginning when use
%   this machine, unless you want to force to change it.
PATH_ENV = getenv(env_var_name); % retreive ECL path from system variables
if ~isdir(PATH_ENV) % check if directory has been removed
    PATH_ENV=[];
end
if nargin>1
     if strcmp(option,'f')
           PATH_ENV = [];
     elseif strcmp(option,'d') % Define an empty env var = delete it.
           PATH_ENV = [];
     end
else
    option = 1;
end

if isempty(PATH_ENV) 
    fprintf('The environment virable for %s is not set to WINDOWS',env_var_name);
    NeedSetManually = 1;
else
    NeedSetManually = 0;
end

while isempty(PATH_ENV) && (~strcmp(option,'d')) % check that variable exists
    PATH_ENV = uigetdir(pwd,['Select Folder for ',env_var_name]);
    if (PATH_ENV==0)
        PATH_ENV=[];
    end
end

if isempty(PATH_ENV)
    setenv(env_var_name);% delete the env_var
else
    setenv(env_var_name,PATH_ENV); % update library path
end

if NeedSetManually
    fprintf('Need to set the following environment virable to WINDOWS:\n');
    fprintf('Environment Virable Name:%s\n',env_var_name);
    fprintf('Environment Virable Value:%s\n',PATH_ENV);
end
end

