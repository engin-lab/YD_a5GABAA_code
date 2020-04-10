clear;
mat_filename_dir = uigetdir(pwd, 'Select a folder'); %select data directory
file = dir(fullfile(mat_filename_dir, '*.videoTimeStamps')); %load all the .mat projected positions
file_num = numel(file);

for i = 1:file_num  % go through each file and load the data from it (need to change the file directory here)
    current_filename = file(i).name;
    fprintf('%s;\n',current_filename);
    %pos_file_dir = strcat('/Volumes/YukiBackup/eeyd_a5GABA_Project/VideosAnalyzed/posDATA/data/projectedposdata_mm/',current_filename);
    pos_file_dir = strcat('Users/yuki/Desktop/EE2627Timestamp/',current_filename);
    [timestamp clockRate] = readCameraModuleTimeStamps(pos_file_dir);
    
    filename_prefix = char(strrep(current_filename,'.videoTimeStamps','_timestamp.mat'));
    save(filename_prefix,'timestamp');
end

