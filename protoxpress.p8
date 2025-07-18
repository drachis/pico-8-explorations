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
        for i = 1, 5 do
            local x_offset = math.random(-2, 2)
            local y_offset = math.random(-2, 2)
            spr(1, _slug.x + x_offset, _slug.y + y_offset) -- Assuming sprite 1 is the slime trail sprite
        end
    end
end