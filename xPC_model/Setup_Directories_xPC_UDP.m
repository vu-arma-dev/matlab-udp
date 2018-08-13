restoredefaultpath;
Model_path = getenv('XPCUDPDIR');
fprintf('Setting up all the directories ..')
root_dir = fileparts(Model_path);
addpath(genpath(root_dir));
rmpath(genpath([root_dir,filesep,'.git']));
fprintf('..[ok]\n');