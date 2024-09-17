pico-8 cartridge // http://www.pico-8.com
version 42
__lua__

function _init()
	game_over = false
	make_player()
	make_cave()
end

function _update()
	if (not game_over) then
		move_player()
		update_cave()
		check_hit()
	end
end

function _draw()
	cls()
	draw_cave()
	draw_player()

	if ( game_over) then
		print("game over!", 44,44,7)
		print("your score:"..player.score, 34,54,7)
	else
		print("score:"..player.score,2,2,7)
	end
end

-->8
function check_hit()
	for i=player.x,player.x+7 do
		if (cave[i+1].top>player.y
		or cave[i+1].btm<player.y+7) then
			game_over = true
		end
	end
end

function make_player()
	player = {}
	player.x = 24
	player.y = 60
	player.dy = 0
	--sprite
	player.rise = 1
	player.fall = 2
	player.dead = 3
	player.speed = 5
	-- fly forward speed
	player.score = 0
end

function draw_player()
	if game_over then
		spr(player.dead, player.x, player.y)
	elseif player.dy < 0 then
		spr(player.rise, player.x, player.y)
	else
		spr(player.fall, player.x, player.y)
	end
end

function move_player()
	gravity = 0.4
	player.dy = gravity
	-- add gravity

	if (btnp(2)) then
		player.dy -= 5
	end

	-- move to new position
	player.y += player.dy
end
-->8
function make_cave()
	cave = {{["top"]=5,["btm"]=119}}
	top=45 -- how low can the ceiling go?
	btm=85 -- how high can the floor get?
end

function update_cave()
	-- remove the back of the cave
	if (#cave>player.speed) then
		for i=1, player.speed do
			del(cave, cave[1])
		end
	end
	--add more cave
	while (#cave<128) do
		local col ={}
		local up = flr(rnd(7)-3)
		local dwn=flr(rnd(7)-3)
		col.top=min(mid(3,cave[#cave].top+up, top),top)
		col.btm=max(mid(btn,cave[#cave].btm+dwn,124),btm)
		add(cave,col)
	end
end

function draw_cave()
	top_color=5
	btm_color=6
	for i=1,#cave do
		line(i-1,0,i-1,cave[i].top,top_color)
		line(i-1,127,i-1,cave[i].btm, btm_color)
	end
end
__gfx__
00000000000000000000000000090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000008800000000000090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000bbb000000880000cc000000090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00bbb00000088000000ccc0000090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00b00b000088000000000c0000090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00bb0b000800000000000cc000090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000bbb00000000000000000000009000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000009000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
