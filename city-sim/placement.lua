-- placement.lua
function place_zone(x, y, zone_type)
    if map_grid[y][x] == 0 or zone_type == 5 then -- Clear the zone
        map_grid[y][x] = (zone_type == 5) and 0 or zone_type
        if zone_type ~= 5 then
            adjust_resources_for_new_zone(zone_type)
        end
    end
end

function update_placement()
    if btnp(4) then -- A button for select/confirm
        place_zone(cursor_x, cursor_y, selected_zone_type)
    elseif btnp(5) then -- B button for rotate zone type
        selected_zone_type = (selected_zone_type % 5) + 1
    end
end

function draw_zones()
    for y=1, map_height do
        for x=1, map_width do
            local zone_type = map_grid[y][x]
            if zone_type ~= 0 then
                if zone_type == 1 then
                    rectfill((x-1)*8, (y-1)*8, x*8-1, y*8-1, 3) -- Dark green for unpopulated residential
                elseif zone_type == 2 then
                    rectfill((x-1)*8, (y-1)*8, x*8-1, y*8-1, 1) -- Dark blue for unpopulated commercial
                elseif zone_type == 3 then
                    rectfill((x-1)*8, (y-1)*8, x*8-1, y*8-1, 8) -- Brown for unpopulated industrial
                elseif zone_type == 4 then -- Road
                    rectfill((x-1)*8, (y-1)*8, x*8-1, y*8-1, 7) -- Grey for road
                end
            end
        end
    end
end
