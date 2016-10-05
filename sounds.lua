local paddles = require "entities.paddles"

local function loadSound(str)
	local source = la.newSource("sfx/"..str, "static")
	return source
end

local sounds = {
	go = loadSound "go.wav",
	p1win = loadSound "p1_win.wav",
	p2win = loadSound "p2_win.wav",
	[paddles.BobLong] = {
		intro = loadSound "bl_1.wav",
		power = loadSound "bl_2.wav",
		win = loadSound "bl_3.wav"
	},
	[paddles.P_Addle] = {
		intro = loadSound "pa_1.wav",
		power = loadSound "pa_2.wav",
		win = loadSound "pa_3.wav"
	},
	[paddles.DrStoptagon] = {
		intro = loadSound "ds_1.wav",
		power = loadSound "ds_2.wav",
		win = loadSound "ds_3.wav"
	},
	[paddles.SeriousSum] = {
		intro = loadSound "ss_1.wav",
		power = loadSound "ss_2.wav",
		win = loadSound "ss_3.wav"
	},
	[paddles.Tetromino] = {
		intro = loadSound "t_1.wav",
		power = loadSound "t_2.wav",
		win = loadSound "t_3.wav"
	},
	[paddles.Twins] = {
		intro = loadSound "tw_1.wav",
		power = loadSound "tw_2.wav",
		win = loadSound "tw_3.wav"
	},
	[paddles.Sophia] = {
		intro = loadSound "s_1.wav",
		power = loadSound "s_2.wav",
		win = loadSound "s_3.wav"
	},
}

return sounds