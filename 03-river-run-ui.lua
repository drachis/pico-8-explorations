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
    
    -- Draw high score
    local high_score_text = "High Score: "..high_score
    local text_width = #high_score_text * 4 -- Approximate width calculation assuming each character is 4 pixels wide
    print(high_score_text, 128 - text_width - 2, 2, 7)
end

-- Render the game over screen
function draw_game_over()
    print("GAME OVER", 50, 60, 7)
    print("Your Score: "..jet.score, 40, 70, 7)
    print("High Score: "..high_score, 40, 80, 7)
end

-- Initialization call
init_ui()