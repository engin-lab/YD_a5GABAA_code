% coordinate of center %
cx = 1116;
cy = 1136;
% read the position matrix %
mat_filename_dir = uigetdir(pwd, 'Select a folder');
file = dir(fullfile(mat_filename_dir, '*Track*.mat'));
file_num = numel(file);

% result %

for j = 1:file_num
    current_filename = file(j).name;
    file_dir = strcat('/Users/yuki/Desktop/EE2627/projectedposdata/',current_filename);
    load(file_dir); 
    
    linpos = zeros([length(pos_filter), 2]);    
    
    for i = 1:length(pos_filter)
        x_ave(i) = (pos_filter(i,1)+pos_filter(i,3))/2;
        y_ave(i) = (pos_filter(i,2)+pos_filter(i,4))/2;
        x = x_ave(i) - cx;
        y = y_ave(i) - cy;
        % distance between current position and center %
        dis = sqrt(x*x + y*y);
        % angle formed between x-axis, center, and position%
        ang = radtodeg(acos(x / dis));
        % we want to map the angle in range of 0-360 %
        if (y > 0) 
            ang = 360 - ang;
        end
        if ang <= 326.75 && ang > 213.75
            ang = pi * 1.5;
        elseif ang <= 213.75 && ang > 135
            ang = pi * 0.875;
        elseif ang <= 135 && ang > 90
            ang = pi * 0.625;
        elseif ang <= 90 && ang > 45
            ang = pi * 0.375;
        else 
            ang = pi * 0.125;
        end
    
        linpos(i, 1) = cx + dis * cos(ang);
        linpos(i, 2) = cy - dis * sin(ang);
    end
    
filename_prefix = char(strrep(current_filename,'_posfiltered.mat','_linpos.mat'));
save(filename_prefix,'linpos');

end
