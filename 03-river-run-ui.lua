pico-8 cartridge // http://www.pico-8.com
version 42
__lua__

-- UI Module

-- UI properties
ui = {
    lives = 0,
    score = 0,
    fuel = 100
}

-- Initialize UI elements
function init_ui()
    ui.lives = jet.lives
    ui.score = jet.score
    ui.fuel = jet.fuel
end

-- Update UI elements
function update_ui()
    ui.lives = jet.lives
    ui.score = jet.score
    ui.fuel = jet.fuel
end

-- Render the UI
function draw_ui()
    -- Draw lives
    print("Lives: "..ui.lives, 2, 2, 7)
    
    -- Draw score
    print("Score: "..ui.score, 2, 10, 7)
    
    -- Draw fuel gauge
    rect(2, 18, 34, 26, 7) -- Border of fuel gauge
    rectfill(3, 19, 3 + ui.fuel * 0.3, 25, 8) -- Fuel level (adjust scale as necessary)
    print("Fuel", 2, 27, 7)
end

-- Initialization call
init_ui()
