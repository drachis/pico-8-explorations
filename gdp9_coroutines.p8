pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
function _init()
    c_move=cocreate(move)
end

function _update()
    if c_move and costatus(c_move)!="dead" then coresume(c_move)
    else
        c_move=nil
    end
    if (btnp()>0) c_move=cocreate(move)
end

function _draw()
    cls(1)
    circ(x,y,r,12)
    print(current, 4,4,7)
end

function move()
    x,y,r=32,32.8
    current="left to right"
    for i=32,96 do
        x=i
        yield()
    end
    current ="top to bottom"
    for j=32,96 do
        y=j
        yield()
    end

    current ="back to start"
    for i=96,32,-1 do
        x,y=i,i
        yield()
    end
end
