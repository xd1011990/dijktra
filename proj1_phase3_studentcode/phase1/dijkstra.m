function [traj, num_expanded] = dijkstra(map, start, goal, astar)
% DIJKSTRA Find the shortest path from start to goal.
%   PATH = DIJKSTRA(map, start, goal) returns an M-by-3 matrix, where each row
%   consists of the (x, y, z) coordinates of a point on the path.  The first
%   row is start and the last row is goal.  If no path is found, PATH is a
%   0-by-3 matrix.  Consecutive points in PATH should not be farther apart than
%   neighboring cells in the map (e.g.., if 5 consecutive points in PATH are
%   co-linear, don't simplify PATH by removing the 3 intermediate points).
%
%   PATH = DIJKSTRA(map, start, goal, astar) finds the path using euclidean
%   distance to goal as a heuristic if astar is true.
%
%   [PATH, NUM_EXPANDED] = DIJKSTRA(...) returns the path as well as
%   the number of points that were visited while performing the search.
if nargin < 4
    astar = false;
end

d = size(map);
dist = zeros(d(1),d(2),d(3));
%previous = zeros{d(1),d(2),d(3)};

Q = zeros(d(1),d(2),d(3));
% distance from source to source
dist(start(1),start(2),start(3)) = 0;
n=1;
for x = 1:d(1)
    for y = 1:d(2)
        for z = 1:d(3)
            if ~isequal(start,[x,y,z])
                dist(x,y,z) = 10000;
                previous{x,y,z} = NaN;
            end
            if map(x,y,z)==0
                Q(x,y,z) = 1;
            end
        end
    end
end

while ((~isequal(Q,zeros(d(1),d(2),d(3))))&&(Q(goal(1),goal(2),goal(3))))
    min_dis = 100000;
    min_label = NaN;
    for x = 1:d(1)
        for y = 1:d(2)
            for z = 1:d(3)
                if ((Q(x,y,z) == 1) && (min_dis > dist(x,y,z)))
                    min_dis = dist(x,y,z);
                    min_label = [x,y,z];
                end
            end
        end
    end
    Q(min_label(1),min_label(2),min_label(3)) = 0;
    
    if ((min_label(1)+1)<=d(1))
        if (Q(min_label(1)+1,min_label(2),min_label(3)) == 1) 
            alt = dist(min_label(1),min_label(2),min_label(3))+1;
            if (alt < dist(min_label(1)+1,min_label(2),min_label(3)))
                dist(min_label(1)+1,min_label(2),min_label(3)) = alt;
                previous{min_label(1)+1,min_label(2),min_label(3)} = min_label;
            end
        end
    end
    
    if ((min_label(1)-1)>0)
        if (Q(min_label(1)-1,min_label(2),min_label(3)) == 1) 
            alt = dist(min_label(1),min_label(2),min_label(3))+1;
            if (alt < dist(min_label(1)-1,min_label(2),min_label(3)))
                dist(min_label(1)-1,min_label(2),min_label(3)) = alt;
                previous{min_label(1)-1,min_label(2),min_label(3)} = min_label;
            end
        end
    end
    
    if ((min_label(2)+1)<=d(2))
        if (Q(min_label(1),min_label(2)+1,min_label(3)) == 1)
            alt = dist(min_label(1),min_label(2),min_label(3))+1;
            if (alt < dist(min_label(1),min_label(2)+1,min_label(3)))
                dist(min_label(1),min_label(2)+1,min_label(3)) = alt;
                previous{min_label(1),min_label(2)+1,min_label(3)} = min_label;
            end
        end
    end
    
    if ((min_label(2)-1)>0)
        if (Q(min_label(1),min_label(2)-1,min_label(3)) == 1) 
            alt = dist(min_label(1),min_label(2),min_label(3))+1;
            if (alt < dist(min_label(1),min_label(2)-1,min_label(3)))
                dist(min_label(1),min_label(2)-1,min_label(3)) = alt;
                previous{min_label(1),min_label(2)-1,min_label(3)} = min_label;
            end
            
        end
    end
    
    if ((min_label(3)+1)<=d(3))
        if (Q(min_label(1),min_label(2),min_label(3)+1) == 1) 
            alt = dist(min_label(1),min_label(2),min_label(3))+1;
            if (alt < dist(min_label(1),min_label(2),min_label(3)+1))
                dist(min_label(1),min_label(2),min_label(3)+1) = alt;
                previous{min_label(1),min_label(2),min_label(3)+1} = min_label;
            end
        end
    end
    
    if ((min_label(3)-1)>0)
        if (Q(min_label(1),min_label(2),min_label(3)-1) == 1) 
            alt = dist(min_label(1),min_label(2),min_label(3))+1;
            if (alt < dist(min_label(1),min_label(2),min_label(3)-1))
                dist(min_label(1),min_label(2),min_label(3)-1) = alt;
                previous{min_label(1),min_label(2),min_label(3)-1} = min_label;
            end
        end
    end
    n=n+1;
end

num_expanded = 1;
%path{num_expanded} = goal;
%s = goal;
%while (s~=start)
%num_expanded = num_expanded+1;
  %  path{num_expanded} = previous(s);
   % s = previous(s);
%end
traj = previous;
end
