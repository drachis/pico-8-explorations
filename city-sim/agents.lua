-- agents.lua
agents = {}

function init_agents()
    spawn_timer = 0
end

function spawn_agent()
    for y=1, map_height do
        for x=1, map_width do
            if map_grid[y][x] == 1 then -- Spawn from Residential zone
                add(agents, {x=x, y=y, target=nil})
                map_grid[y][x] = 6 -- Mark as filled in residential (bright green)
                return
            end
        end
    end
end

function update_agents()
    spawn_timer += 1
    if spawn_timer >= 30 then -- Check every second (30 frames)
        spawn_timer = 0
        if #agents == 0 then
            spawn_agent()
        end
    end
    
    for agent in all(agents) do
        if agent.target == nil then
            -- Find the nearest road
            local nearest_distance = 9999
            for y=1, map_height do
                for x=1, map_width do
                    if map_grid[y][x] == 4 then -- Road
                        local distance = abs(agent.x - x) + abs(agent.y - y)
                        if distance < nearest_distance then
                            nearest_distance = distance
                            agent.target = {x=x, y=y}
                        end
                    end
                end
            end
        else
            -- Move towards the target
            if agent.x < agent.target.x then agent.x += 1 end
            if agent.x > agent.target.x then agent.x -= 1 end
            if agent.y < agent.target.y then agent.y += 1 end
            if agent.y > agent.target.y then agent.y -= 1 end
            
            if agent.x == agent.target.x and agent.y == agent.target.y then
                -- Target reached, find a new target (commercial or industrial zone)
                agent.target = nil
                local nearest_distance = 9999
                for y=1, map_height do
                    for x=1, map_width do
                        if map_grid[y][x] == 2 or map_grid[y][x] == 3 then -- Commercial or Industrial
                            local distance = abs(agent.x - x) + abs(agent.y - y)
                            if distance < nearest_distance then
                                nearest_distance = distance
                                agent.target = {x=x, y=y}
                            end
                        end
                    end
                end
            end
            
            -- Check if the agent has reached a commercial or industrial zone
            if agent.target ~= nil and agent.x == agent.target.x and agent.y == agent.target.y then
                if map_grid[agent.y][agent.x] == 2 then
                    map_grid[agent.y][agent.x] = 7 -- Mark as filled in commercial (bright blue)
                elseif map_grid[agent.y][agent.x] == 3 then
                    map_grid[agent.y][agent.x] = 9 -- Mark as filled in industrial (bright yellow)
                end
                del(agents, agent) -- Remove the agent
            end
        end
    end
end

function draw_agents()
    for agent in all(agents) do
        circfill(agent.x * 8 - 4, agent.y * 8 - 4, 2, 8) -- Draw agent as a small circle
    end
end
