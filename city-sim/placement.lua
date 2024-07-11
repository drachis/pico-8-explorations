-- placement.lua

function place_tile(x, y, tile_type)
    -- Ensure we place a tile of the specified type
    map_grid[y][x] = tile_type
    -- Update all agent paths
    update_all_paths()
end

function remove_tile(x, y)
    -- Ensure we remove the tile
    map_grid[y][x] = 0
    -- Update all agent paths
    update_all_paths()
end

function update_all_paths()
    for agent in all(agents) do
        if agent.target then
            agent.path = find_path(agent.x, agent.y, agent.target.x, agent.target.y, map_grid)
        end
    end
end

function is_developed(x, y)
    local zone_type = map_grid[y][x]
    return zone_type == 4 or zone_type > 5 -- Road or any developed zone
end

function place_zone(x, y, zone_type)
    if (map_grid[y][x] == 0) or (zone_type ~= map_grid[y][x] and not is_developed(x, y)) then
        if map_grid[y][x] ~= 0 and is_developed(x, y) then
            -- Cost to remove a developed tile
            money -= 10
        end
        map_grid[y][x] = (zone_type == 5) and 0 or zone_type
        if zone_type ~= 5 then
            adjust_resources_for_new_zone(zone_type)
        end
    end
end

function update_placement()
    if btnp(4) then -- A button (Z) for select/confirm
        place_zone(cursor_x, cursor_y, selected_zone_type)
    elseif btnp(5) then -- B button (X) for rotate zone type
        selected_zone_type = (selected_zone_type % 5) + 1 -- Cycle through 1 to 4
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
                    rectfill((x-1)*8, (y-1)*8, x*8-1, y*8-1, 6) -- Grey for road
                elseif zone_type == 6 then -- Filled in residential
                    rectfill((x-1)*8, (y-1)*8, x*8-1, y*8-1, 11) -- Bright green for filled residential
                elseif zone_type == 7 then -- Filled in commercial
                    rectfill((x-1)*8, (y-1)*8, x*8-1, y*8-1, 12) -- Bright blue for filled commercial
                elseif zone_type == 9 then -- Filled in industrial
                    rectfill((x-1)*8, (y-1)*8, x*8-1, y*8-1, 9) -- Bright yellow for filled industrial
                end
            end
        end
    end
end
