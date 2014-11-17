function  map = collide(map, block, xy_res, z_res, num_block)
% COLLIDE Test whether points collide with an obstacle in an environment.
% map(x,y,z)= 1 if not collide with block, 0 if collide with a block.
d = size(map);

for n = 1:num_block
    x_start = ceil(block(n,1)/xy_res);
    if x_start == 0
        x_start = 1;
    end
    x_end = ceil(block(n,4)/xy_res);
    if x_end == 0
        x_end = 1;
    end
    y_start = ceil(block(n,2)/xy_res);
    if y_start == 0
        y_start = 1;
    end
    y_end = ceil(block(n,5)/xy_res);
    if y_end == 0
        y_end = 1;
    end
    z_start = ceil(block(n,3)/z_res);
    if z_start == 0
        z_start = 1;
    end
    z_end = ceil(block(n,6)/z_res);
    if z_end == 0
        z_end = 1;
    end
    for x = x_start:x_end
        for y = y_start:y_end
            for z = z_start:z_end
                map(x,y,z) = 1;
            end
        end
    end
end
end


