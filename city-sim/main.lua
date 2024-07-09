function _init()
    map = require("map")
    placement = require("placement")
    resources = require("resources")
    demand = require("demand")
    ui = require("ui")
    agents = require("agents")
    
    map.init_map()
    resources.init_resources()
    demand.init_demand()
    ui.init_ui()
end

function _update()
    ui.update_cursor()
    placement.update_placement()
    demand.update_demand()
    resources.update_resources()
    agents.update_agents()
end

function _draw()
    cls()
    map.draw_map()
    placement.draw_zones()
    ui.draw_cursor()
    ui.draw_ui()
end
