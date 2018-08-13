function [ip,port] = targetAddressBook( target_name )
%%  Target Address Book
%   This function is used to look up ip and port information that
%   corresponds to a target_name
switch target_name
    case 'TargetPC1'
        ip = '192.168.1.1';
        port = '22222';
    case 'IREP'
        ip = '192.168.1.201';
        port = '22222';
    case 'Bello'
        ip = '192.168.1.167';
        port = '22222';
    case 'Parker'
        ip = '192.168.1.167';
        port = '22222';
    case 'Puma'
        ip = '192.168.1.167';
        port = '22222';
    case 'PSMCMD'
        ip = '192.168.1.145';
        port = '22222';   
    case 'xPC_UDP'
        ip = '192.168.1.178';
        port = '22222';
    otherwise
        ip = [];
        port = [];
end
       
end

