classdef UDP_msgr
    % UDP messenger
    %
    % See also UDP_msgr.UDP_msgr, UDP_msgr.receive, UDP_msgr.send
    
    %   Long Wang, 1/8/2018
    %   Modified by Andrew 7/21/19
    
    properties (Access = public)
        udpOBJ % udp object by Matlab
    end
    
    properties (SetAccess = private)
        value_format = {}; %1D cell array of data format for each value in packet
        num_value = 0;%number of values being sent
        num_bytes_total = 0 %total number of bytes in packet
        byte_per_value = [] %a vector dictating number of bytes per value
        input_buffer_multiplier = 20; %input_buffer_size = multipler * num_bytes_total
        % input_buffer_multiplier must be a whole number to prevent half a
        % packet being read in when the buffer is full
        input_buffer_size
    end
    
    methods
        
        function obj = UDP_msgr(RemoteIP,RemotePort,LocalPort,value_format)
            % Constructor for UDP_msgr
            %
            % Inputs:
            % RemoteIP - ip address of remote device
            % RemotePort - port on remote device
            % LocalPort - port on local cdevice
            % value_format - 1D cell array of data format for each value in packet
            %              - e.g. {'uint8','single','single'}
          
            if ~iscell(value_format)
                error('value_format must be a 1D cell array of strings');
            end
            
            %setup the packet properties
            obj.num_value = length(value_format);
            obj.value_format = value_format;
            
            % setup the byte_per_value vector
            % note that byte_per_value is necessary to avoid slow calls to
            % strcmp within receiveDataMsg()
            for i = 1:obj.num_value;
                if strcmp(obj.value_format(i),'uint8')
                    obj.byte_per_value(i) = 1;
                elseif strcmp(obj.value_format(i),'int8')
                    obj.byte_per_value(i) = 1;
                elseif strcmp(obj.value_format(i),'uint16')
                    obj.byte_per_value(i) = 2;
                elseif strcmp(obj.value_format(i),'int16')
                    obj.byte_per_value(i) = 2;
                elseif strcmp(obj.value_format(i),'uint32')
                    obj.byte_per_value(i) = 4;
                elseif strcmp(obj.value_format(i),'int32')
                    obj.byte_per_value(i) = 4;
                elseif strcmp(obj.value_format(i),'uint64')
                    obj.byte_per_value(i) = 8;
                elseif strcmp(obj.value_format(i),'int64')
                    obj.byte_per_value(i) = 8;
                elseif strcmp(obj.value_format(i),'single')
                    obj.byte_per_value(i) = 4;
                elseif strcmp(obj.value_format(i),'double')
                    obj.byte_per_value(i) = 8;
                else
                    msg = ['Invalid string for value_format{',num2str(i),'}'];
                    error(msg);
                end
            end
            
            obj.num_bytes_total = sum(obj.byte_per_value);
                      
            %note that it is possible for half a packet to be held in a buffer
            %for this reason, the input_buffer_size is always a multiple of the
            %packet size.
            obj.input_buffer_size = obj.input_buffer_multiplier*obj.num_bytes_total;
        
            %open udp port
            obj.udpOBJ = udp(RemoteIP,RemotePort,...
                'LocalPort',LocalPort,...
                'InputBufferSize',obj.input_buffer_size,...
                'DatagramTerminateMode','on',...
                'ReadAsyncMode','continuous');
            
            try
                fopen(obj.udpOBJ);
            catch
                instrreset;
                obj.udpOBJ = udp(RemoteIP,RemotePort,'LocalPort',LocalPort,'InputBufferSize',obj.input_buffer_size);
                fopen(obj.udpOBJ);
            end
            
        end

    end
end

