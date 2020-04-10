%Image projection
%Project the position data of every frame of the experimental video to the
%box/track positions
clear;
load('/Users/yuki/Desktop/EE2627/frames/Track frame1/track cordi.mat')

% read the position matrix %
mat_filename_dir = uigetdir(pwd, 'Select a folder');
file = dir(fullfile(mat_filename_dir, '*Track_*.mat'));
file_num = numel(file);

for j = 1:file_num
    current_filename = file(j).name;
    file_dir = strcat('/Users/yuki/Desktop/EE2627/posfiltered/EE2627/',current_filename);
    load(file_dir); 
    
    N = length(pos_filter);
    x1_new = zeros(N,1);
    y1_new = zeros(N,1);
    x2_new = zeros(N,1);
    y2_new = zeros(N,1);
        
    fixedPoints = [1036,2076;2016,848;1548,296;824,236;272,708]; %Track
    %fixedPoints = [1254,880;1252,316;308,318;308,876]; %Sleep
    %fixedPoints = [196,1150;334,1152;332,176;194,176]; %LT
    %fixedPoints = [802.667,189.333;244,189.333;244,746.667;802.667,746.667]; %NOR
    movingPoints = [x(1,j),y(1,j);x(2,j),y(2,j);x(3,j),y(3,j);x(4,j),y(4,j);x(5,j),y(5,j)];

    tform = fitgeotrans(movingPoints, fixedPoints, 'projective');   
        
    for n = 1:N
    
        x1_old = double(pos_filter(n,1));
        y1_old = double(pos_filter(n,2));
        x2_old = double(pos_filter(n,3));
        y2_old = double(pos_filter(n,4));
        [x1_new(n,1),y1_new(n,1)] = transformPointsForward(tform, x1_old, y1_old);
        [x2_new(n,1),y2_new(n,1)] = transformPointsForward(tform, x2_old, y2_old);

    end
    
    pos_f = [x1_new,y1_new,x2_new,y2_new];
    filename_prefix = char(strrep(current_filename,'_posfiltered.mat','_posf.mat'));
    save(filename_prefix,'pos_f');
end
