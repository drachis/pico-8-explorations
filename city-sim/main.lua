-- main.p8
#include map.p8
#include placement.p8
#include resources.p8
#include demand.p8
#include ui.p8
#include agents.p8

function _init()
    init_map()
    init_resources()
    init_demand()
    init_ui()
end

function _update()
    update_cursor()
    update_placement()
    update_demand()
    update_resources()
    update_agents()
end

function _draw()
    cls()
    draw_map()
    draw_zones()
    draw_cursor()
    draw_ui()
end
