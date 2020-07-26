%%
%analyze 2-arm choices across genotype groups
%middle-arm blocked (arm 1 vs 4)
%side-arm blocked (arm 2 vs 3)

clear;
mat_filename_dir = uigetdir(pwd, 'Select a folder'); %select data directory
file = dir(fullfile(mat_filename_dir, '*.mat')); %load all the .mat projected positions
file_num = numel(file);

n_5CC_2vs3_FFn = [];
n_5CC_2vs3_FFp = [];
n_5CC_1vs4_FFn = [];
n_5CC_1vs4_FFp = [];  
        
for i = 1:file_num  % go through each file and load the data from it (need to change the file directory here)
    current_filename = file(i).name;
    fprintf('%s;\n',current_filename);
    %pos_file_dir = strcat('/Volumes/YukiBackup/eeyd_a5GABA_Project/VideosAnalyzed/posDATA/data/projectedposdata_mm/',current_filename);
    pos_file_dir = strcat('Users/yuki/Desktop/Task_performance/',current_filename);
    load(pos_file_dir);  
    animID = (char(strrep(current_filename,'task_performance_new.mat','')))
        
    task_n = numel(task_perform);
    for j = 1:task_n
        if task_perform{1,j}.genotype == "FF-";
            if task_perform{1,j}.arms_blocked == "Side Arms"
                n_5CC_2vs3_FFn = [n_5CC_2vs3_FFn;task_perform{1, j}.n_to_5CC];  
            elseif task_perform{1,j}.arms_blocked == "Middle Arms"
                n_5CC_1vs4_FFn = [n_5CC_1vs4_FFn;task_perform{1, j}.n_to_5CC];
            else
                continue
            end 
        elseif task_perform{1,j}.genotype == "FF+";
            if task_perform{1,j}.arms_blocked == "Side Arms"
                n_5CC_2vs3_FFp = [n_5CC_2vs3_FFp;task_perform{1, j}.n_to_5CC];  
            elseif task_perform{1,j}.arms_blocked == "Middle Arms"
                n_5CC_1vs4_FFp = [n_5CC_1vs4_FFp;task_perform{1, j}.n_to_5CC];
            else
                continue
            end 
        else
            continue
        end
    end 
end
        ave_n_5CC_2vs3_FFn = (sum(n_5CC_2vs3_FFn))/6;
        ave_n_5CC_2vs3_FFp = (sum(n_5CC_2vs3_FFp))/6;
        ave_n_5CC_1vs4_FFn = (sum(n_5CC_1vs4_FFn))/6;
        ave_n_5CC_1vs4_FFp = (sum(n_5CC_1vs4_FFp))/6; 
        
        figure(1);
        b = bar([ave_n_5CC_2vs3_FFn ave_n_5CC_2vs3_FFp; ave_n_5CC_1vs4_FFn ave_n_5CC_1vs4_FFp]);
        title('Number to criteria in the 2-arm choice task');
        set(gca, 'XTickLabel',{'arm 2 vs 3',' arm 1 vs 4'});
        legend('FF-','FF+');
       
        savefig(gcf,'N_to_criteria_2-armtask.fig');
        
        twoarm_table = [n_5CC_2vs3_FFn,n_5CC_2vs3_FFp,n_5CC_1vs4_FFn,n_5CC_1vs4_FFp];
        twoarm_learning = twoarm_table(1:2:end,:);
        twoarm_reversal = twoarm_table(2:2:end,:);
        
        ave_n_5CC_2vs3_FFn_learning = (sum(twoarm_learning(:,1)))/6;
        ave_n_5CC_2vs3_FFp_learning = (sum(twoarm_learning(:,2)))/6;
        ave_n_5CC_1vs4_FFn_learning = (sum(twoarm_learning(:,3)))/6;
        ave_n_5CC_1vs4_FFp_learning = (sum(twoarm_learning(:,4)))/6;    
        
        figure(2);
        b = bar([ave_n_5CC_2vs3_FFn_learning ave_n_5CC_2vs3_FFp_learning; ave_n_5CC_1vs4_FFn_learning ave_n_5CC_1vs4_FFp_learning]);
        title('Number to criteria in the 2-arm choice task (learning)');
        set(gca, 'XTickLabel',{'arm 2 vs 3',' arm 1 vs 4'});
        legend('FF-','FF+');
        savefig(gcf,'N_to_criteria_2-armtask_learning.fig');
        
        ave_n_5CC_2vs3_FFn_reversal = (sum(twoarm_reversal(:,1)))/6;
        ave_n_5CC_2vs3_FFp_reversal = (sum(twoarm_reversal(:,2)))/6;
        ave_n_5CC_1vs4_FFn_reversal = (sum(twoarm_reversal(:,3)))/6;
        ave_n_5CC_1vs4_FFp_reversal = (sum(twoarm_reversal(:,4)))/6;  
        
        figure(3);
        b = bar([ave_n_5CC_2vs3_FFn_reversal ave_n_5CC_2vs3_FFp_reversal; ave_n_5CC_1vs4_FFn_reversal ave_n_5CC_1vs4_FFp_reversal]);
        title('Number to criteria in the 2-arm choice task (reversal)');
        set(gca, 'XTickLabel',{'arm 2 vs 3',' arm 1 vs 4'});
        legend('FF-','FF+');
        savefig(gcf,'N_to_criteria_2-armtask_reversal.fig');
               
        %[p,tbl,stats] = anova1(twoarm_table);
        %[p2,tbl2,stats2] = anova1(twoarm_learning);
        %[p3,tbl3,stats3] = anova1(twoarm_reversal);
        
