% read the timestamp matrix %
mat_filename_dir = uigetdir(pwd, 'Select a folder');
file = dir(fullfile(mat_filename_dir, '*.videoTimeStamps'));
file_num = numel(file);

% result %
for j = 1:file_num
    current_filename = file(j).name;
    [x,y] = readCameraModuleTimeStamps(current_filename); 
    
    timestamp = x;
    
    filename_prefix = char(strrep(current_filename,'.videoTimeStamps','_timestamp.mat'));
    save(filename_prefix,'timestamp');
end
