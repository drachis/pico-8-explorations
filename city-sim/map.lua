-- map.lua
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

function is_developed(x, y)
    local zone_type = map_grid[y][x]
    return zone_type == 4 -- Road or any developed zone
end
