%% parameters of stepper motors
microSteppingCount = 8; 
% by default, micro stepping count is 1, which means that one turn of the
% motor shaft reads 200 counts.
stepsPerRev = 200*microSteppingCount; % counts per stepper motor turn
                      % we included microstepping 16
GearRatio = 1;
pitch_mm_per_turn = 1/16*25.4; % the pitch of the lead screw, unit in (mm/turn)