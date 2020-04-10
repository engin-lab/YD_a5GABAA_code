%% Assign forward/backward directions for each point of the animal's position
% Load the projected position data
mat_filename_dir = uigetdir(pwd, 'Select a folder'); %select data directory
file = dir(fullfile(mat_filename_dir, '*.mat')); %load all the .mat projected positions
file_num = numel(file);

for i = 1:file_num  % go through each file and load the data from it (need to change the file directory here)
    current_filename = file(i).name;
    file_dir = strcat('/Users/yuki/Desktop/EE2627/projectedposdata/',current_filename);
    load(file_dir); 
   
% create a result matrix, 1 represents moving away from home, -1 is the opposite 
direction = zeros([length(pos_filter) 1]); 

for m = 1:length(pos_filter) - 1
    y = pos_filter(m, 2);
    nexty = pos_filter(m + 1, 2);
    if nexty > y 
        direction(m) = -1;
    else
        direction(m) = 1;
    end
end

% the direction of last position is by defualt 1(or -1)%
direction(length(pos_filter)) = 1;

direction = direction(:,1);

filename_prefix = char(strrep(current_filename,'_posfiltered.mat','_direction.mat'));
save(filename_prefix,'direction');
end
