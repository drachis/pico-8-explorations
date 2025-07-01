function init_map()
    map_width = 20
    map_height = 15
    map_grid = {}
    for y=1, map_height do
        map_grid[y] = {}
        for x=1, map_width do
            map_grid[y][x] = 0 -- 0 represents empty cell
        end
    end
end

function draw_map()
    for y=1, map_height do
        for x=1, map_width do
            if map_grid[y][x] == 0 then
                rectfill((x-1)*8, (y-1)*8, x*8-1, y*8-1, 5) -- Empty cell
            end
        end
    end
end

function get_nearest_zone(x, y, z)
    local target_type = z
    local min_distance = math.huge
    local nearest_zone

    for i = 1, map_height do
        for j = 1, map_width do
            if map_grid[i][j] == target_type then
                local distance = abs(x - j) + abs(y - i)
                if distance < min_distance then
                    min_distance = distance
                    nearest_zone = {x = j, y = i}
                end
            end
        end
    end

    return nearest_zone
end

function is_adjacent_to_zone(x, y, z)
    -- x, y are coordinates of the zone
    -- z is the type of the zone
    return (x > 1 and map_grid[y][x-1] == z) or
           (x < map_width and map_grid[y][x+1] == z) or
           (y > 1 and map_grid[y-1][x] == z) or
           (y < map_height and map_grid[y+1][x] == z)
end

function get_nearest_zone(x, y, target_type)
    local min_distance = math.huge
    local nearest_zone

    for i = 1, map_height do
        for j = 1, map_width do
            if map_grid[i][j] == target_type then
                local distance = abs(x - j) + abs(y - i)
                if distance < min_distance then
                    min_distance = distance
                    nearest_zone = {x = j, y = i}
                end
            end
        end
    end

    return nearest_zone
end


function is_developed(x, y)
    local zone_type = map_grid[y][x]
    return zone_type == 4 or zone_type > 5 -- Road or any developed zone
end
