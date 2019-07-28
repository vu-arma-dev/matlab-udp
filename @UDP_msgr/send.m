function send(obj,data)
% UDP_msgr.send()
% Send a UDP packet to the remote port. The packet to be
% sent is defined by the UDP_msgr constructor.

%Pack data into an array of bytes
if length(data) ~= obj.num_value
   error('Length of data is incorrect'); 
end

data_packed = zeros(obj.num_bytes_total,1);

window_start = 1;
for i = 1:obj.num_value
    window_end = window_start + obj.byte_per_value(i) - 1;
    data_cast = cast(data(i),obj.value_format{i});
    data_packed(window_start:window_end) = typecast(data_cast,'uint8');
    window_start = window_end + 1;        
end

fwrite(obj.udpOBJ,data_packed,'uint8');
end
