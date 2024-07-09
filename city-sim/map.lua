local map = {}

function map.init_map()
    map.width = 20
    map.height = 15
    map.grid = {}
    for y=1, map.height do
        map.grid[y] = {}
        for x=1, map.width do
            map.grid[y][x] = 0 -- 0 represents empty cell
        end
    end
end

function map.draw_map()
    for y=1, map.height do
        for x=1, map.width do
            spr(map.grid[y][x], x*8, y*8)
        end
    end
end

return map
