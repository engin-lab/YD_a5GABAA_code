mat_filename_dir = uigetdir(pwd, 'Select a folder');
file = dir(fullfile(mat_filename_dir, '*.videoPositionTracking'));
file_num = numel(file);

for i = 1:file_num
    current_filename = file(i).name;
    file_dir = strcat('/Users/yuki/Desktop/re-track/videoPositionTracking/',current_filename);
    readTrodesExtractedDataFile(file_dir);
    
    filename_prefix = char(strrep(current_filename,'.videoPositionTracking','.mat'));
    save(filename_prefix,'ans');
end