local Wall = oo.class()

function Wall:init(scene, x, y, w, h)
	self.body = lp.newBody(scene.world, x, y, "static")
	self.width = w
	self.height = h
	self.shape = lp.newRectangleShape(self.width, self.height)
	self.fixture = lp.newFixture(self.body, self.shape)
	self.fixture:setCategory(CAT_WALL)
end

function Wall:draw()
	x,y = self.body:getPostion()
	love.graphics.setColor(0,0,255,255)
	love.graphics.rectangle('fill', x,y, w,h)

end

return Wall