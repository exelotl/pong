local Ball = oo.class()

function Ball:init(scene, x, y)
	self.scene = scene
	self.ox = x
	self.oy = y
	self.body = lp.newBody(scene.world, x, y, "dynamic")
	self.radius = 10
	self.shape = lp.newCircleShape(self.radius)
	self.fixture = lp.newFixture(self.body, self.shape)
	self.fixture:setRestitution(1.0)
	self.fixture:setCategory(CAT_BALL)
	self.fixture:setUserData(self)
  
	randresult = math.random(6)
	local vx,vy = unpack(({
		{225, 0},
		{-255, 0},
		{-150, 150},
		{-150, -150},
		{150, 150},
		{150, -150}
	})[math.random(6)])
	
	self.body:setLinearVelocity(vx, vy)
	
	signal.register("begin_contact", function()
		local other = collide(self.fixture)
		if other and hasCategory(other, CAT_GOAL) then
			self.scene:score(self, other:getUserData())
		end
	end)
end

function Ball:update(dt)
	local x,y = self.body:getPosition()
	local vx,vy = self.body:getLinearVelocity()
	
end

function Ball:draw()
	love.graphics.setColor(255,0,0,255)
	love.graphics.circle("fill", self.body:getX(), self.body:getY(), self.radius)
	love.graphics.setColor(255,192,203,255)
	love.graphics.circle("line", self.body:getX(), self.body:getY(), self.radius+1)
end

return Ball 