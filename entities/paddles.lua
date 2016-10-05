
local ball = require('entities.ball')

local Paddle = oo.class()

function Paddle:init(scene, input, x, y)
	self.scene = scene
	self.input = input
	self.ox = x
	self.oy = y
	self.maxPower = 40
	self.rechargeRate = 1
	self.powerLevel = 40
	self.powerLoss = 20
end

function Paddle:checkSuper()
	return true
end


function Paddle:usePowerWithEnd(dt)
	if self.input:pressed("special") and self.powerLevel >= self.powerLoss*0.5 then
		self:useSuper()
		self.superActive = true
	end
		
	if self.superActive then
		
		self.powerLevel = self.powerLevel - self.powerLoss*dt
		
		if self.powerLevel <= self.powerLoss*0.5 then
			self:endSuper()
			self.superActive = false
		end
		
	else
		
		if self.powerLevel < self.maxPower then
			self.powerLevel = self.powerLevel + self.rechargeRate*dt
		end
		
	end	
end

function Paddle:usePowerWithoutEnd(dt)
	if self.input:pressed("special") and self.powerLevel >= self.powerLoss*0.5 then
		self:useSuper()
		self.superActive = true
	end
		
	if self.superActive then
		
		self.powerLevel = self.powerLevel - self.powerLoss*dt
		
		if self.powerLevel <= self.powerLoss*0.5 then
			self.superActive = false
		end
		
	else
		
		if self.powerLevel < self.maxPower then
			self.powerLevel = self.powerLevel + self.rechargeRate*dt
		end
		
	end	
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
	self.superActive = false
end

function BobLong:update(dt)
	local i = self.input
	if self.scene.addlePower then
		local vx = (i:get("right") - i:get("left")) * 400 
		local vy = (i:get("down") - i:get("up")) * 400 
		local w = (i:get("rotr") - i:get("rotl")) * 5 
		self.body:setLinearVelocity(vx, vy)
		self.body:setAngularVelocity(w)
		
		self:usePowerWithEnd(dt)
		
	else
		local vy = (i:get("down") - i:get("up")) * 400 
		self.body:setLinearVelocity(0, vy)
		self.body:setAngularVelocity(0,0)
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
	self.radius = 40
	self.shape = lp.newCircleShape(self.radius)
	self.fixture = lp.newFixture(self.body, self.shape)
	self.fixture:setCategory(CAT_PADDLE)
	self.fixture:setUserData(self)
end

function Sophia:update(dt)
	local i = self.input	
	if self.scene.addlePower then
		local vx = (i:get("right") - i:get("left")) * 400 
		local vy = (i:get("down") - i:get("up")) * 400 
		self.body:setLinearVelocity(vx, vy)
		
		self:useSuper()
	else
		local vy = (i:get("down") - i:get("up")) * 400 
		self.body:setLinearVelocity(0, vy)		
	end
	
end

function Sophia:useSuper()
	
	local vx = (self.input:get("rotr") - self.input:get("rotl")) * 3 
	local vy = (self.input:get("rotd") - self.input:get("rotu")) * 3

	
	for e in self.scene.balls:each() do
		x,y = e.body:getLinearVelocity()
		e.body:setLinearVelocity(x+vx, y+vy)
	end

end

function Sophia:draw()
	
	love.graphics.setColor(255,255,255,255)
	love.graphics.circle("fill", self.body:getX(), self.body:getY(), self.radius)
	love.graphics.setColor(147,112,219,255)
	love.graphics.circle("line", self.body:getX(), self.body:getY(), self.radius+1)
	
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
	self.maxPower = 40
	self.rechargeRate = 10
	self.powerLevel = 40
end