%%
%4-arm baseline

n_5CC_4arm_FFn = [];
n_5CC_4arm_FFp = [];
n_5CC_4arm_FFn = [];
n_5CC_4arm_FFp = [];  

for i = 1:file_num  % go through each file and load the data from it (need to change the file directory here)
    current_filename = file(i).name;
    fprintf('%s;\n',current_filename);
    %pos_file_dir = strcat('/Volumes/YukiBackup/eeyd_a5GABA_Project/VideosAnalyzed/posDATA/data/projectedposdata_mm/',current_filename);
    pos_file_dir = strcat('Users/yuki/Desktop/Task_performance/',current_filename);
    load(pos_file_dir);  
    animID = (char(strrep(current_filename,'task_performance_new.mat','')))
        
    task_n = numel(task_perform);
    for j = 1:task_n
        if task_perform{1,j}.genotype == "FF-";
            if task_perform{1,j}.arms_blocked == "None" 
                n_5CC_4arm_FFn = [n_5CC_4arm_FFn;task_perform{1, j}.n_to_5CC];  
            else
                continue
            end 
        elseif task_perform{1,j}.genotype == "FF+";
            if task_perform{1,j}.arms_blocked == "None" 
                n_5CC_4arm_FFp = [n_5CC_4arm_FFp;task_perform{1, j}.n_to_5CC];  
            else
                continue
            end 
        else
            continue
        end
    end 
end
        ave_n_5CC_4arm_FFn = (sum(n_5CC_4arm_FFn))/6;
        ave_n_5CC_4arm_FFp = (sum(n_5CC_4arm_FFp))/6;
        
        figure(1);
        b = bar([ave_n_5CC_4arm_FFn ave_n_5CC_4arm_FFp]);
        title('Number to criteria in the 4-arm task');
        legend('FF-','FF+');
       
        savefig(gcf,'N_to_criteria_4-armtask.fig');
        
        fourarm_table = [n_5CC_4arm_FFn,n_5CC_4arm_FFp];
        fourarm_learning = fourarm_table(1,:);
        fourarm_reversal = fourarm_table(2:end,:);
        
        ave_n_5CC_4arm_FFn_learning = (sum(fourarm_learning(:,1)))/6;
        ave_n_5CC_4arm_FFp_learning = (sum(fourarm_learning(:,2)))/6;
        
        figure(2);
        b = bar([ave_n_5CC_4arm_FFn_learning ave_n_5CC_4arm_FFp_learning]);
        title('Number to criteria in the 4-arm task (learning)');
        legend('FF-','FF+');
        savefig(gcf,'N_to_criteria_4-armtask_learning.fig');
        
        ave_n_5CC_4arm_FFn_reversal = (sum(fourarm_reversal(:,1)))/6;
        ave_n_5CC_4arm_FFp_reversal = (sum(fourarm_reversal(:,2)))/6;
        
        figure(3);
        b = bar([ave_n_5CC_4arm_FFn_reversal ave_n_5CC_4arm_FFp_reversal]);
        title('Number to criteria in the 4-arm task (reversal)');
        legend('FF-','FF+');
        savefig(gcf,'N_to_criteria_4-armtask_reversal.fig');
               
        %[p,tbl,stats] = anova1(twoarm_table);
        %[p2,tbl2,stats2] = anova1(twoarm_learning);
        %[p3,tbl3,stats3] = anova1(twoarm_reversal);

%%
%4-arm reversal


%%
%analyze cued vs uncued across genotype groups


%%
%analyze floored cue vs unfloored cue vs uncued across genotype

