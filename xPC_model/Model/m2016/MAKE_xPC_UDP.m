function MAKE_xPC_UDP(model_name)
if nargin<1
    model_name = 'xPC_UDP';
end
current_dir = pwd;
XPCUDP_DEPENDENCY;
SETUP_BUILD_PATH('XPCUDPDIR');
model_path = getenv('XPCUDPDIR');
cd(model_path);
fprintf('Start to build model.\n');
slbuild(model_name);
cd(current_dir);
end

