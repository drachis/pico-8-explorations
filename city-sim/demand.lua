-- demand.lua
function init_demand()
    demand_R = 50
    demand_C = 50
    demand_I = 50
end

function update_demand()
    demand_R = 50 + (map_count(1) - map_count(2)) * 2
    demand_C = 50 + (map_count(2) - map_count(3)) * 2
    demand_I = 50 + (map_count(3) - map_count(1)) * 2
end

function map_count(zone_type)
    local count = 0
    for y=1, map_height do
        for x=1, map_width do
            if map_grid[y][x] == zone_type then
                count += 1
            end
        end
    end
    return count
end
