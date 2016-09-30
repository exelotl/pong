
local BobLong = oo.class()

function BobLong:init(scene, input, x, y)
	self.scene = scene
	self.input = input
	self.body = lp.newBody(scene.world, x, y, "dynamic")
	self.shape = lp.newRectangleShape(40, 100)
	self.fixture = lp.newFixture(self.body, self.shape)
end

function BobLong:update(dt)
	local vx, vy, w = 0, 0
	if self.input:down("up") then
		vy = -400
	elseif self.input:down("down") then
		vy = 400
	else
		vy = 0
	end
	if self.input:down("rotl") then
		w = -5
	elseif self.input:down("rotr") then
		w = 5
	else
		w = 0
	end
	self.body:setLinearVelocity(vx, vy)
	self.body:setAngularVelocity(w)
end

function BobLong:draw()
	
end

return {
	BobLong = BobLong
}
