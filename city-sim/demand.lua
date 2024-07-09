local demand = {}

function demand.init_demand()
    demand.R = 50
    demand.C = 50
    demand.I = 50
end

function demand.update_demand()
    demand.R = 50 + (demand.map_count("R") - demand.map_count("C")) * 2
    demand.C = 50 + (demand.map_count("C") - demand.map_count("I")) * 2
    demand.I = 50 + (demand.map_count("I") - demand.map_count("R")) * 2
end

function demand.map_count(zone_type)
    local count = 0
    for y=1, map.height do
        for x=1, map.width do
            if map.grid[y][x] == zone_type then
                count += 1
            end
        end
    end
    return count
end

return demand
