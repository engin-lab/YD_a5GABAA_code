%Visualize trajectory assigning results
%Load trajectory and projectedposdata of the coresponding animal first (for trajectory and pos)

img = imread('Track.png');
imshow(img);

hold on 

for n = 1:length(trajectory)
    color = 'g';
    if trajectory(n) == 1
        % yellow %
       color = 'y';
    elseif trajectory(n) == 2
        % blue %
       color = 'b';
    elseif trajectory(n) == 3
        % magenta %
        color = 'm';
    elseif trajectory(n) == 4
        color = 'k';
        % red %
    elseif trajectory(n) == -1
        color = 'r';
    end
    plot(pos(n, 1), pos(n, 2), 'Marker','o','MarkerFaceColor',color);
    % uncomment this line to show the dynamic movement%
    pause(0.003);
end