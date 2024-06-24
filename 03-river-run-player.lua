pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- Player Module

-- Jet properties
jet = {
    x = 64,
    y = 100,
    speed = 1,
    accel = 0.05,
    max_speed = 2,
    min_speed = 0.5,
    bullets = {},
    bullet_speed = 3,
    width = 8,  -- Make sure width is set
    height = 8,  -- Make sure height is set
    lives = 3,
    score = 0,
    fuel = 100,
    type="player"
}

-- Initialize jet properties
function init_jet()
    jet.x = 64
    jet.y = 100
    jet.speed = 1
    jet.lives = 3
    jet.score = 0
    jet.fuel = 100
    jet.bullets = {}
    printh("Jet initialized: width="..jet.width.." height="..jet.height)
end

-- Update jet position and handle input
function update_jet()
    -- Move left
    if btn(0) then
        jet.x = jet.x - 1
    end
    -- Move right
    if btn(1) then
        jet.x = jet.x + 1
    end
    -- Accelerate
    if btn(2) then
        jet.speed = min(jet.speed + jet.accel, jet.max_speed)
    end
    -- Brake
    if btn(3) then
        jet.speed = max(jet.speed - jet.accel, jet.min_speed)
    end
    -- Shooting
    if btnp(4) then
        shoot()
    end
    -- Update bullets
    for bullet in all(jet.bullets) do
        bullet.y = bullet.y - jet.bullet_speed
        if bullet.y < 0 then
            del(jet.bullets, bullet)
        end
    end
    -- Update fuel
    jet.fuel = jet.fuel - 0.1
    if jet.fuel <= 0 then
        jet.fuel = 0  -- Ensure fuel doesn't go below 0
        jet.lives = 0  -- Set lives to 0 to trigger game over
    end
end

-- Draw the jet and its bullets with debug rendering
function draw_jet()
    -- Debug rendering: draw a simple rectangle for the jet
    rectfill(jet.x, jet.y, jet.x + jet.width, jet.y + jet.height, 11)
    
    for bullet in all(jet.bullets) do
        rectfill(bullet.x, bullet.y, bullet.x + 1, bullet.y + 2, 7)  -- Simple bullet drawing
    end
end

-- Shoot a bullet
function shoot()
    add(jet.bullets, {x = jet.x + 3, y = jet.y - 4, height=1, width=1, type="bullet"})  -- Adjust bullet position as needed
end

-- Check for collisions using the utility module's collides function
function check_collisions()
    -- Check collision with enemies
    for enemy in all(enemies) do
        if collides(jet, enemy) then
            -- Handle player death or damage
            jet.lives = jet.lives - 1
            del(enemies, enemy)
        end
    end

    -- Check collision with fuel depots
    for depot in all(fuel_depots) do
        if collides(jet, depot) then
            -- Replenish fuel
            jet.fuel = min(jet.fuel + 50, 100)
            del(fuel_depots, depot)
        end
    end

    -- -- Check collision with bullets
    -- for enemy in all(enemies) do
    --     for bullet in all(jet.bullets) do
    --         if collides(enemy, bullet) then
    --             -- Handle enemy destruction
    --             jet.score = jet.score + 100
    --             del(enemies, enemy)
    --             del(jet.bullets, bullet)
    --         end
    --     end
    -- end
end

-- Initialization call
init_jet()
