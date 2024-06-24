pico-8 cartridge // http://www.pico-8.com
version 42
__lua__

-- Enemy Module

-- Enemy properties
enemies = {}

-- Enemy types
enemy_types = {
    {sprite = 2, speed = 1, width = 8, height = 8, type = "boat"},
    {sprite = 3, speed = 1.5, width = 8, height = 8, type = "helicopter"},
    {sprite = 4, speed = 2, width = 8, height = 8, type = "jet"}
}

-- Initialize enemy properties
function init_enemies()
    enemies = {}
    spawn_enemy()
end

-- Update enemy positions and behavior
function update_enemies()
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

-- Render enemies
function draw_enemies()
    for enemy in all(enemies) do
        spr(enemy.sprite, enemy.x, enemy.y)
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
        type = enemy_type.type
    })
end

-- Check for enemy collisions with player and projectiles
function enemy_collisions()
    for enemy in all(enemies) do
        -- Check collision with player
        if collides(enemy, jet) then
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