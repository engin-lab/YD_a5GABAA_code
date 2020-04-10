% read the position matrix %
mat_filename_dir = uigetdir(pwd, 'Select a folder');
file = dir(fullfile(mat_filename_dir, '*.mat'));
file_num = numel(file);

for j = 1:file_num
    current_filename = file(j).name;
    file_dir = strcat('/Users/yuki/Desktop/EE2627/posfiltered/EE2627/Track/',current_filename);
    png_name = strcat(current_filename,'.png');
        
    if exist(png_name,'file')
        fprintf(strcat('skipping',png_name,'\n'));
    else
    load(file_dir);
    
    imshow(imread('Track.png'));hold on;
    plot(pos_f(:,1),pos_f(:,2));
    title(current_filename);
    

    saveas(gcf, png_name);
    end
end