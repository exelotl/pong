
local Paddle = oo.class()

function Paddle:init(scene, input, x, y)
	self.scene = scene
	self.input = input
	self.ox = x
	self.oy = y
end

function Paddle:checkSuper()
	return true
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
	self.fixture:setCategory(CAT_PADDLE)
	self.fixture:setUserData(self)
end

function BobLong:update(dt)
	local i = self.input
	local vx = (i:get("right") - i:get("left")) * 400 
	local vy = (i:get("down") - i:get("up")) * 400 
	local w = (i:get("rotr") - i:get("rotl")) * 5 
	self.body:setLinearVelocity(vx, vy)
	self.body:setAngularVelocity(w)
	
	if self.input:pressed("special") then
		self:useSuper()
	end
	
end

function BobLong:useSuper()
		
	self.fixture:destroy()
	self.shape = lp.newRectangleShape(40,140)
	self.fixture = lp.newFixture(self.body, self.shape)
	self.fixture:setCategory(1)

end

function BobLong:endSuper()
		
	self.fixture:destroy()
	self.shape = lp.newRectangleShape(40,100)
	self.fixture = lp.newFixture(self.body, self.shape)
	self.fixture:setCategory(1)

end

local Sophia = oo.class(Paddle)

function Sophia:init(scene, input, x, y)
	Paddle.init(self, scene, input, x, y)
	self.body = lp.newBody(scene.world, x, y, "dynamic")
	self.body:setFixedRotation(true)
	self.shape = lp.newCircleShape(40)
	self.fixture = lp.newFixture(self.body, self.shape)
	self.fixture:setCategory(CAT_PADDLE)
	self.fixture:setUserData(self)
end

function Sophia:update(dt)
	local i = self.input
	local vx = (i:get("right") - i:get("left")) * 400 
	local vy = (i:get("down") - i:get("up")) * 400 
	self.body:setLinearVelocity(vx, vy)
	
	self:useSuper()
	
end

function Sophia:useSuper()
	
	local vx = (self.input:get("rotr") - self.input:get("rotl")) * 3 
	local vy = (self.input:get("rotu") - self.input:get("rotd")) * 3

	
	for e in self.scene.balls:each() do
		x,y = e.body:getLinearVelocity()
		e.body:setLinearVelocity(x+vx, y+vy)
	end

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
	self.fixture:setCategory(CAT_PADDLE)
	self.fixture:setUserData(self)
end

function DrStoptagon:update(dt)
	local i = self.input
	local vx = (i:get("right") - i:get("left")) * 400 
	local vy = (i:get("down") - i:get("up")) * 400 
	local w = (i:get("rotr") - i:get("rotl")) * 5 
	self.body:setLinearVelocity(vx, vy)
	self.body:setAngularVelocity(w)
	
	if self.input:pressed("special") then
		self:useSuper()
	end
end

function DrStoptagon:useSuper()
		
	for e in self.scene.balls:each() do
		e.body:setLinearVelocity(0,0)
		e.body:setAngularVelocity(0,0)
	end

end

local SeriousSum = oo.class(Paddle)

function SeriousSum:init(scene, input, x, y)
	Paddle.init(self, scene, input, x, y)
	self.body = lp.newBody(scene.world, x, y, "dynamic")
	self.shape = lp.newRectangleShape(40, 100)
	self.shape2 = lp.newRectangleShape(100, 40)
	self.fixture = lp.newFixture(self.body, self.shape)
	self.fixture:setCategory(CAT_PADDLE)
	self.fixture:setUserData(self)
	self.fixture2 = lp.newFixture(self.body, self.shape2)
	self.fixture2:setCategory(CAT_PADDLE)
	self.fixture2:setUserData(self)
end

function SeriousSum:update(dt)
	local i = self.input
	local vx = (i:get("right") - i:get("left")) * 400 
	local vy = (i:get("down") - i:get("up")) * 400 
	local w = (i:get("rotr") - i:get("rotl")) * 5 
	self.body:setLinearVelocity(vx, vy)
	self.body:setAngularVelocity(w)
	
	if self.input:pressed("special") then
		self:useSuper()
	end
