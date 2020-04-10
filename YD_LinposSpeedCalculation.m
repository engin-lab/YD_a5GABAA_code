clear
% Convert from pixel to mm
% Load the projected position data
mat_filename_dir = uigetdir(pwd, 'Select a folder'); %select data directory
file = dir(fullfile(mat_filename_dir, '*.mat')); %load all the .mat projected positions
file_num = numel(file);

for i = 7:file_num  % go through each file and load the data from it (need to change the file directory here)
    current_filename = file(i).name;
    fprintf('%s;\n',current_filename);
    pos_file_dir = strcat('/Users/yuki/Desktop/EE2627/linearizedposdata_mm/',current_filename);
    load(pos_file_dir);  
   
    %load the corresponding timestamp file
    timestamp_filename = char(strrep(current_filename,'_linpos_mm.mat','_timestamp.mat'));
    timestamp_file_dir = strcat('/Users/yuki/Desktop/EE2627/timestampdata/',timestamp_filename);
    load(timestamp_file_dir);  
    
    linposspeed = zeros([length(linpos_mm) 1]);
    
    for m = 2:length(timestamp);
        linposspeed(m) = (sqrt((linpos_mm(m,1)-linpos_mm(m-1,1))^2 + (linpos_mm(m,2)-linpos_mm(m-1,2))^2))/(timestamp(m)-timestamp(m-1));
    end
filename_prefix = char(strrep(current_filename,'_linpos_mm.mat','_linposspeed.mat'));
save(filename_prefix,'linposspeed');
end