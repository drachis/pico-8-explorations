local ui = {}

function ui.init_ui()
    ui.cursor_x, ui.cursor_y = 1, 1
end

function ui.update_cursor()
    if btnp(0) then ui.cursor_y -= 1 end
    if btnp(1) then ui.cursor_y += 1 end
    if btnp(2) then ui.cursor_x -= 1 end
    if btnp(3) then ui.cursor_x += 1 end

    ui.cursor_x = mid(1, ui.cursor_x, map.width)
    ui.cursor_y = mid(1, ui.cursor_y, map.height)
end

function ui.draw_cursor()
    rect(ui.cursor_x * 8, ui.cursor_y * 8, ui.cursor_x * 8 + 7, ui.cursor_y * 8 + 7, 7)
end

function ui.draw_ui()
    print("Money: "..resources.money, 0, 0)
    print("Population: "..resources.population, 0, 10)
    print("Demand - R: "..demand.R.." C: "..demand.C.." I: "..demand.I, 0, 20)
end

return ui
