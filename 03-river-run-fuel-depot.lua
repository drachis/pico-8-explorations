pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- Fuel Depot Module

-- Fuel depot properties
fuel_depots = {}
fuel_depot_spawn_timer = 0
fuel_depot_spawn_interval = rnd(180) + 120  -- Base interval for spawning fuel depots

-- Fuel depot type
fuel_depot_type = {
    sprite = 5,
    speed = 1,
    width = 8,
    height = 8,
    color = 11,  -- Different color for visual debugging
    type = "fueldepot"
}

-- Initialize fuel depot properties
function init_fuel_depots()
    fuel_depots = {}
    fuel_depot_spawn_timer = 0
    fuel_depot_spawn_interval = rnd(180) + 120
end

-- Update fuel depot positions
function update_fuel_depots()
    fuel_depot_spawn_timer = fuel_depot_spawn_timer + 1

    if fuel_depot_spawn_timer >= fuel_depot_spawn_interval then
        spawn_fuel_depot()
        fuel_depot_spawn_timer = 0
        fuel_depot_spawn_interval = rnd(300) + 120  -- Set a new random interval
    end

    for depot in all(fuel_depots) do
        -- Move fuel depot down the screen
        depot.y = depot.y + depot.speed

        -- Remove depots that move off screen
        if depot.y > 128 then
            del(fuel_depots, depot)
        end
    end
end

-- Render fuel depots with debug rendering
function draw_fuel_depots()
    for depot in all(fuel_depots) do
        -- Debug rendering: draw a simple rectangle for each fuel depot
        rectfill(depot.x, depot.y, depot.x + depot.width, depot.y + depot.height, depot.color)
        -- Alternatively, you can use the actual sprite
        -- spr(depot.sprite, depot.x, depot.y)
    end
end

-- Handle fuel depot collisions
function check_fuel_collisions()
    for depot in all(fuel_depots) do
        -- Check collision with player
        if collides(depot, jet) then
            -- Replenish fuel
            jet.fuel = min(jet.fuel + 50, 100)
            del(fuel_depots, depot)
        end

        -- -- Check collision with bullets
        -- for bullet in all(jet.bullets) do
        --     if collides(depot, bullet) then
        --         -- Destroy fuel depot
        --         del(fuel_depots, depot)
        --         del(jet.bullets, bullet)
        --     end
        -- end
    end
end

-- Spawn a new fuel depot
function spawn_fuel_depot()
    local x = rnd(128 - fuel_depot_type.width)
    local y = -fuel_depot_type.height
    add(fuel_depots, {
        sprite = fuel_depot_type.sprite,
        x = x,
        y = y,
        speed = fuel_depot_type.speed,
        width = fuel_depot_type.width,
        height = fuel_depot_type.height,
        color = fuel_depot_type.color,
        type = fuel_depot_type.type
    })
end

-- Initialization call
init_fuel_depots()
