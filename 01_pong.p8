pico-8 cartridge // http://www.pico-8.com
version 42
__lua__

paddle1 = {
    x=117-5,
    y=56,
    h=18,
    w=2,
    color=9,
    score=0,
    score_x=118,
    score_y=2
}
paddle2= {
    x=11+5,
    y=56,
    h=18,
    w=2,
    color=4,
    score=0,
    score_x=10,
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
    dx=4,
    dy=2,
    radius=2,
    color=6
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
        ball.radius,
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
    ball.x += ball.dx
    ball.y += ball.dy

    if ball.x > court.x1 then
        ball.dx *= -1
    end
    if ball.x < court.x0 then
        ball.dx *= -1
    end
    if ball.y > court.y1 then
        ball.dy *= -1 
    end
    if ball.y < court.y0 then
        ball.dy *= -1 
    end
end

