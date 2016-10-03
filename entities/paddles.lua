
local Paddle = oo.class()

function Paddle:init(scene, input, x, y)
	self.scene = scene
	self.input = input
	self.ox = x
	self.oy = y
end

function Paddle:update(dt)
end

function Paddle:draw()
end

local BobLong = oo.class(Paddle)

function BobLong:init(scene, input, x, y)
	Paddle.init(self, scene, input, x, y)
	self.body = lp.newBody(scene.world, x, y, "dynamic")
	self.shape = lp.newRectangleShape(40, 100)
	self.fixture = lp.newFixture(self.body, self.shape)
	self.fixture:setCategory(1)
end

function BobLong:update(dt)
	local i = self.input
	local vx = (i:get("right") - i:get("left")) * 400 
	local vy = (i:get("down") - i:get("up")) * 400 
	local w = (i:get("rotr") - i:get("rotl")) * 5 
	self.body:setLinearVelocity(vx, vy)
	self.body:setAngularVelocity(w)
end


local Sophia = oo.class(Paddle)

function Sophia:init(scene, input, x, y)
	Paddle.init(self, scene, input, x, y)
	self.body = lp.newBody(scene.world, x, y, "dynamic")
	self.body:setFixedRotation(true)
	self.shape = lp.newCircleShape(40)
	self.fixture = lp.newFixture(self.body, self.shape)
	self.fixture:setCategory(1)
end

function Sophia:update(dt)
	local i = self.input
	local vx = (i:get("right") - i:get("left")) * 400 
	local vy = (i:get("down") - i:get("up")) * 400 
	self.body:setLinearVelocity(vx, vy)
end

function Sophia:draw()
end


local DrStoptagon = oo.class(Paddle)
local size = 40
local sideln = 0.4142 * (size*2)
local sidetria = sideln/1.41421

function DrStoptagon:init(scene, input, x, y)
	Paddle.init(self, scene, input, x, y)
	self.body = lp.newBody(scene.world, x, y, "dynamic")
	self.body:setFixedRotation(true)
	self.shape = lp.newPolygonShape(-size + sidetria, -size, -- top left
                                   size - sidetria, -size, -- top right
                                   size,- size + sidetria, -- right top
                                   size, size - sidetria, -- right bottom
                                   size - sidetria, size, -- bottom right
                                  -size + sidetria, size, -- bottom left
                                  -size, - size + sidetria, -- left bottom
                                  -size, size - sidetria ) -- left top

	self.fixture = lp.newFixture(self.body, self.shape)
	self.fixture:setCategory(1)
end

function DrStoptagon:update(dt)
	local i = self.input
	local vx = (i:get("right") - i:get("left")) * 400 
	local vy = (i:get("down") - i:get("up")) * 400 
	local w = (i:get("rotr") - i:get("rotl")) * 5 
	self.body:setLinearVelocity(vx, vy)
	self.body:setAngularVelocity(w)
end

local SeriousSum = oo.class(Paddle)

function SeriousSum:init(scene, input, x, y)
	Paddle.init(self, scene, input, x, y)
	self.body = lp.newBody(scene.world, x, y, "dynamic")
	self.shape = lp.newRectangleShape(40, 100)
	self.shape2 = lp.newRectangleShape(100, 40)
	self.fixture = lp.newFixture(self.body, self.shape)
	self.fixture:setCategory(1)
	self.fixture2 = lp.newFixture(self.body, self.shape2)
	self.fixture2:setCategory(1)
end

function SeriousSum:update(dt)
	local i = self.input
	local vx = (i:get("right") - i:get("left")) * 400 
	local vy = (i:get("down") - i:get("up")) * 400 
	local w = (i:get("rotr") - i:get("rotl")) * 5 
	self.body:setLinearVelocity(vx, vy)
	self.body:setAngularVelocity(w)
end

return {
	BobLong = BobLong,
	Sophia = Sophia,
	DrStoptagon = DrStoptagon,
	SeriousSum = SeriousSum
}
