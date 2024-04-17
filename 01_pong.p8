pico-8 cartridge // http://www.pico-8.com
version 42
__lua__

paddle1 = {
    x=11+5+10,
    y=56,
    h=18,
    w=2,
    speed=4,
    color=9,
    score=0,
    score_x=10,
    score_y=2
}
paddle2= {
    x=117-5,
    y=56,
    h=18,
    w=2,
    speed=2,
    color=4,
    score=0,
    score_x=118,
    score_y=2
}
court = {
    x0 = 10,
    y0 = 10,
    x1=120,
    y1=120,
    color=5
}
ball = {
    x=128/2,
    y=128/2,
    dx=2,
    dy=1,
    r=2,
    color=5
}
centerline={
    x0=128/2,
    y0=15
}
function _init()
end
function _draw()
    cls(0)
    rectfill(
        paddle1.x,
        paddle1.y,
        paddle1.x+paddle1.w,
        paddle1.y+paddle1.h,
        paddle1.color
    )
    rectfill(
        paddle2.x,
        paddle2.y,
        paddle2.x+paddle2.w,
        paddle2.y+paddle2.h,
        paddle2.color
    )
    rect(
        court.x0,
        court.y0,
        court.x1,
        court.y1,
        court.color
        )
    for line_y = centerline.y0, 116, 16 do
        line(
            centerline.x0,
            line_y,
            centerline.x0,
            line_y+4)
        
    end
    circfill(
        ball.x,
        ball.y,
        ball.r,
        ball.color
    )
    print(
        paddle1.score,
        paddle1.score_x,
        paddle1.score_y,
        paddle1.color
    )
    print(
        paddle2.score,
        paddle2.score_x,
        paddle2.score_y,
        paddle2.color
    )
    print(ball.x, 16,16,6)
    print(ball.y, 16,26,7)
end
function _update()
    -- ball things
    ball.x += ball.dx
    ball.y += ball.dy
    -- ball conllision with court
    if ball.x+ball.r+2 > court.x1 then
        ball.dx *= -1
        paddle1.score +=3
    end
    if ball.x-ball.r-2 < court.x0 then
        ball.dx *= -1
        paddle2.score +=0
    end
    if ball.y+ball.r+2 > court.y1 then
        ball.dy *= -1 
    end
    if ball.y-ball.r-2 < court.y0 then
        ball.dy *= -1 
    end

    --paddle 1 collide
    if ball.x - ball.r - 2  < paddle1.x and 
        ball.y>paddle1.y and 
        ball.y<paddle1.y+paddle1.h and
        ball.dx < 0 then
        ball.dx *= -1
        ball.color=8
    end

    -- paddle 2 hit
    if ball.x + ball.r + 2  > paddle2.x and 
        ball.y>paddle2.y and 
        ball.y<paddle2.y+paddle2.h and
        ball.dx > 0 then
        ball.dx *= -1
        ball.color=9
    end

    if btn(2,1) and paddle1.y>court.y0+2 then
        paddle1.y-=paddle1.speed
    end
    if btn(3,1) and paddle1.y+paddle1.h<court.y1-2 then
        paddle1.y+=paddle1.speed
    end

    if btn(2,0) and paddle2.y>court.y0+2 then
        paddle2.y-=paddle2.speed
    end
    if btn(3,0) and paddle2.y+paddle2.h<court.y1-2 then
        paddle2.y+=paddle2.speed
    end
end

