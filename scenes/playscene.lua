local paddles = require "entities.paddles"
local ball = require "entities.ball"
local debugWorldDraw = require "debugworlddraw"
local Ball = require "entities.ball"

local PlayScene = oo.class()

-- playscene globals
function PlayScene:init(p1class, p2class)
	self.entities = EntityList.new()
	self.balls = EntityList.new()
	self.world = lp.newWorld()
	self.world:setCallbacks(beginContact, endContact, preSolve, postSolve)
	player1 = p1class.new(self, p1input, 50, 300)
	player2 = p2class.new(self, p2input, 750, 300)
	ball1 = ball.new(self, 400, 300)
	self.entities:add(player1)
	self.entities:add(player2)
	self.balls:add(ball1)
	
	-- boundaries
	local function makeWall(x, y, w, h)
	local body = lp.newBody(self.world, x, y, "static")
	local shape = lp.newRectangleShape(w, h)
	local fixture = lp.newFixture(body, shape)
	fixture:setCategory(2)
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
	
	for e in self.balls:each() do
		e:update(dt)
	end
	
	self.world:update(dt)
end

function PlayScene:draw()
	debugWorldDraw(self.world, -1000, -1000, 2000, 2000)
	for e in self.entities:each() do
		e:draw()
	end
	
	for e in self.balls:each() do
		e:draw()
	end
end

function beginContact(a, b, coll)
	coll:setRestitution(1)
end

function endContact(a, b, coll)
  
end

function preSolve(a, b, coll)
  
end

function postSolve(a, b, coll)

end

return PlayScene