-- demand.lua
function init_demand()
    demand_R = 50
    demand_C = 50
    demand_I = 50
end

function update_demand()
    demand_R = 50 + (map_count(RESIDENTIAL) - map_count(COMMERCIAL)) * 2
    demand_C = 50 + (map_count(COMMERCIAL) - map_count(INDUSTRIAL)) * 2
    demand_I = 50 + (map_count(INDUSTRIAL) - map_count(RESIDENTIAL)) * 2
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