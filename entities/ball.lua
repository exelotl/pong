local Ball = oo.class()

function Ball:init(scene, x, y)
	self.scene = scene
	self.ox = x
	self.oy = y
	self.body = lp.newBody(scene.world, x, y, "dynamic")
	self.shape = lp.newCircleShape(10)
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
		print("collision!")
		if other and hasCategory(other, CAT_GOAL) then
			print("collision between ball and goal")
			self.scene:score(self, other:getUserData())
		end
	end)
end

function Ball:update(dt)
	local x,y = self.body:getPosition()
	local vx,vy = self.body:getLinearVelocity()
	
	--print(vx, vy)
	--vx = math.max(math.min(vx, 20*dt), -20*dt)
	--self.body:setLinearVelocity(vx, vy)
	
	--signal.emit("")
end

function Ball:draw()
	
end

return Ball 