function data = receiveStringMsg(obj,dataArraySize)
data  = char(fread(obj.udpOBJ,dataArraySize,'char'));
end
