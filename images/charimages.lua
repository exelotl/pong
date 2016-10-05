local paddles = require "entities.paddles"

local charimages = {
	{
		image = love.graphics.newImage("images/BobLong.png"),
		class = paddles.BobLong,
        bio = "Just a pong paddle, kind of surprised, this game isn't Pong."
	},
	{
		image = love.graphics.newImage("images/DrStoptogon.png"),
		class = paddles.DrStoptagon,
        bio = "Tired of his day job as a traffic warden, Dr Stoptagon honed his mind and achieved his PHD in pediatry."
	},
	{
		image = love.graphics.newImage("images/PAddle.png"),
		class = paddles.P_Addle,
        bio = "Veteran of 1972, Ignoring all advice from every doctor we have, he's ready to show he's still got it."
	},
	{
		image = love.graphics.newImage("images/SeriousSum.png"),
		class = paddles.SeriousSum,
        bio = "After years of dealing math, Sum left that life to pursue a career in professional PONG."
	},
	{
		image = love.graphics.newImage("images/Sophia.png"),
		class = paddles.Sophia,
        bio = "We're not sure what's going on but the balls keep taking weird flight paths with psychic Sophia around."
	},
	{
		image = love.graphics.newImage("images/TetrisSquiggle.png"),
		class = paddles.Tetromino,
        bio = "I'm not sure this guy's in the right game."
	},
	{
		image = love.graphics.newImage("images/Twins.png"),
		class = paddles.Twins,
        bio = "Normally we only allow 1 player per team but when the twins were told this they took the power grid for 3 miles aroud, no one seemed to want argue further."
	}
}

return charimages