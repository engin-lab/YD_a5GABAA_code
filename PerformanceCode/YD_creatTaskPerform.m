% Yuki's performance code part 3

clear;
animID = 'EE15';
task = [1 2 3 4 5 6 7 8 9 10 11];
day = {'01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12'}; % '11', '12', '13', '14', '15', '16', '17'

total_task = numel(task);
total_day = numel(day);

session_num_for_a_task = zeros(1,total_task);

for i = 1:total_day
    current_FileName = animID + "performance" + day(i) + ".mat";
    load(current_FileName);
    epoch = numel(perform{1,i});
        for a = 1:epoch
            if perform{1,i}{1,a}.type == "Track"
                j = find(task == perform{1,i}{1,a}.task_num);
                gender = perform{1,i}{1,a}.gender; 
                genotype = perform{1,i}{1,a}.genotype; 
                env = perform{1,i}{1,a}.env; 
                type = perform{1,i}{1,a}.type;
                task_num = perform{1,i}{1,a}.task_num;
                task_cue = perform{1,i}{1,a}.task_cue;
                correct_arm = perform{1,i}{1,a}.correct_arm;
                arms_blocked = perform{1,i}{1,a}.arms_blocked;
                floor = perform{1,i}{1,a}.floor;
                performance_fields =perform{1,i}{1,a}.performace_fields;
                
                task_FileName = animID + "task" + num2str(task(j)) + "performance.mat";
                load(task_FileName);
                
                task_perform{1, j} = struct('gender', gender, 'genotype', genotype, 'env', env, 'type', type, 'task_num', task_num, 'task_cue', task_cue,...
                'correct_arm', correct_arm, 'arms_blocked', arms_blocked, 'floor', floor, 'performace_fields', performance_fields,'performance', performance);    
            else
                continue
            end
        end
end

    newFileName = animID + "task_performance.mat";
    save(newFileName, 'task_perform');