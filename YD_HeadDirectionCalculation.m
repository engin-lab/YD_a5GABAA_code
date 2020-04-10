%% Calculate head directions (in degrees)
% Load the projected position data
mat_filename_dir = uigetdir(pwd, 'Select a folder'); %select data directory
file = dir(fullfile(mat_filename_dir, '*.mat')); %load all the .mat projected positions
file_num = numel(file);

for i = 1:file_num  % go through each file and load the data from it (need to change the file directory here)
    current_filename = file(i).name;
    %file_dir = strcat('/Volumes/YukiBackup/eeyd_a5GABA_Project/VideosAnalyzed/posDATA/data/projectedposdata/',current_filename);
    file_dir = strcat('/Users/yuki/Desktop/EE2627/projectedposdata/',current_filename);
    load(file_dir);  
   
    headdirection = zeros([length(pos_filter) 1]);
    
    for m = 1:length(pos_filter)
        headdirection(m) = atan((pos_filter(m,2)-pos_filter(m,4))/(pos_filter(m,1)-pos_filter(m,3)))/pi*180;
    end    

filename_prefix = char(strrep(current_filename,'.mat','_headdirection.mat'));
save(filename_prefix,'headdirection');
end
