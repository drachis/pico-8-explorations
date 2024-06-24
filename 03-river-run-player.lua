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
    width = 8,
    height = 8,
    lives = 3,
    score = 0,
    fuel = 100
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
        -- handle out of fuel scenario
    end
end

-- Draw the jet and its bullets
function draw_jet()
    spr(1, jet.x, jet.y)  -- Assuming the jet sprite is at index 1
    for bullet in all(jet.bullets) do
        rectfill(bullet.x, bullet.y, bullet.x + 1, bullet.y + 2, 7)  -- Simple bullet drawing
    end
end

-- Shoot a bullet
function shoot()
    add(jet.bullets, {x = jet.x + 3, y = jet.y - 4})  -- Adjust bullet position as needed
end

-- Check for collisions (dummy function, needs actual implementation)
function check_collisions()
    -- Check for collisions with enemies, river banks, etc.
    -- This function will need to be expanded with actual collision logic
end

-- Initialization call
init_jet()
