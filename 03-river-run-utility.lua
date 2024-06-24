pico-8 cartridge // http://www.pico-8.com
version 42
__lua__

-- Utility Module

-- Helper function to check collision between two entities
    function collides(a, b)
        return a.x < b.x + b.width and
               b.x < a.x + a.width and
               a.y < b.y + b.height and
               b.y < a.y + a.height
    end
    
    -- Helper function to constrain a value within a range
    function clamp(val, min, max)
        if val < min then return min end
        if val > max then return max end
        return val
    end
    
