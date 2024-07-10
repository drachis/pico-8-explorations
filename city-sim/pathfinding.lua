-- pathfinding.lua

function find_path(start_x, start_y, goal_x, goal_y, grid)
    local open_set = {{x=start_x, y=start_y, g=0, h=heuristic(start_x, start_y, goal_x, goal_y), parent=nil}}
    local closed_set = {}
    local goal = {x=goal_x, y=goal_y}

    while #open_set > 0 do
        local current = remove_first(open_set)

        if current.x == goal.x and current.y == goal.y then
            return reconstruct_path(current)
        end

        add(closed_set, current)

        local neighbors = get_neighbors(current, grid)
        for i=1, #neighbors do
            local neighbor = neighbors[i]
            if not in_set(neighbor, closed_set) then
                local tentative_g = current.g + 1

                if not in_set(neighbor, open_set) or tentative_g < neighbor.g then
                    neighbor.g = tentative_g
                    neighbor.h = heuristic(neighbor.x, neighbor.y, goal.x, goal.y)
                    neighbor.parent = current

                    if not in_set(neighbor, open_set) then
                        add(open_set, neighbor)
                    end
                end
            end
        end

        sort_by_f(open_set)
    end

    return nil -- No path found
end

function heuristic(x1, y1, x2, y2)
    return abs(x1 - x2) + abs(y1 - y2)
end

function get_neighbors(node, grid)
    local neighbors = {}
    local x, y = node.x, node.y

    if x > 1 and grid[y][x-1] ~= 0 then add(neighbors, {x=x-1, y=y}) end
    if x < #grid[1] and grid[y][x+1] ~= 0 then add(neighbors, {x=x+1, y=y}) end
    if y > 1 and grid[y-1][x] ~= 0 then add(neighbors, {x=x, y=y-1}) end
    if y < #grid and grid[y+1][x] ~= 0 then add(neighbors, {x=x, y=y+1}) end

    return neighbors
end

function in_set(node, set)
    for i=1, #set do
        local n = set[i]
        if n.x == node.x and n.y == node.y then
            return true
        end
    end
    return false
end

function sort_by_f(set)
    for i=1, #set-1 do
        for j=i+1, #set do
            if (set[i].g + set[i].h) > (set[j].g + set[j].h) then
                set[i], set[j] = set[j], set[i]
            end
        end
    end
end

function reconstruct_path(node)
    local path = {}
    while node do
        add(path, 1, {x=node.x, y=node.y})
        node = node.parent
    end
    return path
end

function remove_first(set)
    local first = set[1]
    deli(set, 1)
    return first
end
