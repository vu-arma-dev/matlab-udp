function SETUP_BUILD_PATH(env_var_name)
%%  Control the output file location
%   This func will set up the output build folder 
%   The build folder will be under the model root folder, e.g. /Model/Build
%   The input is the envirionment variable name to be defined/used
%   If not defined, select one from the list
    if nargin==0
        fprintf('Select one from the following to define the environment variable:\n');
        fprintf('[1] IREP Matlab14 Model folder path ENV -> IREPDIR \n');
        fprintf('[2] Parker Model folder path ENV -> PARKERDIR \n');
        fprintf('[3] IREP Matlab10 Model folder path ENV -> IREPOLD \n');
        fprintf('[4] BELLOSCOPE ENV -> BELLODIR \n');
        fprintf('[0] Other Model folder path ENV -> Type in yourself \n');
        selection = input('Select: ','s');
        fprintf('\n');
        switch selection
            case '1'
                env_var_name = 'IREPDIR';
            case '2'
                env_var_name = 'PARKERDIR';
            case '3'
                env_var_name = 'IREPOLD';
            otherwise
                env_var_name = input('Type in the environment varible name for the model folder: ','s');
        end
    end
    path_Model = SETUP_ENV_PATH(env_var_name);
    % Get the current configuration
    cfg = Simulink.fileGenControl('getConfig');
    % Change the parameters to C:\cachefolder and current working folder
    Build_Path = [path_Model,'\Build'];
    if exist(Build_Path,'dir')~=7
        mkdir(Build_Path);
    end
    cfg.CacheFolder = Build_Path;
    cfg.CodeGenFolder = Build_Path;
    Simulink.fileGenControl('setConfig', 'config', cfg);   
end

