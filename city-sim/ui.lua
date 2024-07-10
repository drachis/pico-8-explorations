-- ui.lua
function init_ui()
    cursor_x = flr(map_width / 2)
    cursor_y = flr(map_height / 2)
    selected_zone_type = RESIDENTIAL -- Default to Residential
end

function update_cursor()
    if btnp(2) then cursor_y = max(1, cursor_y - 1) end -- Up
    if btnp(3) then cursor_y = min(map_height, cursor_y + 1) end -- Down
    if btnp(0) then cursor_x = max(1, cursor_x - 1) end -- Left
    if btnp(1) then cursor_x = min(map_width, cursor_x + 1) end -- Right
end

function draw_cursor()
    rect((cursor_x-1)*8, (cursor_y-1)*8, cursor_x*8-1, cursor_y*8-1, 7)
end

function draw_ui()
    print("Money: "..money, 0, 0, 7)
    print("Population: "..population, 0, 10, 7)
    print("Demand - R: "..demand_R.." C: "..demand_C.." I: "..demand_I, 0, 20, 7)
    local zone_name = ""
    if selected_zone_type == RESIDENTIAL then
        zone_name = "Residential"
    elseif selected_zone_type == COMMERCIAL then
        zone_name = "Commercial"
    elseif selected_zone_type == INDUSTRIAL then
        zone_name = "Industrial"
    elseif selected_zone_type == 4 then
        zone_name = "Road"
    elseif selected_zone_type == 5 then
        zone_name = "Clear"
    end
    print("Selected: "..zone_name, 0, 30, 7)
end
