% fix time reset gaps between epoches

% Load the timestamp data file
mat_filename_dir = uigetdir(pwd, 'Select a folder'); %select data directory
file = dir(fullfile(mat_filename_dir, '*.trodesComments')); %load all the .trodesComments files
file_num = numel(file);

for i = 1:file_num  % go through each file and load the data from it (need to change the file directory here)
    current_filename = file(i).name;
    
   
    
    %fprintf('%s;\n',current_filename);
    trodescomments_file_dir = strcat('/Users/yuki/Desktop/EE2627/EE2627Trodescomments/',current_filename);
    
    trodescomments = fileread(trodescomments_file_dir);  
    
    k = strfind(trodescomments,'time reset');
    
    if k == 1
        fprintf('%s has a time reset;\n',current_filename);
        
        filename_split = strsplit(current_filename,'_');
        day = str2double(filename_split(2));
        
    end
end