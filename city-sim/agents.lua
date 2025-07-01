agents = {}
max_agents = 10 -- Set a maximum number of agents

function init_agents()
    spawn_timer = 0
end

function spawn_agent()
    local residential_zones = {}
    for y=1, map_height do
        for x=1, map_width do
            if map_grid[y][x] == 1 then -- Find all residential zones
                add(residential_zones, {x=x, y=y})
            end
        end
    end

    if #residential_zones > 0 and #agents < max_agents then
        local chosen_zone = residential_zones[flr(rnd(#residential_zones)) + 1] -- Randomly select a residential zone
        add(agents, {x=chosen_zone.x, y=chosen_zone.y, home=chosen_zone, type="builder", target=nil, move_timer=0, work_x=nil, work_y=nil, path=nil})
        map_grid[chosen_zone.y][chosen_zone.x] = 6 -- Mark as filled in residential (bright green)
    end
end

function move_along_path(agent)
    if not agent.path or #agent.path == 0 then 
        return
     end -- No path or empty path, do nothing
    
     local direction = 1
    if agent.direction then -- If we're moving backwards, reverse the direction
        direction = 1
    elseif
        direction = -1 --backwards
    end
    
    agent.index = agent.index + direction
    if agent.direction == true and agent.index < #agent.path - 1 or
        agent.direction == false and agent.index != 0 then
        local pos = agent.path[agent.index]
        agent.x = pos[1]
        agent.y = pos[2]
    elseif agent.index == #agent.path or agent.index == 0 and agent.direction == fasle then -- If we're at the first or last position in the path, reverse the direction
        agent.direction != agent.direction 
    end
end

function update_agents()
    spawn_timer += 1
    if spawn_timer >= 30 then -- Check every second (30 frames)
        spawn_timer = 0
        spawn_agent() -- Try to spawn a new agent every second
    end

    for agent in all(agents) do
        agent.move_timer += 1
        if agent.move_timer >= 9 then -- Move every 0.15 seconds (9 frames)
            agent.move_timer = 0

            -- Ensure agent's path is updated if target changes
            if not agent.path or #agent.path == 0 then
                if agent.target then
                    agent.path = find_path(agent.x, agent.y, agent.target.x, agent.target.y, map_grid)
                end
            end

            if agent.target == nil and is_adjacent_to_road(agent.x, agent.y) then
                -- Find the nearest road
                local nearest_distance = 128
                agent.target = nearest_road
                agent.path = find_path(agent.x, agent.y, nearest_road.x, nearest_road.y, map_grid)
            else
                -- Move along the path
                move_along_path(agent)

                if agent.x == agent.target.x and agent.y == agent.target.y then
                    if agent.type == "builder" then
                        -- Builder agent reached the target
                        local nearest_distance = 9999
                        local nearest_zone = nil
                        for y=1, map_height do
                            for x=1, map_width do
                                if (map_grid[y][x] == 2 or map_grid[y][x] == 3) and is_adjacent_to_road(x, y) then -- Commercial or Industrial adjacent to road
                                    local distance = abs(agent.x - x) + abs(agent.y - y)
                                    if distance < nearest_distance then
                                        nearest_distance = distance
                                        nearest_zone = {x=x, y=y}
                                    end
                                end
                            end
                        end

                        -- Check if the agent has reached a commercial or industrial zone
                        if nearest_zone then
                            agent.target = nearest_zone
                            agent.path = find_path(agent.x, agent.y, nearest_zone.x, nearest_zone.y, map_grid)
                        elseif agent.x == agent.target.x and agent.y == agent.target.y then
                            if map_grid[agent.y][agent.x] == 2 then
                                map_grid[agent.y][agent.x] = 7 -- Mark as filled in commercial (bright blue)
                            elseif map_grid[agent.y][agent.x] == 3 then
                                map_grid[agent.y][agent.x] = 9 -- Mark as filled in industrial (bright yellow)
                            end
                            -- Change the agent's role to worker/consumer and set a new target
                            agent.type = "worker"
                            agent.work_x = agent.target.x
                            agent.work_y = agent.target.y
                            agent.target = {x=agent.home.x, y=agent.home.y} -- Return home
                            agent.path = find_path(agent.x, agent.y, agent.home.x, agent.home.y, map_grid)
                        end
                    elseif agent.type == "worker" then
                        -- Worker moves between home and work
                        if agent.x == agent.home.x and agent.y == agent.home.y then
                            -- At home, set target to work
                            agent.target = {x=agent.work_x, y=agent.work_y}
                            agent.path = find_path(agent.x, agent.y, agent.work_x, agent.work_y, map_grid)
                        elseif agent.x == agent.work_x and agent.y == agent.work_y then
                            -- At work, set target to home
                            agent.target = {x=agent.home.x, y=agent.home.y}
                            agent.path = find_path(agent.x, agent.y, agent.home.x, agent.home.y, map_grid)
                        end
                    end
                end
            end
        end
    end
end

function get_nearest_zone(x, y, map_grid)
    local min_distance = 128
    local nearest_zone

    for i = 1, map_height do
        for j = 1, map_width do
            if (map_grid[i][j] == 2 or map_grid[i][j] == 3) then -- Commercial or Industrial zone
                local distance = abs(x - j) + abs(y - i)
                if distance < min_distance then
                    min_distance = distance
                    nearest_zone = {x = j, y = i}
                end
            elseif (map_grid[i][j] == 1) then -- Residential zone
                local distance = abs(x - j) + abs(y - i)
                if distance < min_distance then
                    min_distance = distance
                    nearest_zone = {x = j, y = i}
                end
            end
        end
    end
            elseif map_grid[i][j] == 4 then -- Road
                return {x = j, y = i}
            end

    return nearest_zone
end

function draw_agents()
    for agent in all(agents) do
        if agent.type == "builder" then
            circfill(agent.x * 8 - 4, agent.y * 8 - 4, 2, 8) -- Builder agent as a small circle
        elseif agent.type == "worker" then
            circfill(agent.x * 8 - 4, agent.y * 8 - 4, 2, 14) -- Worker agent as a different color
        end
    end
end