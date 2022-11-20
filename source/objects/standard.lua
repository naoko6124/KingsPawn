love.graphics.setDefaultFilter("nearest")

local standard = {}

local up = 0 - 43
local up_left = 0 - 22
local up_right = 0 - 21
local left = 0 - 1
local right = 0 + 1
local down_left = 0 + 21
local down_right = 0 + 22
local down = 0 + 43

standard["dragon"] = {
		sprite = function ()
			t = {}
			t[0] = love.graphics.newImage("sprites/units/blue/spr_dragon.png")
			t[1] = love.graphics.newImage("sprites/units/green/spr_dragon.png")
			t[2] = love.graphics.newImage("sprites/units/orange/spr_dragon.png")
			t[3] = love.graphics.newImage("sprites/units/pink/spr_dragon.png")
			return t
		end,
		can_move = function (pos)
			return {
				pos + up, pos + up * 2,
				pos + up_left, pos + up_left * 2,
				pos + up_right, pos + up_right * 2,
				pos + down_left, pos + down_left * 2,
				pos + down_right, pos + down_right * 2,
				pos + down, pos + down * 2,
			}
		end,
		can_move_tiles = function ()
			return {
				"plains",
				"ocean_bridge",
				"plains_castle",
				"plains_florest",
				"plains_village",
				"desert_oasis",
				"mountain",
				"mountain_cloud",
				"mountain_castle"
			}
		end,
		can_kill = function(pos)
			return {
				pos + up, pos + up * 2,
				pos + up_left, pos + up_left * 2,
				pos + up_right, pos + up_right * 2,
				pos + down_left, pos + down_left * 2,
				pos + down_right, pos + down_right * 2,
				pos + down, pos + down * 2,
			}
		end
	}

standard["archer"] = {
		sprite = function ()
			t = {}
			t[0] = love.graphics.newImage("sprites/units/blue/spr_archer.png")
			t[1] = love.graphics.newImage("sprites/units/green/spr_archer.png")
			t[2] = love.graphics.newImage("sprites/units/orange/spr_archer.png")
			t[3] = love.graphics.newImage("sprites/units/pink/spr_archer.png")
			return t
		end,
		can_move = function (pos)
			return {
				pos + up,
				pos + up_left,
				pos + up_right,
				pos + down_left,
				pos + down_right,
				pos + down,
			}
		end,
		can_move_tiles = function ()
			return {
				"plains",
				"ocean_bridge",
				"plains_castle",
				"plains_florest",
				"plains_village",
				"desert_oasis",
			}
		end,
		can_kill = function(pos)
			return {
				pos + up * 4,
				pos + up_left * 3 + up,
				pos + up_right * 3 + up,
				pos + down_left * 3 + down,
				pos + down_right * 3 + down,
				pos + down * 4,
			}
		end
	}

standard["halberd"] = {
		sprite = function ()
			t = {}
			t[0] = love.graphics.newImage("sprites/units/blue/spr_halberd.png")
			t[1] = love.graphics.newImage("sprites/units/green/spr_halberd.png")
			t[2] = love.graphics.newImage("sprites/units/orange/spr_halberd.png")
			t[3] = love.graphics.newImage("sprites/units/pink/spr_halberd.png")
			return t
		end,
		can_move = function (pos)
			return {
				pos + up,
				pos + up_right,
				pos + up_left,
				pos + down,
				pos + down_right,
				pos + down_left,
			}
		end,
		can_move_tiles = function ()
			return {
				"plains",
				"ocean_bridge",
				"plains_castle",
				"plains_village",
				"desert_oasis",
			}
		end,
		can_kill = function(pos)
			return {
				pos + up,
				pos + up_right,
				pos + up_left,
				pos + down,
				pos + down_right,
				pos + down_left,
				pos + up * 2,
				pos + up_right * 2,
				pos + up_left * 2,
				pos + down * 2,
				pos + down_right * 2,
				pos + down_left * 2,
			}
		end
	}

standard["mage"] = {
		sprite = function ()
			t = {}
			t[0] = love.graphics.newImage("sprites/units/blue/spr_mage.png")
			t[1] = love.graphics.newImage("sprites/units/green/spr_mage.png")
			t[2] = love.graphics.newImage("sprites/units/orange/spr_mage.png")
			t[3] = love.graphics.newImage("sprites/units/pink/spr_mage.png")
			return t
		end,
		can_move = function (pos)
			return {
				pos + up,
				pos + up_right,
				pos + up_left,
				pos + down,
				pos + down_right,
				pos + down_left,
			}
		end,
		can_move_tiles = function ()
			return {
				"plains",
				"ocean_bridge",
				"plains_castle",
				"plains_village",
				"desert_oasis",
			}
		end,
		can_kill = function(pos)
			return {
				pos + up * 2,
				pos + up * 3,
				pos + up_right + up,
				pos + up_right * 2,
				pos + up_right * 3,
				pos + right,
				pos + down_right * 2,
				pos + down_right * 3,
				pos + down_right + down,
				pos + down * 2,
				pos + down * 3,
				pos + down_left + down,
				pos + down_left * 2,
				pos + down_left * 3,
				pos + left,
				pos + up_left * 2,
				pos + up_left * 3,
				pos + up_left + up,
			}
		end
	}

