pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
-- Global variables
-- These are shared across all functions and define initial positions, speeds, and states for the ball and bat.
ball_x, ball_y = 64, 0            -- Ball's starting x and y coordinates
ball_radius = 2                  -- Radius of the ball
initial_ball_x, initial_ball_y = ball_x, ball_y   -- Store initial positions for resetting
ball_color = 7                   -- Color code for the ball (white)
ball_dx, ball_dy = 0, 2         -- Ball's movement speed in x and y directions

-- Player variables
player_x, player_y = 44, 116     -- Bat's starting x and y coordinates
bat_length = 30                  -- Length of the bat
bat_angle = -30                  -- Starting angle of the bat (negative to indicate left swing)
bat_swing_speed = 6              -- Speed at which the bat swings
bat_stop_angle = -30               -- Angle at which the bat stops swinging after a hit or strike
bat_swinging = false             -- Boolean flag to check if the bat is currently swinging
bat_hit = false                  -- Boolean flag to check if the bat has been hit by the ball

-- Ball variables
ball_active = true               -- Flag to determine if the ball is active in play
ball_result = ""                 -- String to store the result of a pitch (none, strike, hit, home_run)

function _init()
    bat_radius = 2  -- Define bat radius for collision detection
end

-- Function to update the ball's position based on its current velocity.
function update_ball()
    ball_x += ball_dx             -- Update x-coordinate by adding dx
    ball_y += ball_dy             -- Update y-coordinate by adding dy

    -- If the ball goes off-screen, reset it to its initial position.
    if ball_x < 0 or ball_x > 128 or ball_y < 0 or ball_y > 128 then
        reset_ball()
    end
end

-- Function to reset the ball to its initial state when it goes off-screen.
function reset_ball()
    ball_x = initial_ball_x       -- Reset x-coordinate
    ball_y = initial_ball_y       -- Reset y-coordinate
    ball_dx = 0                  -- Set horizontal speed (negative to move left)
    ball_dy = 2                   -- Set vertical speed (zero here but could be adjusted for gravity)
    ball_result = "none"          -- Clear the result of a previous pitch
    bat_swinging = false         -- Ensure the bat is not swinging after reset
    bat_hit = false               -- Reset hit status
    bat_angle = -45               -- Reset to starting angle for next swing
end

-- Function to update the bat's position and check for collisions with the ball.
function update_bat()
    if bat_swinging then           -- Check if the bat is currently swinging
        bat_angle += bat_swing_speed  -- Increment the bat angle to simulate a swing

        -- Check if there has been a collision between the bat and the ball.
        if not bat_hit and check_bat_ball_collision() then
            bat_hit = true         -- Set hit status to true
            bat_stop_angle = bat_angle + 10   -- Stop the bat at an angle slightly after impact

            -- Determine the outcome of the pitch.
            if ball_went_out_of_park then
                ball_result = "home_run"  -- If the ball goes out of the park, it's a home run
            else
                ball_result = "hit"       -- Otherwise, it's considered a hit
            end
        end

        -- If the bat has been hit and has reached its stop angle, stop the swing.
        if bat_hit and bat_angle >= bat_stop_angle then
            bat_swinging = false
        end

        -- If the bat has swung past a certain angle without hitting the ball, it's a strike.
        if bat_angle >= 90 then
            bat_swinging = false
            if not bat_hit then
                ball_result = "strike"   -- Set result to strike if no other outcome has been determined
            end
        end
    end
end

-- Function to check if there is a collision between the bat and the ball.
function check_bat_ball_collision()
    local angle = degrees_to_pico8_angle(bat_angle)  -- Convert bat angle to usable form for cosine/sine calculations

    -- Calculate the end coordinates of the bat
    local bat_end_x = player_x + cos(angle) * bat_length
    local bat_end_y = player_y + sin(angle) * bat_length

    -- Calculate the distance between the center of the ball and the end point of the bat
    local dx = bat_end_x - ball_x
    local dy = bat_end_y - ball_y
    local distance = sqrt(dx * dx + dy * dy)  -- Pythagorean theorem to find the distance

    -- Check for collision and set bat_hit to true if there's a collision
    if distance < ball_radius + bat_radius then
        bat_hit = true
    else
        bat_hit = false
    end
    
    return bat_hit  -- Return the value of bat_hit for possible further use
end

-- Helper function to convert degrees to a usable angle format for cosine/sine.
function degrees_to_pico8_angle(degrees)
    return degrees / 360  -- Convert degrees to a fraction of a full circle suitable for pico-8's trigonometric functions
end

-- Function to handle player input that starts the bat swing if not already swinging.
function player_input()
    if btnp(4) and not bat_swinging then   -- Check if button ❎ is pressed (assuming this is mapped for swinging)
        bat_swinging = true              -- Set swinging status to true
        bat_angle = -45                  -- Reset the bat angle to starting position
        bat_hit = false                  -- Clear any previous hit status
        ball_result = "none"             -- Ensure no result is set from a previous pitch
    end
end

-- Function to draw the bat on the screen based on its current swinging state.
function draw_bat()
    if bat_swinging or bat_angle ~= -45 then   -- Draw the bat if it's currently swinging or not at starting angle
        local angle = degrees_to_pico8_angle(bat_angle)  -- Convert bat angle to usable form for drawing
        local bat_end_x = player_x + cos(angle) * bat_length   -- Calculate end x-coordinate of the bat
        local bat_end_y = player_y + sin(angle) * bat_length   -- Calculate end y-coordinate of the bat

        line(player_x, player_y, bat_end_x, bat_end_y, 9)    -- Draw a line from bat's start to end using color code 9 (light brown)
    end
end

-- Main update function that handles all game updates each frame.
function _update()
    update_ball()     -- Update the ball's position
    update_bat()      -- Update the bat's position and check for collisions
    player_input()    -- Handle player input to start a swing if necessary
end

-- Main draw function that handles all visual updates each frame.
function _draw()
    cls(0)           -- Clear the screen with color code 0 (black)
    draw_bat()       -- Draw the bat on the screen based on its current state
    circfill(ball_x, ball_y, ball_radius, ball_color)   -- Draw the ball at its current position in the specified color
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
