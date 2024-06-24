pico-8 cartridge // http://www.pico-8.com
version 42
__lua__

-- Environment Module

-- Environment properties
environment = {
    river = {},
    river_width = 48,
    river_speed = 1,
    bank_color = 3,
    river_color = 12,
    segment_height = 16,
    total_height = 0  -- total height of all segments combined
}

-- Initialize environment settings
function init_environment()
    environment.river = {}
    environment.total_height = 0
    generate_initial_river()
end

-- Update environment elements
function update_environment()
    -- Scroll the environment
    for segment in all(environment.river) do
        segment.y = segment.y + environment.river_speed
    end

    -- Remove segments that have moved off screen
    while #environment.river > 0 and environment.river[1].y >= 128 do
        del(environment.river, environment.river[1])
    end

    -- Add new segments if necessary
    if #environment.river == 0 or environment.river[#environment.river].y >= 0 then
        generate_river()
    end
end

-- Render the river and banks
function draw_environment()
    for segment in all(environment.river) do
        local y = segment.y
        -- Draw river
        rectfill(segment.x1, y, segment.x2, y + environment.segment_height, environment.river_color)
        -- Draw banks
        rectfill(0, y, segment.x1, y + environment.segment_height, environment.bank_color)
        rectfill(segment.x2, y, 128, y + environment.segment_height, environment.bank_color)
    end
end

-- Generate the initial set of river segments
function generate_initial_river()
    local y = -environment.segment_height
    for i = 1, ceil(128 / environment.segment_height) + 1 do
        local x_center = 64
        local width = environment.river_width
        local x1 = x_center - width / 2
        local x2 = x_center + width / 2
        add(environment.river, {x1 = x1, x2 = x2, y = y})
        y = y + environment.segment_height
    end
end

-- Procedurally generate river segments
function generate_river()
    local last_segment = environment.river[#environment.river]
    local y = last_segment.y - environment.segment_height
    local x_center = (last_segment.x1 + last_segment.x2) / 2
    local width = environment.river_width
    local x1 = x_center - width / 2 + flr(rnd(3)) - 1
    local x2 = x_center + width / 2 + flr(rnd(3)) - 1
    add(environment.river, {x1 = x1, x2 = x2, y = y})
end

-- Initialization call
init_environment()
