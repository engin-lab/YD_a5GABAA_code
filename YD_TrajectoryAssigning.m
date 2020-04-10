% coordinate of center %
cx = 1116;
cy = 1136;
% radius of the circle %
r = 416;
% read the position matrix %
mat_filename_dir = uigetdir(pwd, 'Select a folder');
file = dir(fullfile(mat_filename_dir, '*Track.mat'));
file_num = numel(file);

for i = 1:file_num
    current_filename = file(i).name;
    file_dir = strcat('/Volumes/YukiBackup/eeyd_a5GABA_Project/VideosAnalyzed/posDATA/data/projectedposdata/',current_filename);
    load(file_dir); 
    
    % result %
    trajectory = zeros([length(pos), 1]);

    aux = zeros([length(pos), 1]);
        for i = 1:length(pos)
        x_ave(i) = (pos(i,1)+pos(i,3))/2;
        y_ave(i) = (pos(i,2)+pos(i,4))/2;
        aux(i) = getTrackNumber(x_ave(i), y_ave(i), cx, cy, r);
        end 

p1 = 1;
while p1 < length(pos)
    start = p1;
    while p1 < length(pos) && aux(p1) ~= -1
        p1 = p1 + 1;
    end
    while p1 < length(pos) && aux(p1) == -1
        p1 = p1 + 1;
    end
    if aux(p1) == 0 
        for j = start:p1
            trajectory(j) = -1;
        end
    else
        track = aux(p1);
        while p1 < length(pos) && aux(p1) ~= 0
            p1 = p1 + 1;
        end
        for j = start:p1
            trajectory(j) = track;
        end
    end
end

% i = 1;
% while i < length(M) && (res(i) ~= -1 || res(i) ~= 0)
%     i = i + 1;
% end
% track = res(i-1);
% for j = i:length(M)
%     res(j) = track;
% end


filename_prefix = char(strrep(current_filename,'.mat','_trajectory.mat'));
save(filename_prefix,'trajectory');

end

function f = isReturned(x, y)
if y >= 1776
    f = true;
    return;
else 
    f = false;
    return;
end
end

function f = getTrackNumber(x,y, cx, cy, r)
if y >= 1776
    f = 0;
    return;
end
if y <= cy
    dis = sqrt((x-cx)^2 + (y-cy)^2);
    if dis > r
        h = x - cx;
        ang = radtodeg(acos(h/dis));
        if (x >= cx)
            if (ang <= 45) 
                f = 1;
                return;
            else
                f = 2;
                return;
            end
        else
            if (ang <= 135)
                f = 3;
                return;
            else
                f = 4;
                return;
            end
        end
    else
        f = -1;
        return;
    end
end

f = -1;
end

