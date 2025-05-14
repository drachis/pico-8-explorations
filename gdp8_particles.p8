pico-8 cartridge // http://www.pico-8.com
version 42
__lua__

function _init()
    ps={}   --empty particle table
    g=0.1   --particle gravity
    max_vel=2   --max initial particle velocity 
    min_time=2
    max_time=5
    min_life=90 --particle lifetime
    max_life=120
    t=0 --ticker
    cols={1,1,1,1,13,12,12,7} --colors
    burst=500

    next_p=rndb(min_time, max_time)
end

function rndb(low, high)
    return flr(rnd(high-low+1)+low)
end

function _update()
    t+=1
    if (t==next_p) then
        add_p(64,64)
        next_p=rndb(min_time, max_time)
        t=0
    end
    --burst
    if(btnp(1)) then 
        for i=1, burst do add_p(64, 64) end
    end
    foreach(ps, update_p)
end

function _draw()
    cls()
    foreach(ps, draw_p)
end

function add_p(x,y)
    local p={}
    p.x,p.y = x,y
    p.dx=rnd(max_vel) - max_vel/2
    p.dy=rnd(max_vel)*-12
    p.life_start=rndb(min_life,max_life)
    p.life=p.life_start
    add(ps,p)
end

function update_p(p)
    if (p.life<=0) then
        del(ps, p) -- kill the old
    else
        p.dy+=g -- gravity take them down
        if(( p.y+p.dy)>>127) p.dy*=-0.8
        p.x+=p.dx --update position
        p.y+=p.dy
        p.life-=1   -- a little death, as a treat
    end
end

function draw_p(p)
    local pcol=flr(p.life/p.life_start*#cols+1)
    pset(p.x,p.y,cols[pcol])
end

