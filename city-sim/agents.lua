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
        add(agents, {x=chosen_zone.x, y=chosen_zone.y, home_x=chosen_zone.x, home_y=chosen_zone.y, type="builder", target=nil, move_timer=0, work_x=nil, work_y=nil, path=nil})
        map_grid[chosen_zone.y][chosen_zone.x] = 6 -- Mark as filled in residential (bright green)
    end
end

function move_along_path(agent)
    if agent.path and #agent.path > 0 then
        local next_step = agent.path[#agent.path] -- Get the last element (next step)
        agent.x = next_step.x
        agent.y = next_step.y
        del(agent.path, next_step) -- Remove the last element
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

            if agent.target == nil then
                -- Find the nearest road
                local nearest_distance = 9999
                local nearest_road = nil
                for y=1, map_height do
                    for x=1, map_width do
                        if map_grid[y][x] == 4 then -- Road
                            local distance = abs(agent.x - x) + abs(agent.y - y)
                            if distance < nearest_distance then
                                nearest_distance = distance
                                nearest_road = {x=x, y=y}
                            end
                        end
                    end
                end
                if nearest_road then
                    agent.target = nearest_road
                    agent.path = find_path(agent.x, agent.y, nearest_road.x, nearest_road.y, map_grid)
                end
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
                            agent.target = {x=agent.home_x, y=agent.home_y} -- Return home
                            agent.path = find_path(agent.x, agent.y, agent.home_x, agent.home_y, map_grid)
                        end
                    elseif agent.type == "worker" then
                        -- Worker moves between home and work
                        if agent.x == agent.home_x and agent.y == agent.home_y then
                            -- At home, set target to work
                            agent.target = {x=agent.work_x, y=agent.work_y}
                            agent.path = find_path(agent.x, agent.y, agent.work_x, agent.work_y, map_grid)
                        elseif agent.x == agent.work_x and agent.y == agent.work_y then
                            -- At work, set target to home
                            agent.target = {x=agent.home_x, y=agent.home_y}
                            agent.path = find_path(agent.x, agent.y, agent.home_x, agent.home_y, map_grid)
                        end
                    end
                end
            end
        end
    end
end

function is_adjacent_to_road(x, y)
    return (x > 1 and map_grid[y][x-1] == 4) or
           (x < map_width and map_grid[y][x+1] == 4) or
           (y > 1 and map_grid[y-1][x] == 4) or
           (y < map_height and map_grid[y+1][x] == 4)
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