% This script converts data in the current directory into NeuroQuery format %
% Output format: EE8pos01.mat , all saved in a folder named NQ-Pos %
% Author: Zhaonan Li zli@brandeis.edu %
% Created at Jan 29 2019 %

% file names % 
fileNames = load('/Users/yuki/Desktop/EE2627/EE2627posFileNames.mat');
fileNames = fileNames.res;

% metadata %
animDB = load('Users/yuki/Documents/animDB/animal_metadata_190421.mat');
animDB = animDB.animDB;

for i = 1:length(fileNames)
    fileName = fileNames(i,:);

    animal = fileName(1);
    day = str2double(fileName(2));
    epoch = str2double(fileName(3));
    animDBnum = str2double(fileName(4)); %the struct number of certain animal in animDB
    
    task = cell(1, day);

    for j=1:epoch
    
    gender = animDB(animDBnum).gender; 
    genotype = animDB(animDBnum).genotype; 
    env = animDB(animDBnum).recording_data(day).epochs(j).environment; 
    type = animDB(animDBnum).recording_data(day).epochs(j).epoch_type;
    task_num = animDB(animDBnum).recording_data(day).epochs(j).task_num;
    task_cue = animDB(animDBnum).recording_data(day).epochs(j).task_data.cued;
    correct_arm = animDB(animDBnum).recording_data(day).epochs(j).task_data.correct_arm;
    arms_blocked = animDB(animDBnum).recording_data(day).epochs(j).task_data.arms_blocked;
    floor = animDB(animDBnum).recording_data(day).epochs(j).task_data.floor;
    
    if type == "Track"
        
        task{1, day}{1, j} = struct('gender', gender, 'genotype', genotype, 'env', env, 'type', type, 'task_num', task_num, 'task_cue', task_cue,...
        'correct_arm', correct_arm, 'arms_blocked', arms_blocked, 'floor', floor);
    else
        task{1, day}{1, j} = struct('gender', gender, 'genotype', genotype, 'env', env, 'type', type);
    end
    end

    newFileName = fileName(1) + "task" + fileName(2) + ".mat";
    save(char('NQ-Task/' + newFileName), 'task');
end
