function plot_path(map, traj,start, goal)
d=size(map);
hold on;
for x=1:d(1)
    for y=1:d(2)
        for z=1:d(3)
            if (map(x,y,z)==1)
                plot3(x,y,z,'*');
            end
        end
    end
end
n1 = goal(1);
n2 = goal(2);
n3 = goal(3);
plot3(n1,n2,n3,'Marker','o','MarkerFaceColor','red');
while(~isequal(traj{n1,n2,n3},start))
    plot3(traj{n1,n2,n3}(1),traj{n1,n2,n3}(2),traj{n1,n2,n3}(3),'Marker','o','MarkerFaceColor','red');
	n1_temp=traj{n1,n2,n3}(1);
    n2_temp=traj{n1,n2,n3}(2);
    n3_temp=traj{n1,n2,n3}(3);
    n1 = n1_temp;
    n2 = n2_temp;
    n3 = n3_temp;
end
plot3(traj{n1,n2,n3}(1),traj{n1,n2,n3}(2),traj{n1,n2,n3}(3),'Marker','o', 'MarkerFaceColor','red');
hold on;
end