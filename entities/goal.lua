local Goal = oo.class()

function Goal:init(scene, x, y, w, h)
	self.body = lp.newBody(scene.world, x, y, "static")
	self.shape = lp.newRectangleShape(w, h)
	self.fixture = lp.newFixture(self.body, self.shape)
	self.fixture:setCategory(CAT_GOAL)
	self.fixture:setSensor(true)
	self.fixture:setUserData(self)
end

return Goal