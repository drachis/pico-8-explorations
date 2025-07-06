-- Initialize global slug data structure with slime trail storage
slug = {
    spr = 10,
    x = 8*2,
    y = 8*9,
    crop_x =1,
    crop_y =1,
    flipX = false,
    flipY = false,
    dx = 0.0,
    dy = 0.0,
    friction = 0.02,
    bounce = 1,
    w=0.4,
    h=0.4,
    slime_trail = {} -- Storage for slime trail pixels
}

function slug_control(_slug)
    local accel = 3
    local max_speed = 10
    local friction = 0.9
    local attachment_threshold = 0.5

    -- Check for surface attachment and sliding behavior
    if (btn(0)) then
        _slug.x -= min(abs(_slug.dx) + accel, max_speed)
        _slug.dx = -min(abs(_slug.dx) + accel, max_speed)
        if (_slug.dy < attachment_threshold) then
            _slug.dy = 0
            _slug.sliding = true
        end
    elseif (not btn(0)) then
        _slug.dx *= friction
        _slug.sliding = false
    end

    if (btn(1)) then
        _slug.x += min(abs(_slug.dx) + accel, max_speed)
        _slug.dx = min(abs(_slug.dx) + accel, max_speed)
        if (_slug.dy < attachment_threshold) then
            _slug.dy = 0
            _slug.sliding = true
        end
    elseif (not btn(1)) then
        _slug.dx *= friction
        _slug.sliding = false
    end

    if (btn(2)) then
        _slug.y -= min(abs(_slug.dy) + accel, max_speed)
        _slug.dy = -min(abs(_slug.dy) + accel, max_speed)
        if (_slug.dx < attachment_threshold) then
            _slug.dx = 0
            _slug.sliding = true
        end
    elseif (not btn(2)) then
        _slug.dy *= friction
        _slug.sliding = false
    end

    if (btn(3)) then
        _slug.y += min(abs(_slug.dy) + accel, max_speed)
        _slug.dy = min(abs(_slug.dy) + accel, max_speed)
        if (_slug.dx < attachment_threshold) then
            _slug.dx = 0
            _slug.sliding = true
        end
    elseif (not btn(3)) then
        _slug.dy *= friction
        _slug.sliding = false
    end

    -- Draw slime trail
    if (_slug.sliding) then
        add(_slug.slime_trail, 
        {x = _slug.x, y = _slug.y}
    )
    end
end

function draw_slime_trail()
    local slime_color = 12 -- Choose a color for the slime trail
    for _, pos in ipairs(slug.slime_trail) do
        pset(pos.x, pos.y, slime_color)
    end
end