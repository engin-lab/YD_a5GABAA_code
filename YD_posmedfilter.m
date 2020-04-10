%1D medium filter for position data

% read the position matrix %
clear;
mat_filename_dir = uigetdir(pwd, 'Select a folder');
file = dir(fullfile(mat_filename_dir, '*.mat'));
file_num = numel(file);

for j = 1:file_num
    current_filename = file(j).name;
    file_dir = strcat('/Users/yuki/Desktop/EE2627 retrack/cameramodule/pos/pos/',current_filename);
    load(file_dir); 
    
s = size(data);

pos_filter = zeros(s);

pos_filter(:,1) = medfilt1(double(data(:,1)),9);
pos_filter(:,2) = medfilt1(double(data(:,2)),9);
pos_filter(:,3) = medfilt1(double(data(:,3)),9);
pos_filter(:,4) = medfilt1(double(data(:,4)),9);


filename_prefix = char(strrep(current_filename,'_pos.mat','_posfiltered.mat'));
save(filename_prefix,'pos_filter');
end
