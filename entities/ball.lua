

local ball = oo.class()
math.randomseed(os.time())

function ball:init(scene, x, y)
	  self.scene = scene
	  self.ox = x
	  self.oy = y
	  self.body = lp.newBody(scene.world, x, y, "dynamic")
	  self.shape = lp.newCircleShape(10)
	  self.fixture = lp.newFixture(self.body, self.shape)
    self.fixture:setCategory(3)
  
    randresult = math.random(6)
    if randresult == 1 then
      self.body:setLinearVelocity(225,0)
      
    elseif randresult == 2 then
      self.body:setLinearVelocity(-225,0)
        
    elseif randresult == 3 then
        self.body:setLinearVelocity(-150,150)
    elseif randresult == 4 then
        self.body:setLinearVelocity(-150,-150)
    
    elseif randresult == 5 then
      self.body:setLinearVelocity(150,150)
    
    elseif randresult == 6 then
      self.body:setLinearVelocity(150,-150)
    end
    
end

function ball:update(dt)
  x,y = self.body:getLinearVelocity()
  if 0 <= x and x <= 20*dt then
    self.body:setLinearVelocity(20,y)
  
  elseif -20 <= x and x <= 0 then
    self.body:setLinearVelocity(-20,y)
  end
  
end

return ball 