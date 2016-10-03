local paddles = require "entities.paddles"
local debugWorldDraw = require "debugworlddraw"

local PlayScene = oo.class()

-- playscene globals
function PlayScene:init()
	self.entities = EntityList.new()
	self.world = lp.newWorld()
	player1 = paddles.Sophia.new(self, p1input, 50, 300)
	player2 = paddles.BobLong.new(self, p2input, 750, 300)
	self.entities:add(player1)
	self.entities:add(player2)
	
	-- boundaries
	local function makeWall(x, y, w, h)
		local body = lp.newBody(self.world, x, y, "static")
		local shape = lp.newRectangleShape(w, h)
		local fixture = lp.newFixture(body, shape)
	end
	makeWall(400, 0, 800, 20)
	makeWall(400, 600, 800, 20)
end

function PlayScene:enter(prevScene)
	signal.register("update", self.update)
	signal.register("draw", self.draw)
end

function PlayScene:leave(nextScene)
	signal.remove("update", self.update)
	signal.remove("draw", self.draw)
end

function PlayScene:update(dt)
	for e in self.entities:each() do
		e:update(dt)
	end
	self.world:update(dt)
end

function PlayScene:draw()
	debugWorldDraw(self.world, -1000, -1000, 2000, 2000)
end

return PlayScene