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
    segments = 10
}

-- Initialize environment settings
function init_environment()
    environment.river = {}
    generate_river()
end

-- Update environment elements
function update_environment()
    -- Scroll the river
    for segment in all(environment.river) do
        segment.y = segment.y + environment.river_speed
    end
    -- Remove segments that move off screen and generate new segments
    if environment.river[1].y > 128 then
        del(environment.river, environment.river[1])
        generate_river()
    end
end

-- Render the river and banks
function draw_environment()
    for segment in all(environment.river) do
        -- Draw river
        rectfill(segment.x1, segment.y, segment.x2, segment.y + environment.segment_height, environment.river_color)
        -- Draw banks
        rectfill(0, segment.y, segment.x1, segment.y + environment.segment_height, environment.bank_color)
        rectfill(segment.x2, segment.y, 128, segment.y + environment.segment_height, environment.bank_color)
    end
end

-- Procedurally generate river
function generate_river()
    local last_segment = environment.river[#environment.river]
    local y_start = last_segment and last_segment.y - environment.segment_height or -environment.segment_height
    local x_center = last_segment and (last_segment.x1 + last_segment.x2) / 2 or 64
    local width = environment.river_width
    for i = 1, environment.segments do
        local x1 = x_center - width / 2 + flr(rnd(3)) - 1
        local x2 = x_center + width / 2 + flr(rnd(3)) - 1
        add(environment.river, {x1 = x1, x2 = x2, y = y_start + (i - 1) * environment.segment_height})
        x_center = (x1 + x2) / 2
    end
end

-- Initialization call
init_environment()
