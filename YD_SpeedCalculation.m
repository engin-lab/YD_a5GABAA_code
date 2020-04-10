clear
% Calculate speed in mm/s
% Load the projected position mm data
mat_filename_dir = uigetdir(pwd, 'Select a folder'); %select data directory
file = dir(fullfile(mat_filename_dir, '*.mat')); %load all the .mat projected positions
file_num = numel(file);

for i = 1:file_num  % go through each file and load the data from it (need to change the file directory here)
    current_filename = file(i).name;
    fprintf('%s;\n',current_filename);
    %pos_file_dir = strcat('/Volumes/YukiBackup/eeyd_a5GABA_Project/VideosAnalyzed/posDATA/data/projectedposdata_mm/',current_filename);
    pos_file_dir = strcat('/Users/yuki/Desktop/EE2627/linearizedposdata_mm/',current_filename);
    load(pos_file_dir);  
   
    %load the corresponding timestamp file
    timestamp_filename = char(strrep(current_filename,'_linpos_mm.mat','_timestamp.mat'));
    timestamp_file_dir = strcat('/Users/yuki/Desktop/EE2627/timestampdata/',timestamp_filename);
    load(timestamp_file_dir);  
    
    rawspeed = zeros([length(pos_mm) 1]);
    ave_x = zeros([length(pos_mm) 1]);
    ave_y = zeros([length(pos_mm) 1]);
    ave_x = (pos_mm(:,1)+pos_mm(:,3))/2;
    ave_y = (pos_mm(:,2)+pos_mm(:,4))/2;
    
    for m = 2:length(timestamp);
        rawspeed(m) = (sqrt((ave_x(m)-ave_x(m-1))^2 + (ave_y(m)-ave_y(m-1))^2))/(timestamp(m)-timestamp(m-1));
    end
filename_prefix = char(strrep(current_filename,'.mat','_rawspeed'));
save(filename_prefix,'rawspeed');
end
