function tg = create_ARMA_TargetObject(target_name)
%%  create target object given a name
%   By Long Wang, 2018/1/21 this function follows the following steps 

%   (i) check if a target object was already defiend by the name of
%   "target_name"

%   (ii-a) in the case of an object existed, this function returns the
%   target object and test the connection

%   (ii-b) in the case of no object existed under "target_name", a new
%   target object will be defined for this host machine, and its "ip" and
%   "port" will be looked up from a function called "targetAddressBook".

%   In the function "targetAddressBook", all choices of "target_name" have
%   to be corresponded with ip and port, otherwise, ip and port are
%   returned as empty.
if nargin<1
    target_name = 'TargetPC1';
end
%%  check if "target_name" alreay exists
ALL_settings = SimulinkRealTime.getTargetSettings('-all');
nameMatch = strfind({ALL_settings.Name}, target_name);
[~,indexMatch] = find(~cellfun(@isempty,nameMatch));
%   if "indexMatch" is empty, meaning no target object exists under
%   "target_name"
%%  create [or get] the target object
tg = [];
if isempty(indexMatch)
    [ip,port] = targetAddressBook(target_name);
    if ~isempty(ip)
        tg = SimulinkRealTime.addTarget(target_name);
        try 
            tg.TcpIpTargetAddress = ip;
        catch
            % If one gets here, it means there is an ip conflict. The
            % solution is to delete the target object that has the same
            % address as the desired one.
            ALL_settings = SimulinkRealTime.getTargetSettings('-all');
            ipMatch = strfind({ALL_settings.TcpIpTargetAddress}, ip);
            [~,ipIndexMatch] = find(~cellfun(@isempty,ipMatch));
            SimulinkRealTime.removeTarget(ALL_settings(ipIndexMatch).Name);
        end
        tg.TcpIpTargetPort = port;
        %   after "SimulinkRealTime.addTarget", you still need to ".target"
        %   to fetch the added target. Otherwise it does not have the
        %   essential properties.
        tg = SimulinkRealTime.target(target_name);
    else
        fprintf(...
            '\nThe ip address is not defined for "%s" in the function [targetAddressBook]\n',...
            target_name);
    end
else
    tg = SimulinkRealTime.target(target_name);
end
end