function DrStoptagon:update(dt)
	local i = self.input	
	if self.scene.addlePower then
		local vx = (i:get("right") - i:get("left")) * 400 
		local vy = (i:get("down") - i:get("up")) * 400 
		local w = (i:get("rotr") - i:get("rotl")) * 5 
		self.body:setLinearVelocity(vx, vy)
		self.body:setAngularVelocity(w)
		
	if self.input:pressed("special") and self.powerLevel >= 40 then
		self:useSuper()
		self.powerLevel = 0
	end
		
	if self.powerLevel < self.maxPower then
		self.powerLevel = self.powerLevel + self.rechargeRate*dt
	end
		

	else
		local vy = (i:get("down") - i:get("up")) * 400 
		self.body:setLinearVelocity(0, vy)		
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
	if self.scene.addlePower then
		local vx = (i:get("right") - i:get("left")) * 400 
		local vy = (i:get("down") - i:get("up")) * 400 
		local w = (i:get("rotr") - i:get("rotl")) * 5 
		self.body:setLinearVelocity(vx, vy)
		self.body:setAngularVelocity(w)
		
	if self.input:pressed("special") and self.powerLevel >= 40 then
		self:useSuper()
		self.powerLevel = 0
	end
		
	if self.powerLevel < self.maxPower then
		self.powerLevel = self.powerLevel + self.rechargeRate*dt
	end
		
	else
		local vy = (i:get("down") - i:get("up")) * 400 
		self.body:setLinearVelocity(0, vy)	
	end
end

function SeriousSum:useSuper()
		
	if self == player1 then
		local ball1 = ball.new(self.scene, self.body:getX() + 100, self.body:getY())
		ball1.body:setLinearVelocity(350,0)
		self.scene.balls:add(ball1)
	
	else
		local ball1 = ball.new(self.scene, self.body:getX() - 100, self.body:getY())
		ball1.body:setLinearVelocity(-350,0)
		self.scene.balls:add(ball1)

	end
	
	
end

local Tetromino = oo.class(Paddle)

function Tetromino:init(scene, input, x, y)
	Paddle.init(self, scene, input, x, y)
	self.body = lp.newBody(scene.world, x, y, "dynamic")
	self.blocksize = 30
	self.shape = lp.newPolygonShape(-self.blocksize, -(self.blocksize*1.5), -- top left
                                   0, -(self.blocksize*1.5), -- top right
                                   0, (self.blocksize*0.5), -- left bottom
                                   -(self.blocksize), (self.blocksize*0.5)) -- left top
    self.shape2 = lp.newPolygonShape(0,-(self.blocksize*0.5),
                                    self.blocksize,-(self.blocksize*0.5),
                                    self.blocksize,(self.blocksize*1.5),
                                    0,(self.blocksize*1.5))
	self.fixture = lp.newFixture(self.body, self.shape)
	self.fixture:setCategory(CAT_PADDLE)
    self.fixture2 = lp.newFixture(self.body,self.shape2)
	self.tetrisList = 1
    self.fixture:setCategory(CAT_PADDLE)
	self.rechargeRate = 10
end

function Tetromino:update(dt)
	local i = self.input
	if self.scene.addlePower then
		local vx = (i:get("right") - i:get("left")) * 400 
		local vy = (i:get("down") - i:get("up")) * 400 
		local w = (i:get("rotr") - i:get("rotl")) * 5 
		self.body:setLinearVelocity(vx, vy)
		self.body:setAngularVelocity(w)
		
	if self.input:pressed("special") and self.powerLevel >= 40 then
		self:useSuper()
		self.powerLevel = 0
	end
		
	if self.powerLevel < self.maxPower then
		self.powerLevel = self.powerLevel + self.rechargeRate*dt
	end
		
	else
		local vy = (i:get("down") - i:get("up")) * 400 
		self.body:setLinearVelocity(0, vy)	
	end
	
end

