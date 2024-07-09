-- ui.p8
function init_ui()
    cursor_x = 1
    cursor_y = 1
    selected_zone_type = RESIDENTIAL -- Default to Residential
end

function update_cursor()
    if btnp(0) then cursor_y = max(1, cursor_y - 1) end
    if btnp(1) then cursor_y = min(map_height, cursor_y + 1) end
    if btnp(2) then cursor_x = max(1, cursor_x - 1) end
    if btnp(3) then cursor_x = min(map_width, cursor_x + 1) end
end

function draw_cursor()
    rect((cursor_x-1)*8, (cursor_y-1)*8, cursor_x*8-1, cursor_y*8-1, 7)
end

function draw_ui()
    print("Money: "..money, 0, 0, 7)
    print("Population: "..population, 0, 10, 7)
    print("Demand - R: "..demand_R.." C: "..demand_C.." I: "..demand_I, 0, 20, 7)
end
