%%  File Scope Setup
dt_data = 0.002;
N_FC_Dec = round(dt_data/dt); % Decimation of the file scope [except for the EM]
%%  sensor scopes
%   Voltage scope
scope_msg_Pot = 'Pot 1: %3.2f [V],Pot 2: %3.2f [V],Pot 3: %3.2f [V]';
scope_msg_Pres = 'Pres 1: %3.2f [V],Pres 2: %3.2f [V],Pres 3: %3.2f [V]';
scope_msg_Ref = 'Ref_Voltage: %3.2f [V]';
scope_msg_Act = 'Act 1: %3.2f [V],Act 2: %3.2f [V],Act 3: %3.2f [V]';
scope_msg_Ref2 = 'Ref2_Voltage: %3.2f [V]';
Scope_format_sensor_volt = [scope_msg_Pot,',',scope_msg_Pres,',',...
    scope_msg_Ref,',',scope_msg_Act,',',scope_msg_Ref2];
%   Converted reading scope
scope_msg_Pot_mm = 'Pos 1: %3.2f [mm],Pos 2: %3.2f [mm],Pos 3: %3.2f [mm]';
scope_msg_Pres_PSI = ...
    'Pres 1: %3.2f [PSI], Pres 2: %3.2f [PSI], Pres 3: %3.2f [PSI]';
scope_msg_Act_mm = 'Act 1: %3.2f [mm],Act 2: %3.2f [mm],Act 3: %3.2f [mm]';
Scope_format_pos_and_pres = ...
    [scope_msg_Pot_mm,',',scope_msg_Pres_PSI,',',scope_msg_Act_mm];
%%  tracker scopes
scope_msg_EM1_XYZ = 'EM1 x: %3.2f [mm],y: %3.2f [mm],z: %3.2f [mm]';
scope_msg_EM2_XYZ = 'EM2 x: %3.2f [mm],y: %3.2f [mm],z: %3.2f [mm]';
scope_msg_EM3_XYZ = 'EM3 x: %3.2f [mm],y: %3.2f [mm],z: %3.2f [mm]';
scope_msg_EM4_XYZ = 'EM4 x: %3.2f [mm],y: %3.2f [mm],z: %3.2f [mm]';
scope_msg_nx_ny_nz = 'nx: %3.2f, ny: %3.2f, mz: %3.2f';
scope_msg_quat = 'q0: %3.2f, qx: %3.2f, qy: %3.2f, qz: %3.2f';
Scope_format_EM_sensor_1 = [scope_msg_EM1_XYZ,',',scope_msg_nx_ny_nz];
Scope_format_EM_sensor_2 = [scope_msg_EM2_XYZ,',',scope_msg_nx_ny_nz];
Scope_format_EM_sensor_3 = [scope_msg_EM3_XYZ,',',scope_msg_nx_ny_nz];
Scope_format_EM_sensor_4 = [scope_msg_EM4_XYZ,',',scope_msg_nx_ny_nz];
%%  motor scopes
scope_msg_motor123 = ...
    'Motor 1: %3.2f [mm],Motor 2: %3.2f [mm],Motor 3: %3.2f [mm]';
scope_msg_lamb123 = ...
    'lamb 1: %3.2f [mm],lamb 2: %3.2f [mm],lamb 3: %3.2f [mm]';
scope_msg_q_des = ...
    'q_des 1: %3.2f [mm],q_des 2: %3.2f [mm],q_des 3: %3.2f [mm]';
Scope_format_stepper_motors = ...
    [scope_msg_motor123,',',scope_msg_lamb123,',',scope_msg_q_des];
scope_msg_Tip_XYZ = ' x: %3.2f [mm],y: %3.2f [mm],z: %3.2f [mm]';
Scope_format_bello_tip = ...
    ['Bello', scope_msg_Tip_XYZ,',',scope_msg_quat];
Scope_format_cui_tip = ...
    ['CUI', scope_msg_Tip_XYZ,',',scope_msg_quat];

Scope_format_psi_cur = ...
    'theta : %3.2f [deg],delta: %3.2f [deg],alpha: %3.2f [mm]';
%% clear unused temp vars
clear scope_msg_*;