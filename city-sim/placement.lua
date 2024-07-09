local placement = {}

function placement.place_zone(x, y, zone_type)
    if map.grid[y][x] == 0 then -- Check if the cell is empty
        map.grid[y][x] = zone_type
        if zone_type == "R" then
            resources.adjust_resources_for_new_zone("R")
        elseif zone_type == "C" then
            resources.adjust_resources_for_new_zone("C")
        elseif zone_type == "I" then
            resources.adjust_resources_for_new_zone("I")
        end
    end
end

function placement.update_placement()
    if btnp(4) then -- Button 1 for select/confirm
        placement.place_zone(cursor_x, cursor_y, selected_zone_type)
    elseif btnp(5) then -- Button 2 for cancel/deselect
        selected_zone_type = nil
    end
end

function placement.draw_zones()
    for y=1, map.height do
        for x=1, map.width do
            if map.grid[y][x] ~= 0 then
                spr(map.grid[y][x], x*8, y*8)
            end
        end
    end
end

return placement
