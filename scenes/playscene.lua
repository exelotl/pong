local paddles = require "entities.paddles"
local debugWorldDraw = require "debugworlddraw"
local Ball = require "entities.ball"
local Wall = require "entities.wall"
local Goal = require "entities.goal"

local MenuScene = require "scenes.menuscene"

local PlayScene = oo.class()

-- two fixtures that were recently involved in a collision
local f1, f2

function hasCategory(fixture, cat)
	for i,v in ipairs{fixture:getCategory()} do
		if v == cat then return true end
	end
	return false
end

function collide(fixture)
	return fixture == f1 and f2 or fixture == f2 and f1 or nil
end

local function makeCollisionCb(name)
	return function (a,b)
		f1, f2 = a, b
		signal.emit(name)
	end
end

-- playscene globals
function PlayScene:init(p1class, p2class)
	self.entities = EntityList.new()
	self.balls = EntityList.new()
	self.world = lp.newWorld()
	self.addlePower = true
	
	self.winner = nil
	self.winTimer = 0
	
	self.world:setCallbacks(
		makeCollisionCb("begin_contact"),
		makeCollisionCb("end_contact"),
		makeCollisionCb("pre_solve"),
		makeCollisionCb("post_solve")
	)
	
	player1 = p1class.new(self, p1input, 50, 300)
	player2 = p2class.new(self, p2input, 750, 300)
	ball1 = Ball.new(self, 400, 300)
	
	self.entities:add(player1)
	self.entities:add(player2)
	self.balls:add(ball1)
	
	self.p1score = 0
	self.p2score = 0
	
	Wall.new(self, 400, 0, 800, 20)
	Wall.new(self, 400, 600, 800, 20)
	Wall.new(self, 0, 100, 80, 200)
	Wall.new(self, 0, 500, 80, 200)
	Wall.new(self, 800, 100, 80, 200)
	Wall.new(self, 800, 500, 80, 200)
	
	self.goal1 = Goal.new(self, 0, 300, 40, 600)
	self.goal2 = Goal.new(self, 800, 300, 40, 600)
	
	self.nextFrameFuncs = {}
end

function PlayScene:score(ball, goal)
	if goal == self.goal1 then
		self.p2score = self.p2score + 1
	elseif goal == self.goal2 then
		self.p1score = self.p1score + 1
	else
		return
	end
	table.insert(self.nextFrameFuncs, function()
		self.balls:remove(ball)
		ball.body:destroy()
		self.balls:add(Ball.new(self, 400, 300))
	end)
	-- todo: remove the ball
end

function PlayScene:enter(prevScene)
	--sounds.go:play()
	signal.register("update", self.update)
	signal.register("draw", self.draw)
end

function PlayScene:leave(nextScene)
	signal.remove("update", self.update)
	signal.remove("draw", self.draw)
end

function PlayScene:update(dt)
	
	if self.winner then
		self.winTimer = self.winTimer - dt
		if self.winTimer <= 0 then
			local sound = sounds[getmetatable(self.winner)]
			if sound then
				sound.win:play()
			end
			setScene(MenuScene.new())
		end
		return
	end
	
	for e in self.entities:each() do
		e:update(dt)
	end
	
	for e in self.balls:each() do
		e:update(dt)
	end
	
	self.world:update(dt)
	
	for i,v in ipairs(self.nextFrameFuncs) do
		v()
	end
	self.nextFrameFuncs = {}
	
	local dscore = (self.p1score - self.p2score)
	if dscore == 5 then
		sounds.p1win:play()
		self.winner = player1
		self.winTimer = 3.0
	elseif dscore == -5 then
		sounds.p2win:play()
		self.winner = player2
		self.winTimer = 3.0
	end
end

function PlayScene:draw()
	debugWorldDraw(self.world, -1000, -1000, 2000, 2000)
	for e in self.entities:each() do
		e:draw()
	end
	
	for e in self.balls:each() do
		e:draw()
	end
	
	local dx = (self.p1score - self.p2score) * 40
	lg.setColor(49,162,242)
	lg.rectangle("fill", 200, 20, 200+dx, 20)
	lg.setColor(190,38,51)
	lg.rectangle("fill", 400+dx, 20, 200-dx, 20)
end

return PlayScene