function Tetromino:useSuper()
	
	if self.tetrisList == 0 then
		self.fixture:destroy()
		if self.fixture2 then 
			self.fixture2:destroy() 
			self.fixture2 = nill
		end
		self.shape = lp.newPolygonShape(-self.blocksize, -(self.blocksize*1.5), -- top left
									   0, -(self.blocksize*1.5), -- top right
									   0, (self.blocksize*0.5), -- left bottom
									   -(self.blocksize), (self.blocksize*0.5)) -- left top
		self.shape2 = lp.newPolygonShape(0,-(self.blocksize*0.5),
										self.blocksize,-(self.blocksize*0.5),
										self.blocksize,(self.blocksize*1.5),
										0,(self.blocksize*1.5))
		self.fixture = lp.newFixture(self.body, self.shape)
		self.fixture:setCategory(1)
		self.fixture2 = lp.newFixture(self.body,self.shape2)
		self.fixture:setCategory(1)
		self.tetrisList = self.tetrisList + 1
		
		
	elseif self.tetrisList == 1 then
		self.fixture:destroy()
		if self.fixture2 then 
			self.fixture2:destroy() 
			self.fixture2 = nill
		end
		self.shape = lp.newRectangleShape(self.blocksize,self.blocksize*4)
		self.fixture = lp.newFixture(self.body, self.shape)
		self.fixture:setCategory(1)
		self.tetrisList = self.tetrisList + 1
		
	elseif self.tetrisList == 2 then
		self.fixture:destroy()
		if self.fixture2 then 
			self.fixture2:destroy() 
			self.fixture2 = nill
		end
		self.shape = lp.newRectangleShape(self.blocksize*2,self.blocksize*2)
		self.fixture = lp.newFixture(self.body, self.shape)
		self.fixture:setCategory(1)
		self.tetrisList = self.tetrisList + 1
	
	elseif self.tetrisList == 3 then
		self.fixture:destroy()
		if self.fixture2 then 
			self.fixture2:destroy() 
			self.fixture2 = nill
		end
		self.shape = lp.newRectangleShape(self.blocksize*3,self.blocksize)
		self.shape2 = lp.newPolygonShape( self.blocksize*0.5, self.blocksize*0.5,
										    self.blocksize*1.5, self.blocksize*0.5,
										    self.blocksize*0.5, self.blocksize*1.5,
											self.blocksize*1.5, self.blocksize*1.5)
		self.fixture = lp.newFixture(self.body, self.shape)
		self.fixture:setCategory(1)
		self.fixture2 = lp.newFixture(self.body,self.shape2)
		self.fixture:setCategory(1)
		self.tetrisList = self.tetrisList + 1
		
	elseif self.tetrisList == 4 then
		self.fixture:destroy()
		if self.fixture2 then 
			self.fixture2:destroy() 
			self.fixture2 = nill
		end
		self.shape = lp.newRectangleShape(self.blocksize*3,self.blocksize)
		self.shape2 = lp.newPolygonShape( self.blocksize*0.5, -self.blocksize*0.5,
										    self.blocksize*1.5, -self.blocksize*0.5,
										    self.blocksize*1.5, self.blocksize*0.5,
											self.blocksize*0.5, self.blocksize*0.5)
		self.fixture = lp.newFixture(self.body, self.shape)
		self.fixture:setCategory(1)
		self.fixture2 = lp.newFixture(self.body,self.shape2)
		self.fixture:setCategory(1)
		self.tetrisList = self.tetrisList + 1		
	
end


	
end

local Twins = oo.class(Paddle)

function Twins:init(scene, input, x, y)
	Paddle.init(self, scene, input, x, y)
	self.radius = 20
	self.bodyA = lp.newBody(scene.world, x, y-self.radius, "dynamic")
    self.bodyB = lp.newBody(scene.world, x, y+self.radius, "dynamic")
	self.bodyA:setFixedRotation(true)
    self.bodyB:setFixedRotation(true)
	self.shapeA = lp.newCircleShape(self.radius)
    self.shapeB = lp.newCircleShape(self.radius)
	self.fixtureA = lp.newFixture(self.bodyA, self.shapeA)
    self.fixtureB = lp.newFixture(self.bodyB, self.shapeB)
	self.fixtureA:setCategory(CAT_PADDLE)
    self.fixtureB:setCategory(CAT_PADDLE)
	self.zapTimer = 0
	self.maxPower = 40
	self.rechargeRate = 0.5
	self.powerLevel = 40
	self.powerLoss = 40
