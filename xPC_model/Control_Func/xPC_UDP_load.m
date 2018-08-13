function tg =xPC_UDP_load(varargin)
%%  Loading the Belloscope program
%   By Long Wang
%%  parsing the information of target machine
loadDisabled = false;
if numel(varargin)
    for i = 1:2:numel(varargin)
        propertyName = varargin{i};
        propertyValue = varargin{i+1};
        if strcmp(propertyName,'no_load')
            loadDisabled = propertyValue;
        end
    end
end
%%  create target object
tg = create_ARMA_TargetObject('xPC_UDP');
if ~loadDisabled
    %     setxpcenv('TcpIpTargetAddress',address,'TcpIpTargetPort',port);
    fprintf('Loading application..');
    Model_Path = getenv('XPCUDPDIR');
    tg.set('CommunicationTimeOut',20);
    load(tg,[Model_Path,'/Build/xPC_UDP']);
    fprintf('..[ok]\n');
end

end