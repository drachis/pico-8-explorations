-- resources.lua
function init_resources()
    money = 1000
    population = 0
end

function adjust_resources_for_new_zone(zone_type)
    if zone_type == 1 then -- Residential
        population += 10
    elseif zone_type == 2 or zone_type == 3 then -- Commercial or Industrial
        money += 100
    end
end

function update_resources()
    -- Implement any resource update logic here
end
