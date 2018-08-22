classdef UDP_msgr
    %%  UDP messenger
    %   Long Wang, 2018/1/8
    %   For Testing purposes
    properties
        udpOBJ; % udp object by Matlab
    end
    
    methods
        function obj = UDP_msgr(RemoteIP,RemotePort,LocalPort)
            if nargin<3
                LocalPort = RemotePort;
            end
            obj.udpOBJ = udp(RemoteIP,RemotePort,'LocalPort',LocalPort);
            try
                fopen(obj.udpOBJ);
            catch
                instrreset;
                obj.udpOBJ = udp(RemoteIP,RemotePort,'LocalPort',LocalPort);
                fopen(obj.udpOBJ);
            end
        end
        function send(obj,data,format)
            if nargin<3
                format = 'float32';
            end
            % data = swapbytes(data);
            fwrite(obj.udpOBJ,(data),format);
        end
        function data = receiveStringMsg(obj,dataArraySize)
            data  = char(fread(obj.udpOBJ,dataArraySize,'char'));
        end
        function [data,received] = receiveDataMsg(obj,dataArraySize,format)
            if nargin<2
                dataArraySize = 1;
            end
            if nargin<3
                format = 'single';
            end
            switch format
                case 'single'
                    BytePerValue = 4;
                case 'uint8'
                    BytePerValue = 1;
                case 'double'
                    BytePerValue = 8;
            end
            packet_READ = 0;
            data = [];
            %while (obj.udpOBJ.BytesAvailable ~= 0)
            packet_READ = 1;
            data  = fread(obj.udpOBJ,BytePerValue*dataArraySize);
            flushinput(obj.udpOBJ);
            %end
            received = packet_READ*(length(data)==dataArraySize);
            if strcmp(format, 'single') || strcmp(format,'double')
                data = obj.unpackUDP_Msg_single(uint8(data),format);
            elseif strcmp(format,'uint8')
                % do nothing
            else
                fprintf('[\b  Format not recognized  ]\b\n');
            end
        end
        function close(obj)
            fclose(obj.udpOBJ);
        end
    end
    methods (Static)
        function data_unpacked = unpackUDP_Msg_single(data,format)
            switch format
                case 'single'
                    bytesPerData = 4;
                case 'double'
                    bytesPerData = 8;
                otherwise
                    fprintf('[\b  Wrong Format input  ]\b\n');
                    
            end
            %   Assuming the data is [4n x 1]
            dataLen = length(data)/bytesPerData;
            data_unpacked = zeros(dataLen,1);
            for i = 1:dataLen
                start_i = 1+(i-1)*bytesPerData;
                data_unpacked(i) = typecast(data(start_i:start_i+(bytesPerData-1))',...
                    format);
            end
        end
    end
end

