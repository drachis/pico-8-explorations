pico-8 cartridge // http://www.pico-8.com
version 23
__lua__
-- pong mini project
-- by drachis
court={}
line={}

player_points = 0
com_points = 0 
scored = ""
line_x=63
line_y = 11
line_length=4
court_bottom=127
--variables
player_2={
    x = 8, 
    y =  63, 
    c = 12, 
    w = 2,
    h = 10,
    speed = ,
    score=0
}
player_1={
    x=117,
    y=63,
    c=8,
    w=2,
    h=12,
    speed=0.75,
    score=0
}
ball={
    x=64,
    y=64,
    dx=2,
    dy=2,
    size=4
}

-- court
court.left=0
court.right=127
court.top=10
court.bottom=127
-- court center line
line ={
    x=63,
    y=10,
    length=4
}
function _init()
    end
function _draw()
    cls()
    --- dashed center line
    repeat
        line(line.x, line.y, line.x,line.y+line.length, 5)
        line.y += line.length*2.5
    until line.y > court.bottom
    line_y = 10 --reset
    rect(0,10,127,127,6)
    --court
    rect(0,10,127,127,6)
    -- ball
    rectfill(
        ball.x-ball.w/2,
        ball.y-ball.w/2,
        ball.x+ball.w/2,
        ball.y+ball.w/2,
        ball.c
    )
    -- player
    rectfill(
        player.x,
        player.y,
        player.x+player.w,
        player.y+player.h,
        player.c
    )
    -- computer
    rectfill(
        com.x,
        com.y,
        com.x+com.w,
        com.y+com.h,
        com.c
        )
    --scores
    print(player_points,30,2,player.c)
    print(com_points,95,2,com.c)
    end
function _update()
    --player controls
    player_controls()
    --computer controls
    -- collide with com
    --collide with player
    --collide with court
    --score
    -- sound
    if scored == "player" then
        sfx(3)
    if scored == "com" then
        sfx(4)
    else
        sfx(5)
    end
    --ball movement
    end
function player_controls()
    if btn(⬆️)
    and player.x>court.top+1 then
        player.y -=player.speed
    end
    if btn(⬇️)
    and player.y + player.h < court_bottom-1 then
        player.y += player.speed
    end
    end
end