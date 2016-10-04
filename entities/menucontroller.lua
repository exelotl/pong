local menucontroller = oo.class()

function menucontroller:init(scene, input, currentChar, maxChar)
	self.scene = scene
	self.input = input
	self.currentChar = currentChar
	self.maxChar = maxChar
	self.selectedBool = false
	self.changeScene = false
  self.pause = 0
end

function menucontroller:checkagree()
	if self.input:get("special") then
		self.scene:changeScene()
	end
end

function menucontroller:checkselect()

	if self.input:pressed("cancel") then
		self.selectedBool = false
	
	elseif self.input:pressed("special") then
		self.selectedBool = true

	end

	return self.selectedBool

	
end

function menucontroller:update(dt)
	
	if self.input:released('down') or self.input:released('up') then
		self.pause = 0
	end
  
  if self.pause <= 0 then
   if self.input:down("down") then
      self.currentChar = self.currentChar - 1
      self.pause = 20
      if self.currentChar == 0 then
        self.currentChar = self.maxChar
      end
      
    elseif self.input:down("up") then
      self.currentChar = self.currentChar + 1
      self.pause = 20
      if self.currentChar == self.maxChar + 1 then
        self.currentChar = 1
      end
      
    end
  end
  
  self.pause = self.pause - 1
  
end

function menucontroller:getCurrentChar()
  return self.currentChar
end

return menucontroller
