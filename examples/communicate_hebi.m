% Script to control two hebi actuators via UDP comms to another host
% Deprecated

%% Initialize two Hebi actuators

addresses = {
    '192.168.1.180'
    '192.168.1.181'
    };

HebiLookup.setLookupAddresses(addresses);
%disp(HebiLookup);

groupHebi = HebiLookup.newGroupFromNames('*',{'X-80167','X-80168'});
disp(groupHebi);

%set hebi gains and control strategy
gains = GainStruct();
gains.controlStrategy = [3,3];
gains.velocityKp = [1,1];
gains.positionKp = [4,4];
gains.positionKi = [0.1,0.1];

cmd = CommandStruct();

groupHebi.set('gains',gains);
disp('Make sure that both Hebis were found!');
disp('Press any key or click the figure to continue...');
waitforbuttonpress;
close(gcf);

%Move hebis to home
goal_velocity = [0,0];
goal_position = [0,0]; %radians

%% Setup UDP
packet_size = 6; %number of numbers
u = UDP_msgr('192.168.1.178',28000,28001);

%% Control loop

while (1)
    
    %Read desired position and velocity
    data = u.receiveDataMsg(6,'double');
    if ~isempty(data)
    disp('Data:');
    disp([data(1),data(2),data(3),data(4),data(5),data(6)]);
    goal_position = [data(1), data(2)];
    goal_velocity = [data(3), data(4)];
    end
    
    % send hebi commands
    cmd.velocity = goal_velocity;
    cmd.position = goal_position;
    groupHebi.send(cmd);
        
    % Get Hebi feedback and send back to host
    fbkHebi = groupHebi.getNextFeedback();
    %disp('Position:');
    %disp(fbkHebi.position);
    %disp('Velocity:');
    %disp(fbkHebi.velocity);
    u.send( swapbytes([fbkHebi.position, fbkHebi.velocity, 1.2, 3.4]),'double');
    
end



