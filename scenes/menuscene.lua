
local menuScene = oo.class()
local menucontroller = require "entities.menucontroller"

function menuScene:init()
  player1 = menucontroller.new(self, p1input, 0)
  player2 = menucontroller.new(self, p2input, 0)
  self.charImages = require "images/charimages"
end

function menuScene:enter()
  signal.register("update", self.update)
  signal.register("draw", self.draw)
end

function menuScene:leave()
  signal.remove("update", self.update)
  signal.remove("draw", self.draw)  
end

function menuScene:update(dt)
  player1:update(dt)
  player2:update(dt)
end

function menuScene:draw()
	love.graphics.draw(self.charImages[player1:getCurrentChar()], 0, 0)
  love.graphics.draw(self.charImages[player2:getCurrentChar()], 400, 0)
end

return menuScene