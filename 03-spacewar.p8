delay = 255 -- 255 means never repeat
poke(0x5F5C, delay)

function _init()
    make_player()
    make_enemies(16)
end

function _update()
    start = stat(1)
    move_player()
    update_enemies()
    move_bullets()
end

function _draw()
    cls(2)
    draw_player()
    draw_enemies()
    draw_bullets()
    printh(stat(1) - start)
end

function make_enemies(number)
    enemy_sprites = { 2, 3, 4 }
    x = 0
    y = 0
    enemies = {}
    for i = 1, number, 1 do
        if x > 120 then
            y += 16
            x = 0
        end
        enemies[#enemies + 1] = { ["sprite"] = rnd(enemy_sprites), ["x"] = x, ["y"] = y, ["direction"] = enemy_direction(y), ["target_row"] = y }
        x += 16
    end
end

function enemy_direction(y)
    if y % 32 == 0 then
        return "xplus"
    else
        return "xminus"
    end
end

function update_enemies()
    to_delete = {}
    for edx = #enemies, -1 do
        movement = {
            ["x"] = 1,
            ["y"] = 1
        }
        -- move enemy based on movement direction property
        if (enemies[edx].direction == "xminus") enemies[edx].x -= movement.x if (enemies[edx].direction == "xplus") enemies[edx].x += movement.x if (enemies[edx].direction == "yplus") enemies[edx].y += movement.y if enemies[edx].direction != "yplus" and enemies[edx].target_row >= enemies[edx].y then
            if enemies[edx].x >= 120 or enemies[edx].x <= 0 then
                enemies[edx].direction = "yplus"
                enemies[edx].target_row += 16
            end
        end

        if enemies[edx].y >= enemies[edx].target_row then
            if (enemies[edx].x >= 120) enemies[edx].direction = "xminus" enemies[edx].x = 120
            if (enemies[edx].x <= 0) enemies[edx].direction = "xplus" enemies[edx].x = 0
        end
        for i = 1, #bullets do
            debugstring = " bullet idx "
            printh ("")
            if dist(bullets[i].x, bullets[i].y, enemies[edx].x, enemies[edx].y) < 16 then
                enemies[edx].sprite=0
                add(to_delete,edx)
            end
        end
    end
    for i = #to_delete, 1, -1 do
        -- del(enemies, enemies[to_delete[i]])
    end
end

function dist(x1, y1, x2, y2)
    local dx = x2 - x1
    local dy = y2 - y1
    local d = dx * dx + dy * dy
    d = sqrt(d)
    printh(d)
    return d
    --squared distance as an optimization
end

function draw_enemies()
    foreach(enemies, draw_enemy)
end

function draw_enemy(enemy)
    spr(enemy.sprite, enemy.x, enemy.y)
end

function make_player()
    px = 64
    py = 96
    psprite = 1
    bullets = {}
    fire_cooldown = 12
    --0.33 seconds at 30fps
end

function move_player()
    if (btn(0)) px -= 1
    if (btn(1)) px += 1
    if (px > 120) px = 120
    if (px < 0) px = 0
    if (btn(2) and fire_cooldown == 0) fire_bullet(px, py)
    if (btnp(2)) fire_cooldown = 0
    if (fire_cooldown > 0) fire_cooldown -= 1
end

function fire_bullet(x, y)
    bullets[#bullets + 1] = { ["x"] = x, ["y"] = y - 4 }
    fire_cooldown = 10
end

function move_bullets()
    for bdx = 1, #bullets do
        bullets[bdx].y -= 4
        if bullets[bdx].y < 0 then
            del(bullets, bdx)
        end
    end
end

function draw_bullets()
    foreach(bullets, draw_bullet)
end

function draw_bullet(bullet)
    circ(bullet.x, bullet.y, 2, 6)
end

function draw_player()
    spr(psprite, px, py)
end