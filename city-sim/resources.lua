local resources = {}

function resources.init_resources()
    resources.money = 1000
    resources.population = 0
end

function resources.adjust_resources_for_new_zone(zone_type)
    if zone_type == "R" then
        resources.population += 10
    elseif zone_type == "C" or zone_type == "I" then
        resources.money += 100
    end
end

function resources.update_resources()
    -- Implement any resource update logic here
end

return resources
