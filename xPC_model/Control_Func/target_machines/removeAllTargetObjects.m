function removeAllTargetObjects()
%%  Removed All Target Objects
%   Long Wang, 2018/1/21
%   This func removes all target objects, only leave the default to be "TargetPC1"
%% check if 'TargetPC1' is defined
ALL_settings = SimulinkRealTime.getTargetSettings('-all');
nameMatch = strfind({ALL_settings.Name}, 'TargetPC1');
[~,indexMatch] = find(~cellfun(@isempty,nameMatch));
if isempty(indexMatch)
    SimulinkRealTime.addTarget('TargetPC1');
end
%% List all target objects
ALL_settings = SimulinkRealTime.getTargetSettings('-all');
N_settings = length(ALL_settings);
for i = 1:N_settings
    targetName = ALL_settings(i).Name;
    if ~strcmp(targetName,'TargetPC1')
        SimulinkRealTime.removeTarget(targetName);
        fprintf('Target Object [%s] has been removed\n',targetName);
    end
end

end

