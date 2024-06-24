pico-8 cartridge // http://www.pico-8.com
version 42
__lua__

-- Enemy Module

-- Enemy properties
enemies = {}
enemy_spawn_timer = 0
enemy_spawn_interval = 60  -- Base interval for spawning enemies
enemy_burst_count = 0

-- Enemy types
enemy_types = {
    {sprite = 2, speed = 1, width = 8, height = 8, type = "boat", color = 8},
    {sprite = 3, speed = 1.5, width = 8, height = 8, type = "helicopter", color = 9},
    {sprite = 4, speed = 2, width = 8, height = 8, type = "jet", color = 10}
}

-- Initialize enemy properties
function init_enemies()
    enemies = {}
    enemy_spawn_timer = 0
    enemy_spawn_interval = 60
    enemy_burst_count = 0
end

-- Update enemy positions and behavior
function update_enemies()
    enemy_spawn_timer = enemy_spawn_timer + 1

    if enemy_spawn_timer >= enemy_spawn_interval then
        if enemy_burst_count > 0 then
            spawn_enemy()
            enemy_burst_count = enemy_burst_count - 1
            enemy_spawn_timer = enemy_spawn_timer - 10  -- Short interval for burst
        else
            enemy_spawn_timer = 0
            enemy_burst_count = rnd(3) + 1  -- Random burst count between 1 and 3
            enemy_spawn_interval = rnd(90) + 30  -- Random interval between 30 and 120 frames
        end
    end

    for enemy in all(enemies) do
        -- Move enemy based on its type
        enemy.y = enemy.y + enemy.speed
        if enemy.type == "boat" or enemy.type == "helicopter" then
            -- Boats and helicopters move back and forth
            enemy.x = enemy.x + sin(enemy.y / 16)
        end

        -- Remove enemies that move off screen
        if enemy.y > 128 then
            del(enemies, enemy)
        end
    end
end

-- Render enemies with debug rendering
function draw_enemies()
    for enemy in all(enemies) do
        -- Debug rendering: draw different shapes for each enemy type
        if enemy.type == "boat" then
            rectfill(enemy.x, enemy.y, enemy.x + enemy.width, enemy.y + enemy.height, enemy.color)
        elseif enemy.type == "helicopter" then
            circfill(enemy.x + 4, enemy.y + 4, 4, enemy.color)
        elseif enemy.type == "jet" then
            line(enemy.x, enemy.y, enemy.x + enemy.width, enemy.y + enemy.height, enemy.color)
            line(enemy.x, enemy.y + enemy.height, enemy.x + enemy.width, enemy.y, enemy.color)
        end
    end
end

-- Spawn a new enemy
function spawn_enemy()
    local enemy_type = enemy_types[flr(rnd(#enemy_types)) + 1]
    local x = rnd(128 - enemy_type.width)
    local y = -enemy_type.height
    add(enemies, {
        sprite = enemy_type.sprite,
        x = x,
        y = y,
        speed = enemy_type.speed,
        width = enemy_type.width,
        height = enemy_type.height,
        type = enemy_type.type,
        color = enemy_type.color
    })
end

-- Check for enemy collisions with player and projectiles
function enemy_collisions()
    for enemy in all(enemies) do
        -- Check collision with player
        if collides(jet, enemy) then
            -- Handle player death or damage
            jet.lives = jet.lives - 1
            del(enemies, enemy)
        end
        
        -- Check collision with bullets
        for bullet in all(jet.bullets) do
            if collides(enemy, bullet) then
                -- Handle enemy destruction
                jet.score = jet.score + 100
                del(enemies, enemy)
                del(jet.bullets, bullet)
            end
        end
    end
end

-- Initialization call
init_enemies()
