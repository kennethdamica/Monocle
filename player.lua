--player

local _lg = love.graphics

local player = {
	speed = 2,
	x = 3.1,
	y = 3.1,
	height = 0.1,
	width = 0.1,
	radius = 5
}

	player.update = function(self, dt, level)
		self:movement(dt, level)
	end
	
	player.draw = function(self)
		_lg.setColor(255,0,0)
		_lg.circle('fill', player.x*tileSize,player.y*tileSize, player.radius, 100)
	end
	
	player.movement = function(self, dt, level)
		local moved = false
		--Character Movement (needs collision detection with walls, edge of screen)
		if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
			if CheckTileCollisions(level, self.x- self.speed*dt - self.width/2, self.y -self.height/2 , self.width, self.height, 1) then
				self.x = self.x - self.speed*dt
				moved = true
			end
		end
		if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
			if CheckTileCollisions(level, self.x+ self.speed*dt- self.width/2, self.y -self.height/2, self.width, self.height, 1) then
				self.x = self.x + self.speed*dt
				moved = true
			end
		end
		if love.keyboard.isDown("up") or love.keyboard.isDown("w")then
			if CheckTileCollisions(level, self.x- self.width/2, self.y  - self.speed*dt -self.height/2, self.width, self.height, 1) then
				self.y = self.y - self.speed*dt
				moved = true
			end
		end
		if love.keyboard.isDown("down") or love.keyboard.isDown("s") then
			if CheckTileCollisions(level, self.x- self.width/2, self.y + self.speed*dt -self.height/2, self.width, self.height, 1) then
				self.y = self.y + self.speed*dt
				moved = true
			end
		end
	end



return player
