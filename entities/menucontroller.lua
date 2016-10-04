local menucontroller = oo.class()

function menucontroller:init(scene, input, currentChar)
	self.scene = scene
	self.input = input
	self.currentChar = currentChar
  self.pause = 0
end

function menucontroller:update(dt)
  
  if self.pause <= 0 then
   if self.input:get("down") then
      self.currentChar = self.currentChar + 1
      self.pause = 20
      if self.currentChar == #self.charImages then
        self.currentChar = 1
      end
      
    elseif self.input:get("up") then
      self.currentChar = self.currentChar + 1
      self.pause = 20
      if self.currentChar == 1 then
        self.currentChar = #self.charImages
      end
      
    end
  end
  
  self.pause = self.pause - 1
  
end

function menucontroller:getCurrentChar()
  return self.currentChar
end

return menucontroller
