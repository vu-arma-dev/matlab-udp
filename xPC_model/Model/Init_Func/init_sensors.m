%%  Data Acquisition card info
xPC_Machine = 'Parker';
switch xPC_Machine
    case 'PSM Commander'
        MCPCI1602_SLOT = [4 1];
    case 'Parker'
        MCPCI1602_SLOT = -1; % -1 is automatically search
end
%%  Filters Initialization
N_pots = 10;
pots_filter_coeffs = ones(N_pots,1); %weights
%%  pot spline points - CUI and Actuation
[   CUI_Pot_Spline_Points,...
    CUI_Pot_Max_R,...
    Actuation_Pot_Spline_Points,...
    Act_Pot_Max_R] ...
    = generatePotSplineModels();
%%  EM trackers
dt_trakstar = 1/125;
N_trakstar = 1;
trakstar_filter_coeffs = ones(N_trakstar,1);
%   load EM sensor frames and offsets
try
    load([...
        getenv('BELLODIR'),filesep,...
        'Config_Mat',filesep,'EM_Bases_Offsets']);
    fprintf('EM sensor bases and offsets [loaded] \n')
catch
    belloBaseFrame_EM_Sensors = eye(4);
    cuiBaseFrame_EM_Sensors = eye(4);
    belloTipOffset_EM_Sensors = eye(4);
    cuiTipOffset_EM_Sensors = eye(4);
end