pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- Define the game elements as global variables for easy access
function create_bricks()
    local index = 1  -- Initialize index to keep track of brick positions in the array
    for y = 1, num_bricks_y do
        for x = 1, num_bricks_x do
            local brick = {
                x = (x - 1) * (brick_width + 2) + 8,  -- Calculate x position
                y = (y - 1) * (brick_height + 2) + 8, -- Calculate y position
                width = brick_width,
                height = brick_height,
                hit = false  -- Flag to check if brick is hit
            }
            bricks[index] = brick  -- Assign brick directly to the array
            index = index + 1  -- Increment the index for the next brick
        end
    end
end

game_over = false  -- Track whether the game is in a "game over" state

function _init()
    -- Initialize the paddle
    paddle = {
        x = 64,  -- Center the paddle on the screen
        y = 120, -- Position the paddle near the bottom of the screen
        width = 30,
        height = 4,
        speed = 3  -- Speed of the paddle movement
    }
    
    -- Initialize the ball
    ball = {
        x = 64,   -- Start in the middle of the screen
        y = 60,   -- Start in the middle of the screen vertically
        dx = 2,   -- Horizontal velocity of the ball
        dy = -2,  -- Vertical velocity of the ball
        size = 4
    }
    
    -- Initialize bricks
    bricks = {}
    brick_width = 12
    brick_height = 5
    num_bricks_x = 10  -- Number of bricks in a row
    num_bricks_y = 4   -- Number of rows of bricks
    
    -- Initialize score
    score = 0
    -- Setup the initial game state
    create_bricks()  -- Create the bricks for the breakout game

    -- Reset score
    score = 0
end

function _update()
    if not game_over then
        update_paddle()
        update_ball()
        check_collisions()
    else
        if btnp(4) then  -- Button 4 (Z) is pressed
            _init()  -- Reset the game
            game_over = false  -- Reset the game over flag
        end
    end
end


function update_paddle()
    if btn(0) and paddle.x > 0 then  -- Left arrow key
        paddle.x -= paddle.speed
    end
    if btn(1) and paddle.x < (128 - paddle.width) then  -- Right arrow key
        paddle.x += paddle.speed
    end
end

function update_ball()
    -- Update ball position
    ball.x += ball.dx
    ball.y += ball.dy

    -- Check for collision with the left and right walls
    if ball.x < ball.size / 2 or ball.x > 128 - ball.size / 2 then
        ball.dx = -ball.dx  -- Reverse horizontal direction
    end

    -- Check for collision with the top wall
    if ball.y < ball.size / 2 then
        ball.dy = -ball.dy  -- Reverse vertical direction
    end
end

function check_collisions()
    collide_with_paddle()
    collide_with_bricks()
    check_game_over()
end
function collide_with_paddle()
    -- Calculate the edges of the ball and paddle
    local ball_bottom = ball.y + ball.size / 2
    local paddle_top = paddle.y
    local paddle_left = paddle.x
    local paddle_right = paddle.x + paddle.width

    -- Check collision with the paddle
    if ball_bottom >= paddle_top and ball.y < paddle_top and ball.x >= paddle_left and ball.x <= paddle_right then
        ball.dy = -ball.dy  -- Reverse the ball's vertical direction
        -- Optional: Adjust ball.dx based on where it hits the paddle for more dynamic gameplay
        local hit_pos = (ball.x - paddle.x) / paddle.width - 0.5  -- normalized -0.5 to 0.5
        ball.dx += hit_pos * 2  -- Influence the horizontal movement based on hit position
    end
end

function collide_with_bricks()
    for i, brick in ipairs(bricks) do
        if not brick.hit then
            local brick_left = brick.x
            local brick_right = brick.x + brick.width
            local brick_top = brick.y
            local brick_bottom = brick.y + brick.height

            -- Check for collision
            if ball.x + ball.size / 2 > brick_left and ball.x - ball.size / 2 < brick_right and
               ball.y + ball.size / 2 > brick_top and ball.y - ball.size / 2 < brick_bottom then
                brick.hit = true  -- Mark the brick as hit
                ball.dy = -ball.dy  -- Reverse the vertical direction of the ball
                score += 1  -- Increase score
                break  -- Exit the loop after collision to avoid multiple collisions
            end
        end
    end
end

function check_game_over()
    -- Check if the ball goes below the bottom of the screen
    if ball.y > 128 then
        -- Game over logic here
        print("Game Over! Press 'Z' to restart!")
        game_over=true
    end

    -- Optionally check if all bricks are hit
    local all_bricks_cleared = true
    for i, brick in ipairs(bricks) do
        if not brick.hit then
            all_bricks_cleared = false
            break
        end
    end

    if all_bricks_cleared then
        print("You won! Press 'Z' to restart!")
        _init()  -- Reset the game
    end
end

function _draw()
    cls()  -- Clear the screen with the default color
    if not game_over then
        draw_paddle()
        draw_ball()
        draw_bricks()
        draw_score()
    else
        print("Game Over! Press 'Z' to restart!", 40, 64, 8)  -- Center the message
    end
end

function draw_paddle()
    -- Draw the paddle using the rectfill function provided by PICO-8
    -- Parameters: x0, y0, x1, y1, color
    rectfill(paddle.x, paddle.y, paddle.x + paddle.width, paddle.y + paddle.height, 7) -- Color 7 is white
end

function draw_ball()
    -- Draw the ball as a filled circle
    -- Parameters: x, y, radius, color
    circfill(ball.x, ball.y, ball.size / 2, 8) -- Color 8 is red
end

function draw_bricks()
    for i, brick in ipairs(bricks) do
        if not brick.hit then
            -- Draw each active brick
            rectfill(brick.x, brick.y, brick.x + brick.width, brick.y + brick.height, 9+i%7) -- Color 9 is orange
        end
    end
end

function draw_score()
    -- Print the score at a fixed position on the screen
    -- Parameters: text, x, y, color
    print("Score: " .. score, 1, 1, 7) -- Color 7 is white
end


__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
