-- Constants
local MAX_PATH_LENGTH = 32
local MAX_ITERATIONS = 32  -- Increased from 16 to allow for more complex paths

-- Cell type constants
local EMPTY = 0
local RESIDENTIAL = 1
local COMMERCIAL = 2
local INDUSTRIAL = 3
local ROAD = 4
local FILLED_RESIDENTIAL = 6
local FILLED_COMMERCIAL = 7
local FILLED_INDUSTRIAL = 9

-- Helper function to get neighboring cells
local function get_neighbors(x, y, grid)
    local neighbors = {}
    local directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}}
    for _, dir in pairs(directions) do
        local nx, ny = x + dir[1], y + dir[2]
        if nx >= 1 and nx <= #grid[1] and ny >= 1 and ny <= #grid then
            add(neighbors, {x = nx, y = ny})
        end
    end
    return neighbors
end

-- Heuristic function (Manhattan distance)
local function heuristic(a, b)
    return abs(a.x - b.x) + abs(a.y - b.y)
end

-- Check if a cell is valid for pathfinding
local function is_valid_cell(grid, node, start, goal)
    local cell_type = grid[node.y][node.x]
    return cell_type == ROAD or 
           cell_type == FILLED_RESIDENTIAL or
           cell_type == FILLED_COMMERCIAL or
           cell_type == FILLED_INDUSTRIAL or
           (node.x == start.x and node.y == start.y) or 
           (node.x == goal.x and node.y == goal.y)
end

-- Reconstruct path from goal to start
local function reconstruct_path(goal)
    local path = {}
    local current = goal
    while current and #path < MAX_PATH_LENGTH do
        add(path, {x = current.x, y = current.y})
        current = current.parent
    end
    return #path <= MAX_PATH_LENGTH and path or nil
end

-- A* pathfinding function
function find_path(start_x, start_y, goal_x, goal_y, grid)
    local start = {x = start_x, y = start_y}
    local goal = {x = goal_x, y = goal_y}
    local open_set = {{x = start.x, y = start.y, g = 0, h = heuristic(start, goal), f = 0, parent = nil}}
    local closed_set = {}
    local iterations = 0
    
    while #open_set > 0 and iterations < MAX_ITERATIONS do
        iterations += 1
        
        -- Find node with lowest f score
        local current_index, current = 1, open_set[1]
        for i = 2, #open_set do
            if open_set[i].f < current.f then
                current_index, current = i, open_set[i]
            end
        end
        
        if current.x == goal.x and current.y == goal.y then
            return reconstruct_path(current)
        end
        
        del(open_set, current)
        add(closed_set, current)
        
        for _, neighbor in pairs(get_neighbors(current.x, current.y, grid)) do
            if not is_valid_cell(grid, neighbor, start, goal) then goto continue end
            
            local is_closed = false
            for _, closed_node in pairs(closed_set) do
                if closed_node.x == neighbor.x and closed_node.y == neighbor.y then
                    is_closed = true
                    break
                end
            end
            if is_closed then goto continue end
            
            local g_score = current.g + 1
            local h_score = heuristic(neighbor, goal)
            local f_score = g_score + h_score
            
            local is_in_open = false
            for _, open_node in pairs(open_set) do
                if open_node.x == neighbor.x and open_node.y == neighbor.y then
                    is_in_open = true
                    if g_score < open_node.g then
                        open_node.g = g_score
                        open_node.f = f_score
                        open_node.parent = current
                    end
                    break
                end
            end
            
            if not is_in_open then
                add(open_set, {
                    x = neighbor.x, y = neighbor.y, 
                    g = g_score, h = h_score, 
                    f = f_score, parent = current
                })
            end
            
            ::continue::
        end
    end
    
    return nil  -- No path found or limits exceeded
end

-- Example usage (can be removed in final implementation)
function test_pathfinding()
    local test_grid = {
        {0, 0, 0, 0, 0},
        {0, 4, 4, 4, 0},
        {0, 0, 0, 4, 0},
        {0, 4, 4, 4, 0},
        {0, 0, 0, 0, 0}
    }
    local path = find_path(1, 1, 5, 5, test_grid)
    if path then
        print("Path found:")
        for _, point in pairs(path) do
            print("(" .. point.x .. ", " .. point.y .. ")")
        end
    else
        print("No path found or limits exceeded")
    end
end