end

function Twins:update(dt)
	local i = self.input
	if self.scene.addlePower then
		local vxA = (i:get("right") - i:get("left")) * 400 
		local vyA = (i:get("down") - i:get("up")) * 400 
		self.bodyA:setLinearVelocity(vxA, vyA)
		local vxB = (i:get("rotr") - i:get("rotl")) * 400 
		local vyB = (i:get("rotd") - i:get("rotu")) * 400 
		self.bodyB:setLinearVelocity(vxB, vyB)
		
		if self.zapTimer > 0 then
			self.zapTimer = self.zapTimer - dt
			if self.zapTimer <= 0 then
				--signal.remove("begin_contact", self.zapCallback)
				self.zapBody:destroy()
			end
		else
			self:usePowerWithoutEnd(dt)
		end
	else
		local vyA = (i:get("down") - i:get("up")) * 400 
		local vyB = (i:get("rotd") - i:get("rotu")) * 400 
		self.bodyA:setLinearVelocity(0, vyA)
		self.bodyB:setLinearVelocity(0, vyB)
	end
end

function Twins:useSuper()
	local ax,ay = self.bodyA:getPosition()
	local bx,by = self.bodyB:getPosition()
	local dx,dy = bx-ax, by-ay
	local midx,midy = (ax+bx)*0.5, (ay+by)*0.5
	local dist = math.sqrt(dx*dx + dy*dy)
	local angle = math.atan2(dy, dx)
	local body = lp.newBody(self.scene.world, midx, midy)
	local shape = lp.newRectangleShape(dist, 30)
	local fixture = lp.newFixture(body, shape)
	body:setAngle(angle)
	--fixture:setSensor(true)
	fixture:setRestitution(5.0)
	self.zapCallback = (function()
		local other = collide(fixture)
		if other and hasCategory(other, CAT_BALL) then
			local ballBody = other:getBody()
			local vx, vy = ballBody:getLinearVelocity()
			if self == player1 then
				vx = 600
			else
				vx = -600
			end
			ballBody:setLinearVelocity(vx, vy)
		end
	end)
	--signal.register("begin_contact", self.zapCallback)
	self.zapBody = body
	self.zapTimer = 0.4
end

function Twins:draw()
	
	love.graphics.setColor(255,215,0,255)
	love.graphics.circle("fill", self.bodyA:getX(), self.bodyA:getY(), self.radius)
	love.graphics.setColor(255,165,0,255)
	love.graphics.circle("line", self.bodyA:getX(), self.bodyA:getY(), self.radius+1)
	love.graphics.circle("fill", self.bodyB:getX(), self.bodyB:getY(), self.radius)
	love.graphics.setColor(255,215,0,255)
	love.graphics.circle("line", self.bodyB:getX(), self.bodyB:getY(), self.radius+1)	
end

local P_Addle = oo.class(Paddle)

function P_Addle:init(scene, input, x, y)
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
	self.maxPower = 40
	self.rechargeRate = 5
	self.powerLevel = 40
	self.powerLoss = 10
end

function P_Addle:update(dt)
	local i = self.input
	local vx = (i:get("right") - i:get("left")) * 400 
	local vy = (i:get("down") - i:get("up")) * 400 
	local w = (i:get("rotr") - i:get("rotl")) * 5 
	self.body:setLinearVelocity(vx, vy)
	self.body:setAngularVelocity(w)
	self:usePowerWithEnd(dt)
	
	if self.input:released("special") then
		self.scene.addlePower = true
	end
	
end

function P_Addle:useSuper()

	self.scene.addlePower = false
	
end

function P_Addle:endSuper()
	
	self.scene.addlePower = true

end

return {
	BobLong = BobLong,
	Sophia = Sophia,
	DrStoptagon = DrStoptagon,
	SeriousSum = SeriousSum,
    Tetromino = Tetromino,
    Twins = Twins,
    P_Addle = P_Addle
}
