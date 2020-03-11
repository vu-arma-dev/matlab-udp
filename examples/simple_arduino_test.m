% This is a simple test of communication between a Matlab host and an
% Arduino. Arduino code is found under "simple_arduino_test". 

% If you change any of the data types in this script you must also ensure
% that the Arduino script is also updated. 

% A. Orekhov and C. Abah 3/11/20
close all; clear all;

%% Setup UDP
% Define the data types in a single packet
% In this example, the packet has 4 numbers in it. 
% Each number is a double. Note that UDP_msgr allows you to make each
% number in the packet a different data type, but the current Arduino code
% does not support this so we must make all numbers the same datatype here.
value_format = {'single','single','single','single'};
data_send = [0.0; 2.2; 3.3; 4.4];

RemoteIP = '192.168.1.134'; %ip address of the arduino
LocalPort = 38001; %port on your local computer where you will receive data
RemotePort = 38000; %port on arduino where you will send data

% Create the UDP_msgr object
u = UDP_msgr(RemoteIP,RemotePort,LocalPort,value_format);

tStart = tic;
tLast = 0.0;
data_id = 0;
freq = 0;
dt_sum = 0;
delay_sum = 0;
reverseStr = []; %reverse string for better display of fprintf
lost_packets = 0;

num_loop = 5000; %number of times to send/receive in this script

% Send the first data packet
u.send(data_send);

tic;
counter = 0;
for i = 1:num_loop
    %receive data. Note that receive is much slower than send.
    [data_rcv,length_correct] = u.receive();
   
     if length_correct && all(abs(data_rcv - data_send) < 1e-6)
         counter = counter + 1; %counts how many packets you've sent/received
         % Display data
         freq = counter/toc; %how fast you're getting data
         msg = sprintf([...
            'Data received [%0.0f,%0.2f,%0.2f,%0.2f], ', ...
            'Send/receive rate: %0.0f Hz\n'],...
            data_rcv,freq);
        
        if ~isempty([reverseStr, msg])
        fprintf([reverseStr, msg]);
        end
        reverseStr = repmat(sprintf('\b'), 1, length(msg));
        
        % Increment coutner and send another packet
        data_send(1) = data_send(1) + 1;
        u.send(data_send);
     end
end
   

