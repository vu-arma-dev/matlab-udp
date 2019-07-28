function [data_unpacked,length_correct] = receive(obj)
            % UDP_msgr.receive()
            % Read a UDP packet from the local port. The packet to be
            % received is defined by the UDP_msgr constructor.
            
            %Note that udp.BytesAvailable() is actually pretty slow. It'd
            %be good to get around using it somehow. Unfortunately
            %fread() is blocking and it's timeout must be specified in
            %seconds.
            if (obj.udpOBJ.BytesAvailable >= obj.num_bytes_total)
                data  = fread(obj.udpOBJ,obj.num_bytes_total);
                %flushinput(obj.udpOBJ);
                length_correct = (length(data) == obj.num_bytes_total);

                if length_correct
                    %unpack bytes into correct data types
                    data_unpacked = zeros(obj.num_value,1);
                    
                    window_start = 1;
                    for i = 1:obj.num_value
                        window_end = window_start + obj.byte_per_value(i) - 1;
                        data_cast = cast(data(window_start:window_end),'uint8');
                        data_unpacked(i) = typecast(data_cast,obj.value_format{i});
                        window_start = window_end + 1;
                    end
                else
                   data_unpacked = [];
                   %fprintf('[\bIncorrect packet length. ]\b\n'); 
                end
                
            else
                %fprintf('[\bNo UDP data available. ]\b\n');
                length_correct = 0;
                data_unpacked = [];
            end
            
        end
        