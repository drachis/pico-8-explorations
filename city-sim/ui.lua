-- ui.lua
function init_ui()
    cursor_x = flr(map_width / 2)
    cursor_y = flr(map_height / 2)
    selected_zone_type = 1 -- Default to Residential
    day_of_week = 1 -- Start with Monday
    hour_of_day = 0
    day_timer = 0
end

function update_cursor()
    if btnp(2) then cursor_y = max(1, cursor_y - 1) end -- Up
    if btnp(3) then cursor_y = min(map_height, cursor_y + 1) end -- Down
    if btnp(0) then cursor_x = max(1, cursor_x - 1) end -- Left
    if btnp(1) then cursor_x = min(map_width, cursor_x + 1) end -- Right
end

function update_time()
    day_timer += 1
    if day_timer >= 30 then -- 1 second in real time
        day_timer = 0
        hour_of_day = (hour_of_day + 1) % 24
        if hour_of_day == 0 then
            day_of_week = (day_of_week % 7) + 1 -- Cycle through days
        end
    end
end

function draw_cursor()
    rect((cursor_x-1)*8, (cursor_y-1)*8, cursor_x*8-1, cursor_y*8-1, 7)
end

function draw_ui()
    print("Money: "..money, 0, 0, 7)
    print("Population: "..population, 0, 10, 7)
    print("Demand - R: "..demand_R.." C: "..demand_C.." I: "..demand_I, 0, 20, 7)
    local zone_name = ""
    if selected_zone_type == 1 then
        zone_name = "Residential"
    elseif selected_zone_type == 2 then
        zone_name = "Commercial"
    elseif selected_zone_type == 3 then
        zone_name = "Industrial"
    elseif selected_zone_type == 4 then
        zone_name = "Road"
    end
    print("Selected: "..zone_name, 0, 30, 7)
    local days = {"M", "T", "W", "H", "F", "S", "U"}
    print("Day: "..days[day_of_week], 112, 0, 7)
    print("Time: "..string.format("%02d", hour_of_day)..":00", 112, 10, 7)
end