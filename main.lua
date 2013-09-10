lights = require('monocle')

local _lg = love.graphics
local _mouse = love.mouse
pi = math.pi


function love.load()
	map_height = 12
	map_width = 18
	tileSize = 40
	player = require('player')
	level = GenerateMap(map_width,map_height)
	sprite_canvas = _lg.newCanvas()
	DEBUG = false
	draw_monocle = true
end

function love.update(dt)
	player:update(dt, level)
end

function love.draw()
	_lg.setBlendMode('alpha')
	for i = 1, #level do
		for j = 1, #level[i] do
			if level[i][j].solid then
				_lg.setColor(50,50,200)
			else 
				_lg.setColor(100,100,100)
			end
			_lg.rectangle('fill', j*tileSize, i*tileSize, tileSize, tileSize)
		end
	end
	player:draw()
	_lg.setCanvas()
	_lg.draw(sprite_canvas)
	_lg.setCanvas()
	lights:draw(player.x,player.y,level,tileSize, DEBUG, draw_monocle)
	_lg.setBlendMode('multiplicative')
	if draw_monocle then
		_lg.draw(lights.canvas)
	end
	_lg.setBlendMode('alpha')
	_lg.setColor(255,255,255)
	_lg.print('X:' .. player.x .. ';Y:' .. player.y, 0,0)
	_lg.print('Press "b" to toggle debug mode',0,12)
	_lg.print('Press "n" to toggle Monocle mode',0,24)
	_lg.print('Press "t" to teleport player to (3,3)',0,36)
end

function love.keypressed(key,code)
	if key == 'b' then
		DEBUG = not DEBUG
	elseif key == 'n'then
		draw_monocle = not draw_monocle
	elseif key == 't' then
		player.x=3
		player.y=3
	end
end

function love.mousepressed(x,y,button)

end

function CheckTileCollisions(map, rectx, recty, rectw, recth, tileSize)
	local firstTileX = math.floor(rectx / tileSize)
	local firstTileY = math.floor(recty / tileSize)
	local lastTileX = math.floor((rectx + rectw) / tileSize)
	local lastTileY = math.floor((recty + recth) / tileSize)
	local noCollision = true
	
	for i = firstTileY, lastTileY do
		for j = firstTileX, lastTileX do
			if map[i] then
				if map[i][j] then
					if map[i][j].solid then
						noCollision = false
						return noCollision
					end
				end
				
			end
		end
	end
	
	return noCollision
end

function GenerateMap(w,h)

	local map = {}
	for i = 1,math.ceil(h) do
		map[i] = {}
		for j = 1,math.ceil(w) do
			map[i][j] = {}
			if this_level[i][j] == 1 then
				map[i][j].solid = true
			else
				map[i][j].solid = false
			end 
		end
	end

	return map	
end

function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

--[[this_level2 = {
	{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
	{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
	{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
	{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
	{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
	{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
	{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
	{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
	{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
	{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
	{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1},
	{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
}]]

this_level = {
	{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
	{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
	{1,0,0,0,0,0,0,0,1,0,0,0,1,0,1,1,0,1},
	{1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,1},
	{1,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,1},
	{1,0,0,1,1,1,0,0,0,0,1,0,1,0,1,0,0,1},
	{1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1},
	{1,0,0,1,1,1,0,0,0,0,1,0,1,0,1,0,0,1},
	{1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1},
	{1,0,0,0,0,0,0,0,0,0,1,0,1,0,1,0,0,1},
	{1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1},
	{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
}