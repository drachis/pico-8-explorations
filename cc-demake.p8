pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- cobalt core demake for pico-8
-- by assistant

-- game state
player = {x=4, y=2}
enemy = {x=4, y=0}
hand = {}
deck = {}
discard = {}
energy = 3
turn = "player"
selected = nil

-- card types
card_types = {"a", "m", "d"}

function _init()
  init_deck()
  deal_hand()

end

function _update()
  if turn == "player" then
    if btnp(⬅️) then
      selected = max(1, (selected or 1) - 1)
    elseif btnp(➡️) then
      selected = min(#hand, (selected or 0) + 1)
    elseif btnp(⬆️) then
      selected = max(1, (selected or 3) - 3)
    elseif btnp(⬇️) then
      selected = min(#hand, (selected or 3) + 3)
    elseif btnp(🅾️) then
      play_card()
    elseif btnp(❎) then
      end_turn()
    end
  else
    enemy_turn()
    turn = "player"
  end
end

function _draw()
  cls()
  draw_grid()
  display_hand()
  draw_ui()
end

function init_deck()
  deck = {}
  for i=1,4 do
    for _,t in pairs(card_types) do
      add(deck, t)
    end
  end
  shuffle(deck)
end

function shuffle(t)
  for i=#t,2,-1 do
    local j = flr(rnd(i))+1
    t[i], t[j] = t[j], t[i]
  end
end

function deal_hand()
  while #hand < 5 and (#deck > 0 or #discard > 0) do
    if #deck == 0 then
      deck, discard = discard, deck
      shuffle(deck)
    end
    add(hand, del(deck, 1))
  end
end

function play_card()
  if selected and energy > 0 and #hand > 0 then
    local card = hand[selected]
    add(discard, del(hand, selected))
    energy -= 1
    
    if card == "m" then
      player.x = mid(0, player.x + (rnd() < 0.5 and -1 or 1), 7)
    elseif card == "a" then
      if player.x == enemy.x then
        -- hit enemy
      end
    elseif card == "d" then
      -- defend
    end
    
    selected = min(selected, #hand)
    if energy == 0 then turn = "enemy" end
    deal_hand()
  end
end

function end_turn()
  energy = 3
  deal_hand()
  turn = "enemy"
end

function enemy_turn()
  local action = card_types[flr(rnd(3))+1]
  if action == "m" then
    enemy.x = mid(0, enemy.x + sgn(player.x - enemy.x), 7)
  elseif action == "a" then
    if enemy.x == player.x then
      -- hit player
    end
  elseif action == "d" then
    -- defend
  end
end

function draw_grid()
  for x=0,7 do
    for y=0,2 do
      rect(x*12, y*12, x*12+11, y*12+11, 5)
    end
  end
  
  -- draw player
  circfill(player.x*12+6, player.y*12+6, 5, 12)
  
  -- draw enemy
  circfill(enemy.x*12+6, enemy.y*12+6, 5, 8)
end

function display_hand()
  for i=1,#hand do
    local x = ((i-1)%3)*20 + 44
    local y = flr((i-1)/3)*20 + 50
    rectfill(x, y, x+19, y+19, 1)
    rect(x, y, x+19, y+19, 7)
    print(hand[i], x+8, y+7, 7)
    if i == selected then
      rect(x-1, y-1, x+20, y+20, 10)
    end
  end
end

function draw_ui()
  print("energy: "..energy, 2, 2, 7)
  print(turn.." turn", 80, 2, 7)
  
  -- deck marker
  rectfill(110, 50, 126, 70, 1)
  rect(110, 50, 126, 70, 7)
  print("deck", 112, 54, 7)
  print(#deck, 116, 62, 7)
  
  -- discard marker
  rectfill(110, 80, 126, 100, 1)
  rect(110, 80, 126, 100, 7)
  print("disc", 112, 84, 7)
  print(#discard, 116, 92, 7)
end