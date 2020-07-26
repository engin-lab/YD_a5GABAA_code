% Yuki's performance code part 2

clear;
animID = 'EE9';
task_num = [1 2 3 4 5 6 7 8 9 9.5 10 11 11.5 12];
day = {'01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15', '16', '17'}; % '11', '12', '13', '14', '15'

total_task = numel(task_num);
total_day = numel(day);

session_num_for_a_task = zeros(1,total_task);
col_n = 0;

for i = 1:total_day
    current_FileName = animID + "performance" + day(i) + ".mat";
    load(current_FileName);
    epoch = numel(perform{1,i});
        for a = 1:epoch
            if perform{1,i}{1,a}.type == "Track"
                col_n = col_n + 1;
                [row_n, x] = size(perform{1,i}{1,a}.performance);
                performance_correct(1:row_n, col_n) = perform{1,i}{1,a}.performance(:,1);
                performance_trajectory(1:row_n, col_n) = perform{1,i}{1,a}.performance(:,2);
                j = find(task_num == perform{1,i}{1,a}.task_num);
                session_num_for_a_task(1,j) = session_num_for_a_task(1,j) + 1;
                session_num_for_a_task(2,j)=sum(session_num_for_a_task(1,1:j));
            else
                continue
            end
        end
end


total_task = numel(task_num);

for t = 1:total_task
    
    if t == 1
        start_session_num = 1;
        end_session_num = session_num_for_a_task(2,t);    
    else
        start_session_num = session_num_for_a_task(2,t-1)+1;
        end_session_num = session_num_for_a_task(2,t);
    end
    
    performance = [];
    for n = start_session_num:end_session_num
        trial_num = numel(find(performance_trajectory(:,n)));
        session_performance = [performance_correct(1:trial_num,n),performance_trajectory(1:trial_num,n)];
        performance = [performance;session_performance];
    end

    file_name = strcat(animID,'task',num2str(task_num(t)),'performance.mat');
    save(file_name,'performance');
end
