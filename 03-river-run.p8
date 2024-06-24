pico-8 cartridge // http://www.pico-8.com
version 42
__lua__

-- Main File

#include 03-river-run-utility.lua

#include 03-river-run-player.lua
#include 03-river-run-enviornment.lua

#include 03-river-run-enemies.lua
#include 03-river-run-fuel-depot.lua
#include 03-river-run-ui.lua

function _init()
    init_jet()
    init_environment()
    init_enemies()
    init_fuel_depots()
    init_ui()
end

function _update()
    update_jet()
    update_environment()
    update_enemies()
    update_fuel_depots()
    update_ui()
    enemy_collisions()
    check_fuel_collisions()
end

function _draw()
    cls()
    draw_environment()
    draw_jet()
    draw_enemies()
    draw_fuel_depots()
    draw_ui()
end
