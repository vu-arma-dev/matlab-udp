%% Setup UDP
packet_size_send = 4; %number of numbers
packet_size_receive = 4; %number of numbers

RemoteIP = '192.168.1.134';
LocalPort = 38001;
RemotePort = 38000;

u = UDP_msgr(RemoteIP,RemotePort,LocalPort);
tStart = tic;
tLast = 0.0;
data_id = 0;
freq = 0;
dt_sum = 0;
delay_sum = 0;
reverseStr = [];
while (1)
    data = u.receiveDataMsg(packet_size_receive,'single');
    u.send([double(tLast),2.0,3.0,4.0],'float32');
    if ~isempty(data)
        data_id = data_id + 1;
        tCurrent = toc(tStart);
        dt = tCurrent - tLast;
        dt_sum = dt_sum + dt;
        freq = 1/(dt_sum/data_id);
        tLast = tCurrent;
        delay = tCurrent - data(1);
        delay_sum = delay_sum + delay;
        delay_disp = (delay_sum/data_id);
        msg = ...
            sprintf([...
            'Data received [%.0f],', ...
            'Receiving rate [%.0f Hz],',...
            ' Delay [%.1f]',...
            '\n [%0.3f, %0.3f, %0.3f] \n'],...
            data_id,freq,delay,data(2),data(3),data(4));
    else
        msg = [];
    end
    if ~isempty([reverseStr, msg])
        fprintf([reverseStr, msg]);
    end
    reverseStr = repmat(sprintf('\b'), 1, length(msg));
end

