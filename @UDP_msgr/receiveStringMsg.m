function data = receiveStringMsg(obj,dataArraySize)
% This is deprecated.
data  = char(fread(obj.udpOBJ,dataArraySize,'char'));
end
