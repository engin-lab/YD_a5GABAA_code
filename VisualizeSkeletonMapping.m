% Visualize skeleton mapping/linearization results
img = imread('Track.png');
imshow(img);
hold on 

for n = 1:18000
    %color = 'g';
    plot(linpos(n,1), linpos(n,2), 'Marker','o','MarkerFaceColor','blue');
    hold on
    plot(pos(n,1), pos(n,2), 'Marker','*','MarkerFaceColor','green');
    pause(0.003);
end