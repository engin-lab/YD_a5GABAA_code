% This function generates numbers of trials and arm number associated with each trail
% Author: Zhaonan Li
% Input: file name of posdata
% Output: a matrix of size (n, 2). n is the length of posdata
%         column one represents the track number 1-4 or -1.
%         column two represents the trail number n, n >= 1.
%         The result will be stored at trial_info, make sure you have this
%         folder in your current directory.
clear;
mat_filename_dir = uigetdir(pwd, 'Select a folder'); %select data directory
file = dir(fullfile(mat_filename_dir, '*Track*.mat')); %load all the .mat projected positions
file_num = numel(file);


for i = 1:file_num  % go through each file and load the data from it (need to change the file directory here)
    current_filename = file(i).name;
    file_dir = strcat('/Users/yuki/Desktop/EE2627/projectedposdata/',current_filename);
    load(file_dir); 

    % n * 2 matrix, col1 is the average of x position, col2 is the average of y
    % position
    avg_pos = [sum(pos_filter(:,[1 3]), 2) / 2, sum(pos_filter(:,[2 4]), 2) / 2];

    % result, col1 is the track info, col2 is the number of trials
    traj_trials = zeros(length(avg_pos), 2);
    
    
    % auxiliary array used to store track number
    aux = zeros(length(avg_pos), 1);
    for i = 1:length(avg_pos)
        aux(i) = getTrackNumber(avg_pos(i,1), avg_pos(i,2));  
    end
        
    % find start and end indices of each trial
    % fisrt find segments separated when trial number == 0 (home)
    home_indices = find(aux==0);
    start_index = home_indices(1);
    end_index = home_indices(end);
    
    rest_of_start_indices = home_indices(find(diff(home_indices)>1)+1);
    rest_of_end_indices = home_indices(diff(home_indices)>1);
    
    rest_of_start_indices = rest_of_start_indices(:,1)';
    rest_of_end_indices = rest_of_end_indices(:,1)';
    
    start_indices = [start_index rest_of_start_indices];
    end_indices = [rest_of_end_indices end_index];
    
    % find the start and end indices of each trial
    home_indices = [start_indices' end_indices'];
    start_indices = floor(mean(home_indices, 2));
    end_indices = start_indices - 1;
    start_indices = [1; start_indices];
    end_indices = [end_indices; length(aux)];
    
    trial_indices = [start_indices end_indices];
    
%     disp(trial_indices);
    
    trial_num = 1;
    for t = 1:length(trial_indices)
        start_index = trial_indices(t, 1);
        end_index = trial_indices(t, 2);
        cur_trial = aux(start_index: end_index);
        
        if max(cur_trial) <= 0
            % aborted
            if sum(cur_trial == -2) > 0
                traj_trials(start_index: end_index, :) = -1;
            % not aborted
            else
                traj_trials(start_index: end_index, :) = 0;
            end
        else
            % count the occurrences of each track, pick the track with
            % greatest number of occurrence and assign that trial with that
            % number
            counter = zeros(1,4);
            for track = 1:4
                counter(track) = sum(cur_trial == track);
            end
            [max_counter, track] = max(counter); 
            traj_trials(start_index: end_index, 1) = track;
            traj_trials(start_index: end_index, 2) = trial_num;
            trial_num = trial_num + 1;
        end
    end     
        
    % replace track number of non-aborted trials
    aborted_indices = find(traj_trials(:, 2)==0);
    if length(aborted_indices) > 0
        aborted_start = aborted_indices(1);
        aborted_end = aborted_indices(end);

        rest_of_start_indices = aborted_indices(find(diff(aborted_indices)>1)+1);
        rest_of_end_indices = aborted_indices(diff(aborted_indices)>1);

        rest_of_start_indices = rest_of_start_indices(:,1)';
        rest_of_end_indices = rest_of_end_indices(:,1)';

        start_indices = [aborted_start rest_of_start_indices];
        end_indices = [rest_of_end_indices aborted_end];

        aborted_indices = [start_indices' end_indices'];

        for i = 1:size(aborted_indices, 1)
            start_index = aborted_indices(i, 1);
            end_index = aborted_indices(i, 2);
            % assign the non-aborted trial with the track number of next trial
            if end_index < length(traj_trials)
                traj_trials(start_index:end_index, 1) = traj_trials(end_index + 1, 1);
                traj_trials(start_index:end_index, 2) = traj_trials(end_index + 1, 2);
            else
                traj_trials(start_index:end_index, :) = -1;
            end
        end
    end
    
    %if visualize
    %    visualize_track_info(avg_pos, trials);
    %end
    
    filename_prefix = char(strrep(current_filename,'_posfiltered.mat','_traj_trials.mat'));
    save(filename_prefix,'traj_trials');
    
end