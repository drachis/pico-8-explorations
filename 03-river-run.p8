pico-8 cartridge // http://www.pico-8.com
version 42
__lua__

-- Main File

-- Game state
game_state = "playing"
game_over_timer = 0
high_score = 0

#include 03-river-run-utility.lua
#include 03-river-run-enviornment.lua

#include 03-river-run-player.lua
#include 03-river-run-enemies.lua
#include 03-river-run-fuel-depot.lua

#include 03-river-run-ui.lua

function _init()
    init_game()
end

function init_game()
    init_jet()
    init_environment()
    init_enemies()
    init_fuel_depots()
    init_ui()
    game_state = "playing"
    game_over_timer = 0
end

function _update()
    if game_state == "playing" then
        update_jet()
        update_environment()
        update_enemies()
        update_fuel_depots()
        update_ui()
        check_collisions()
        enemy_collisions()
        check_fuel_collisions()
        
        if jet.lives <= 0 then
            game_state = "game_over"
            game_over_timer = 300  -- 5 seconds at 60 FPS
            if jet.score > high_score then
                high_score = jet.score
            end
        end
    elseif game_state == "game_over" then
        game_over_timer = game_over_timer - 1
        if game_over_timer <= 0 then
            init_game()
        end
    end
end

function _draw()
    cls()
    if game_state == "playing" then
        draw_environment()
        draw_jet()
        draw_enemies()
        draw_fuel_depots()
        draw_ui()
    elseif game_state == "game_over" then
        draw_game_over()
    end
end

