function map = load_map(filename, xy_res, z_res, margin)
% open the map file
F = fopen(filename);

% load it into C
C = textscan(F,'%s %n %n %n %n %n %n %n %*[^\n]','CommentStyle','%');

% extract boundary and block info
num_block = 0;
boundary = zeros(6);
block = zeros(10,6);
for m = 1:numel(C{1})
    if strcmp(C{1}(m),'boundary')
        for n = 1:6
            boundary(n) = C{n+1}(m);
        end
    else
        num_block = num_block + 1;
        for n = 1:6
            block(num_block,n) = C{n+1}(m);
        end
    end
end

% add the margins to the block
for n = 1:num_block
    for i = 1:3
        block(n,i) = block(n,i)-margin;
    end
    for i = 4:6
        block(n,i) = block(n,i)+margin;
    end
end

% split the map
num_x = (boundary(4)-boundary(1))/xy_res;
num_y = (boundary(5)-boundary(2))/xy_res;
num_z = (boundary(6)-boundary(3))/z_res;

%map           
map = zeros(num_x, num_y,num_z);
map = collide(map, block, xy_res, z_res, num_block);

                
end
