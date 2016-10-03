
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
end

function Sophia:update(dt)
	local i = self.input
	local vx = (i:get("right") - i:get("left")) * 400 
	local vy = (i:get("down") - i:get("up")) * 400 
	self.body:setLinearVelocity(vx, vy)
end

function Sophia:draw()
end


return {
	BobLong = BobLong,
	Sophia = Sophia,
}