standard["wizard"] = {
		sprite = function ()
			t = {}
			t[0] = love.graphics.newImage("sprites/units/blue/spr_wizard.png")
			t[1] = love.graphics.newImage("sprites/units/green/spr_wizard.png")
			t[2] = love.graphics.newImage("sprites/units/orange/spr_wizard.png")
			t[3] = love.graphics.newImage("sprites/units/pink/spr_wizard.png")
			return t
		end,
		can_move = function (pos)
			return {
				pos + up,
				pos + up_right,
				pos + up_left,
				pos + down,
				pos + down_right,
				pos + down_left,
			}
		end,
		can_move_tiles = function ()
			return {
				"plains",
				"ocean_bridge",
				"plains_castle",
				"plains_village",
				"desert_oasis",
			}
		end,
		can_kill = function(pos)
			return {
				pos + up + up_right,
				pos + up + up_right + up_right,
				pos + up + up_right + up,
				pos + right,
				pos + right + up_right,
				pos + right + down_right,
				pos + down + down_right,
				pos + down + down_right + down_right,
				pos + down + down_right + down,
				pos + up + up_left,
				pos + up + up_left + up_left,
				pos + up + up_left + up,
				pos + left,
				pos + left + up_left,
				pos + left + down_left,
				pos + down + down_left,
				pos + down + down_left + down_left,
				pos + down + down_left + down,

			}
		end
	}

standard["tower"] = {
		sprite = function ()
			t = {}
			t[0] = love.graphics.newImage("sprites/units/blue/spr_tower.png")
			t[1] = love.graphics.newImage("sprites/units/green/spr_tower.png")
			t[2] = love.graphics.newImage("sprites/units/orange/spr_tower.png")
			t[3] = love.graphics.newImage("sprites/units/pink/spr_tower.png")
			return t
		end,
		can_move = function (pos)
			return {}
		end,
		can_move_tiles = function ()
			return {
				"plains",
				"ocean_bridge",
				"plains_castle",
				"plains_village",
				"desert_oasis",
			}
		end,
		can_kill = function(pos)
			return {
				pos + up,
				pos + up_right,
				pos + up_left,
				pos + down,
				pos + down_right,
				pos + down_left,
				pos + up * 2,
				pos + up_right * 2,
				pos + up_left * 2,
				pos + up + up_right,
				pos + up + up_left,
				pos + left,
				pos + right,
				pos + down + down_right,
				pos + down + down_left,
				pos + down * 3,
				pos + down_right * 3,
				pos + down_left * 3,
				pos + up * 3,
				pos + up_right * 3,
				pos + up_left * 3,
				pos + down * 3,
				pos + down_right * 3,
				pos + down_left * 3,
				pos + up + up_right + up,
				pos + up + up_right + up_right,
				pos + up + up_left + up,
				pos + up + up_left + up_left,
				pos + left + up_left,
				pos + left + down_left,
				pos + right + up_right,
				pos + right + down_right,
				pos + down + down_right + down,
				pos + down + down_right + down_right,
				pos + down + down_left + down,
				pos + down + down_left + down_left,
			}
		end
	}

standard["pawn"] = {
		sprite = function ()
			t = {}
			t[0] = love.graphics.newImage("sprites/units/blue/spr_pawn.png")
			t[1] = love.graphics.newImage("sprites/units/green/spr_pawn.png")
			t[2] = love.graphics.newImage("sprites/units/orange/spr_pawn.png")
			t[3] = love.graphics.newImage("sprites/units/pink/spr_pawn.png")
			return t
		end,
		can_move = function (pos)
			return {
				pos + up,
				pos + up_right,
				pos + up_left,
				pos + down,
				pos + down_right,
				pos + down_left,
			}
		end,
		can_move_tiles = function ()
			return {
				"plains",
				"ocean_bridge",
				"plains_castle",
				"plains_florest",
				"plains_village",
				"desert_oasis",
			}
		end,
		can_kill = function(pos)
			return {
				pos + up,
				pos + up_right,
				pos + up_left,
				pos + down,
				pos + down_right,
				pos + down_left
			}
		end
	}

standard["emperor"] = {
		sprite = function ()
			t = {}
			t[0] = love.graphics.newImage("sprites/units/blue/spr_emperor.png")
			t[1] = love.graphics.newImage("sprites/units/green/spr_emperor.png")
			t[2] = love.graphics.newImage("sprites/units/orange/spr_emperor.png")
			t[3] = love.graphics.newImage("sprites/units/pink/spr_emperor.png")
			return t
		end,
		can_move = function (pos)
			return {
				pos + up,
				pos + up_right,
				pos + up_left,
				pos + down,
				pos + down_right,
				pos + down_left,
			}
		end,
		can_move_tiles = function ()
			return {
				"plains",
				"ocean_bridge",
				"plains_castle",
				"plains_village",
			}
		end,
		can_kill = function(pos)
			return {}
		end
	}

return standard