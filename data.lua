
-- I only use this data entry to set a custom icon on a button. Because I can't be arsed
-- to figure out how the luaguistyle stuff works. Someone fix it for me please!
_G.data:extend({
	{
		type = "recipe",
		name = "blueprintify",
		icon = "__folk-textprint__/tt.png",
		enabled = false,
		energy_required = 300,
		ingredients = {
			{"coal", 1},
		},
		result = "iron-plate"
	}
})

do
	local function validateFont(font)
		local lengths = {}
		local height = font.height
		local width = font.width
		local f = type(font.supportedCharacters)
		for k, data in pairs(font.characters) do
			if type(k) ~= "string" then error("Character key must be a string.") end
			if k:len() > 1 and f ~= "function" then error("Character entries can only be 1 byte ("..k..", " .. k:len() .. "), or you need to implement a custom supportedCharacters function.") end
			local t = type(data)
			if t ~= "string" and t ~= "boolean" then error("Character data must be a string.") end
			if t == "string" then
				local len = data:len()
				if len ~= (width * height) then error("Character " .. k .. " wont fit inside the given dimensions.") end
				for _, l in next, lengths do
					if l ~= len then error("Mismatched character length: " .. tostring(k)) end
				end
				if data:find("[^01]") then
					error("All character data must be 0s and 1s, denoting stone-path and concrete, respectively.")
				end
				table.insert(lengths, len)
			end
		end
		return true
	end
	local fonts = require("fonts")

	for _, font in next, fonts do
		local f = require(font[1])
		if not validateFont(f) then
			error("Font: " .. font[1] .. " failed validation.")
		end
	end
end
