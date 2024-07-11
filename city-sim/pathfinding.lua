-- Constants
local ROAD = 0
local RESIDENTIAL = 1
local COMMERCIAL = 2
local INDUSTRIAL = 3
local MAX_PATH_LENGTH = 32
local MAX_ITERATIONS = 16

-- Helper function to get neighboring cells
local function get_neighbors(grid, x, y)
    local neighbors = {}
    local directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}}
    for _, dir in pairs(directions) do
        local nx, ny = x + dir[1], y + dir[2]
        if nx >= 1 and nx <= #grid[1] and ny >= 1 and ny <= #grid then
            table.insert(neighbors, {x = nx, y = ny})
        end
    end
    return neighbors
end

-- Heuristic function (Manhattan distance)
local function heuristic(a, b)
    return abs(a.x - b.x) + abs(a.y - b.y)
end

-- Find node with lowest f score in open set
local function find_lowest_f_score(open_set)
    local lowest_index = 1
    for i = 2, #open_set do
        if open_set[i].f < open_set[lowest_index].f then
            lowest_index = i
        end
    end
    return lowest_index
end

-- Check if a node is in the closed set
local function in_closed_set(closed_set, node)
    for _, closed_node in pairs(closed_set) do
        if closed_node.x == node.x and closed_node.y == node.y then
            return true
        end
    end
    return false
end

-- Check if a cell is valid for pathfinding
local function is_valid_cell(grid, node, start, goal)
    local cell_type = grid[node.y][node.x]
    return cell_type == ROAD or 
           (node.x == start.x and node.y == start.y) or 
           (node.x == goal.x and node.y == goal.y)
end

-- Update or add neighbor to open set
local function update_open_set(open_set, neighbor, g_score, h_score, current)
    for _, open_node in pairs(open_set) do
        if open_node.x == neighbor.x and open_node.y == neighbor.y then
            if g_score < open_node.g then
                open_node.g = g_score
                open_node.f = g_score + h_score
                open_node.parent = current
            end
            return true
        end
    end
    table.insert(open_set, {
        x = neighbor.x, y = neighbor.y, 
        g = g_score, h = h_score, 
        f = g_score + h_score, 
        parent = current
    })
    return false
end

-- Reconstruct path from goal to start
local function reconstruct_path(goal)
    local path = {}
    local current = goal
    while current and #path < MAX_PATH_LENGTH do
        table.insert(path, 1, {x = current.x, y = current.y})
        current = current.parent
    end
    return #path <= MAX_PATH_LENGTH and path or nil
end

-- A* pathfinding function
function find_path(grid, start, goal)
    local open_set = {{x = start.x, y = start.y, g = 0, h = heuristic(start, goal), f = 0, parent = nil}}
    local closed_set = {}
    local iterations = 0
    
    while #open_set > 0 and iterations < MAX_ITERATIONS do
        iterations += 1
        local current_index = find_lowest_f_score(open_set)
        local current = open_set[current_index]
        
        if current.x == goal.x and current.y == goal.y then
            return reconstruct_path(current)
        end
        
        table.remove(open_set, current_index)
        table.insert(closed_set, current)
        
        for _, neighbor in pairs(get_neighbors(grid, current.x, current.y)) do
            if in_closed_set(closed_set, neighbor) then goto continue end
            if not is_valid_cell(grid, neighbor, start, goal) then goto continue end
            
            local g_score = current.g + 1
            local h_score = heuristic(neighbor, goal)
            
            update_open_set(open_set, neighbor, g_score, h_score, current)
            
            ::continue::
        end
    end
    
    return nil  -- No path found or limits exceeded
end

-- Example usage
local grid = {
    {ROAD, ROAD, RESIDENTIAL, ROAD},
    {ROAD, COMMERCIAL, ROAD, ROAD},
    {RESIDENTIAL, ROAD, ROAD, INDUSTRIAL},
    {ROAD, ROAD, RESIDENTIAL, ROAD}
}

local start = {x = 1, y = 1}
local goal = {x = 4, y = 3}

local path = find_path(grid, start, goal)

if path then
    print("Path found:")
    for _, point in pairs(path) do
        print("(" .. point.x .. ", " .. point.y .. ")")
    end
else
    print("No path found or limits exceeded")
end