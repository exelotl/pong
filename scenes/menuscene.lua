local PlayScene = require "scenes.playscene"

local menuScene = oo.class()
local menucontroller = require "entities.menucontroller"

function menuScene:init()
	self.charImages = require "images/charimages"
    player1s = menucontroller.new(self, p1input, 1, #self.charImages)
    player2s = menucontroller.new(self, p2input, 1, #self.charImages)
	
end

function menuScene:enter()
  signal.register("update", self.update)
  signal.register("draw", self.draw)
end

function menuScene:leave()
  signal.remove("update", self.update)
  signal.remove("draw", self.draw)  
end

function menuScene:changeScene()
	setScene(PlayScene.new(self.charImages[player1s:getCurrentChar()].class, 
							self.charImages[player2s:getCurrentChar()].class))
end

function menuScene:update(dt) 

	if not player1s:checkselect() then
		player1s:update(dt)
	
	else
		if player2s:checkselect() then
			if player1s:checkagree() or player2s:checkagree() then
				self:changeScene()
			end
		end
			
	end
	
	if not player2s:checkselect() then
		player2s:update(dt)
	end
  
end

function menuScene:draw()
	love.graphics.setColor(255,255,255,255)
	love.graphics.rectangle( "fill", 0, 0, 800, 600)
	love.graphics.draw(self.charImages[player1s:getCurrentChar()].image, 100, 200)
    love.graphics.draw(self.charImages[player2s:getCurrentChar()].image, 500, 200)
	love.graphics.setColor(0,0,0,255)
	love.graphics.rectangle( "line", 100, 200, 200, 200)
	love.graphics.rectangle( "line", 500, 200, 200, 200)
end

return menuScene