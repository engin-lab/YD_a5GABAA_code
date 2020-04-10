%% Convert from pixel to mm
% Load the projected position data
mat_filename_dir = uigetdir(pwd, 'Select a folder'); %select data directory
file = dir(fullfile(mat_filename_dir, '*Track_*.mat')); %load all the .mat projected positions
file_num = numel(file);

for i = 1:file_num  % go through each file and load the data from it (need to change the file directory here)
    current_filename = file(i).name;
    file_dir = strcat('/Users/yuki/Desktop/EE2627/linearizedposdata/',current_filename);
    load(file_dir);  
    fprintf('%s;\n',current_filename);
    
% create a result matrix, 1 represents moving away from home, -1 is the opposite 
%pos_mm = 0.2954 * pos_filter; % Sleep conversion: 280 mm / 948 pixel = 0.2954 mm/pixel
%pos_mm = 0.7177 * pos_filter; % Novel conversion: 400 mm / 557.335 pixel = 0.7177 mm/pixel
%pos_mm = 0.8214 * pos_filter; % LT conversion: 800 mm / 974 pixel = 0.8214 mm/pixel
linpos_mm = 0.4864 * linpos; % Track conversion: 430 mm / 884 pixel = 0.4864 mm/pixel

filename_prefix = char(strrep(current_filename,'.mat','_mm.mat'));
save(filename_prefix,'linpos_mm');
end
