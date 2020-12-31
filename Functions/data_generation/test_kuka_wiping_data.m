%% Add path
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
addpath(genpath('../')); % add the library and it's subfolders to the path
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

%% User Input
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
DH = [0.0, 0.31, 0.0, pi/2; % Robot Kinematic model specified by the Denavit-Hartnbergh
      0.0, 0.0, 0.0, -pi/2;
      0.0, 0.4, 0.0, -pi/2;
      0.0, 0.0, 0.0, pi/2;
      0.0, 0.39, 0.0, pi/2;
      0.0, 0.0, 0.0, -pi/2;
      0.0, 0.21-0.132, 0.0, 0.0];
robot = SerialLink(DH); % Peters Cork robotics library has to be installed
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

%% Get data
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
fprintf(1,'Getting data ...\n');
%load('../data_generation/data_simulated.mat');
load('data_test_paper.mat');
%load('demonstrations_mat/data.mat');
NDem = length(x); % number of demonstrations
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

%% Compute end-effector position
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
fprintf(1,'Compute end-effector position ...\n');
p = cell(1, NDem); % end-effector cartesian position in global frame
getPos = @(q) transl(robot.fkine(q)); % compute end-effector postion
parfor idx=1:NDem
    p{idx} = getPos(cell2mat(x{idx}).'); % compute end-effector postion
end
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

%% Plot end-effector position
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
fprintf(1,'Plot end-effector position ...\n');
figure(); hold on;
for idx=1:NDem
    plot3(p{idx}(:,1),p{idx}(:,2),p{idx}(:,3));
end
hold off; axis equal;
xlabel('x'); ylabel('y'); zlabel('z');
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

%% Remove path
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
rmpath(genpath('../'));
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------