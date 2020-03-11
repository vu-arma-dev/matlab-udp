% Test UDP_msgr within a single Matlab script
% This script will create two udp objects that will talk to each other
% within one Matlab script.

% Andrew Orekhov 7/21/19

clear all; close all;

%data to send/receive
value_format = {'uint8','single','double','double','double','single'};
data = [1; 2.2; 3.3; 4.4; 5.5; 6.6];

local_ip = '192.168.1.106';
remote_ip = local_ip;

%Setup the udp objects
% For reference: UDP_msgr(RemoteIP,RemotePort,LocalPort,value_format)
local_udp = UDP_msgr(remote_ip,20000,20003,value_format);
remote_udp = UDP_msgr(local_ip,20003,20000,value_format);

num_loop = 500;
lost_packets = 0;

tic;
for i = 1:num_loop
    
    %send data
    %Note that send() is much faster than receive()
    local_udp.send(data);

    %receive data
    [data_rcv,length_correct] = remote_udp.receive();
   
     if ~length_correct || any(abs(data_rcv - data) > 1e-6)
        lost_packets = lost_packets + 1;
    end
    
end
time_elapsed = toc;
fprintf('UDP send/receive speed: %0.3f hz \n',num_loop/time_elapsed);
fprintf('Lost packets: %d (%0.1f percent)\n',lost_packets,100*lost_packets/num_loop);

local_udp.close();
remote_udp.close();