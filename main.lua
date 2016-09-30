-- global imports
oo = require "oo"
flux = require "flux"
Anim = require "anim"
EntityList = require "entitylist"
signal = require "signal"

-- misc imports
local limitFrameRate = require "limitframerate"
local PlayScene = require "scenes.playscene"
local baton = require "baton"

local scene = {}

function setScene(newScene)
	if scene.leave then scene:leave(newScene) end
	if newScene.enter then newScene:enter(scene) end
	scene = newScene
end

function love.load()
	lf = love.filesystem
	ls = love.sound
	la = love.audio
	lp = love.physics
	lt = love.thread
	li = love.image
	lg = love.graphics
	lm = love.mouse
	lj = love.joystick
	lw = love.window
	
	local controls = {
		left = {'axis:leftx-', 'button:dpleft'},
		right = {'axis:leftx+', 'button:dpright'},
		up = {'axis:lefty-', 'button:dpup'},
		down = {'axis:lefty+', 'button:dpdown'},
		rotl = {'axis:rightx-'},
		rotr = {'axis:rightx+'},
		special = {'button:a'}
	}
	
	p1input = baton.newPlayer(controls, lj.getJoysticks()[1])
	p2input = baton.newPlayer(controls, lj.getJoysticks()[2])
	
	setScene(PlayScene.new())
end

function love.update(dt)
	flux.update(dt)
	p1input:update()
	p2input:update()
	signal.emit("update", scene, dt)
end

function love.draw()
	signal.emit("draw", scene)
end

function love.keypressed(key, scancode, isrepeat)
	signal.emit("keypressed", scene, key, scancode, isrepeat)
end

function love.keyreleased(key, scancode)
	signal.emit("keyreleased", scene, key, scancode)
end