end

function SeriousSum:useSuper()
		
	if self == player1 then
		ball1 = ball.new(self, self.body:getX() + 50, self.body:getY())
		ball1.body:setLinearVelocity(225,0)
		self.scene.balls:add(ball1)
	
	else
		ball1 = ball.new(self, self.body:getX() - 50, self.body:getY())
		ball1.body:setLinearVelocity(-225,0)
		self.secne.balls:add(ball1)

	end
	
	
end
	

function SeriousSum:useSuper()
	
	

end

local TetrisSquiggle = oo.class(Paddle)

function TetrisSquiggle:init(scene, input, x, y)
	Paddle.init(self, scene, input, x, y)
	self.body = lp.newBody(scene.world, x, y, "dynamic")
	self.shape = lp.newPolygonShape(-40, -60, -- top left
                                   0, -60, -- top right
                                   0, 20, -- left bottom
                                   -40, 20) -- left top
    self.shape2 = lp.newPolygonShape(0,-20,
                                    40,-20,
                                    40,60,
                                    0,60)
	self.fixture = lp.newFixture(self.body, self.shape)
	self.fixture:setCategory(1)
    self.fixture2 = lp.newFixture(self.body,self.shape2)
    self.fixture:setCategory(1)
end

function TetrisSquiggle:update(dt)
	local i = self.input
	local vx = (i:get("right") - i:get("left")) * 400 
	local vy = (i:get("down") - i:get("up")) * 400 
	local w = (i:get("rotr") - i:get("rotl")) * 5 
	self.body:setLinearVelocity(vx, vy)
	self.body:setAngularVelocity(w)
end

function TetrisSquiggle:useSuper()
	
	
	
end

local Twins = oo.class(Paddle)

function Twins:init(scene, input, x, y)
	Paddle.init(self, scene, input, x, y)
	self.bodyA = lp.newBody(scene.world, x, y-20, "dynamic")
    self.bodyB = lp.newBody(scene.world, x, y+20, "dynamic")
	self.bodyA:setFixedRotation(true)
    self.bodyB:setFixedRotation(true)
	self.shapeA = lp.newCircleShape(20)
    self.shapeB = lp.newCircleShape(20)
	self.fixtureA = lp.newFixture(self.bodyA, self.shapeA)
    self.fixtureB = lp.newFixture(self.bodyB, self.shapeB)
	self.fixtureA:setCategory(1)
    self.fixtureB:setCategory(1)
end

function Twins:update(dt)
	local i = self.input
	local vxA = (i:get("right") - i:get("left")) * 400 
	local vyA = (i:get("down") - i:get("up")) * 400 
	self.bodyA:setLinearVelocity(vxA, vyA)
    local vxB = (i:get("rotr") - i:get("rotl")) * 400 
	local vyB = (i:get("rotd") - i:get("rotu")) * 400 
	self.bodyB:setLinearVelocity(vxB, vyB)
end

local PAddle = oo.class(Paddle)

function PAddle:init(scene, input, x, y)
	Paddle.init(self, scene, input, x, y)
	self.body = lp.newBody(scene.world, x, y, "dynamic")
	self.shape = lp.newPolygonShape(-20, 0, -- top left
                                   0, 50, -- top right
                                   20, 50, -- left bottom
                                   0, 0) -- left top
    self.shape2 = lp.newPolygonShape(-20,0,
                                    0,0,
                                    20,-50,
                                    0,-50)
	self.fixture = lp.newFixture(self.body, self.shape)
	self.fixture:setCategory(1)
    self.fixture2 = lp.newFixture(self.body,self.shape2)
    self.fixture:setCategory(1)
end

function PAddle:update(dt)
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
	SeriousSum = SeriousSum,
    TetrisSquiggle = TetrisSquiggle,
    Twins = Twins,
    PAddle = PAddle
}
