%Yuki's performance analysis part 4

clear;
mat_filename_dir = uigetdir(pwd, 'Select a folder'); %select data directory
file = dir(fullfile(mat_filename_dir, '*.mat')); %load all the .mat projected positions
file_num = numel(file);

for i = 1:file_num  % go through each file and load the data from it (need to change the file directory here)
    current_filename = file(i).name;
    fprintf('%s;\n',current_filename);
    %pos_file_dir = strcat('/Volumes/YukiBackup/eeyd_a5GABA_Project/VideosAnalyzed/posDATA/data/projectedposdata_mm/',current_filename);
    pos_file_dir = strcat('Users/yuki/Desktop/Task_performance/',current_filename);
    load(pos_file_dir);  

    task_n = numel(task_perform);
    for j = 1:task_n
        if isempty(task_perform{1, j}.performance(:,1)) == 1
            continue
        else
        rew_col = task_perform{1, j}.performance(:,1);

        [performance_curve, n_to_LP] = getestprobcorrect(rew_col, 0.25, 0);
        
        %figure_fileName = strcat(char(strrep(current_filename,'_performance.mat','')), num2str(task_perform{1, j}.task_num),'performance_curve.png')
        %saveas(gcf,figure_fileName);
        close(gcf);
        
        n_to_70PP = find(performance_curve(1:end,1)>0.7);

        n_to_70PP = min(n_to_70PP);
       
        n_to_5CC = numel(task_perform{1, j}.performance)/2;
        
        if isempty(n_to_70PP) == 1
            n_to_70PP = n_to_5CC;
        end
        
        task_perform{1, j} = struct('gender', task_perform{1, j}.gender, 'genotype', task_perform{1, j}.genotype, 'env', task_perform{1, j}.env, 'type', task_perform{1, j}.type, 'task_num', task_perform{1, j}.task_num, 'task_cue', task_perform{1, j}.task_cue,...
                'correct_arm', task_perform{1, j}.correct_arm, 'arms_blocked', task_perform{1, j}.arms_blocked, 'floor', task_perform{1, j}.floor, 'performace_fields', task_perform{1, j}.performace_fields,'performance', task_perform{1, j}.performance,...
                'n_to_LP', n_to_LP, 'n_to_70PP', n_to_70PP, 'n_to_5CC', n_to_5CC);    
            
    end
    filename_prefix = char(strrep(current_filename,'.mat','_new.mat'));
    save(filename_prefix,'task_perform');
    end
end

