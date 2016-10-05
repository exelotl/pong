local paddles = require "entities.paddles"

local charimages = {
	{
		image = love.graphics.newImage("images/BobLong.png"),
		class = paddles.BobLong,
	},
	{
		image = love.graphics.newImage("images/DrStoptogon.png"),
		class = paddles.DrStoptagon,
	},
	{
		image = love.graphics.newImage("images/PAddle.png"),
		class = paddles.P_Addle
	},
	{
		image = love.graphics.newImage("images/SeriousSum.png"),
		class = paddles.SeriousSum
	},
	{
		image = love.graphics.newImage("images/Sophia.png"),
		class = paddles.Sophia,
	},
	{
		image = love.graphics.newImage("images/TetrisSquiggle.png"),
		class = paddles.Tetromino
	},
	{
		image = love.graphics.newImage("images/Twins.png"),
		class = paddles.Twins
	}
}

return charimages