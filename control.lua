require("mod-gui")
local mod_gui = _G.mod_gui

--local fonts = require("fonts")

-- I can't be bothered to add more fonts.
local font = require("default-font")

-- local allowedEntityNames = {
-- 	["heat-pipe"] = true,
-- 	["pipe"] = true,
-- 	["steel-chest"] = true,
-- }
-- local allowedEntityTypes = {
-- 	["transport-belt"] = true,
-- 	["wall"] = true,
-- }
-- local allowedRandomCategory = {
-- 	["inserter"] = true,
-- }

local CONCRETE = "concrete"
local STONE = "stone-path"

local function trim(s)
	local from = s:match"^%s*()"
	return from > #s and "" or s:match(".*%S", from)
end

local function sanitizeInput(player, text)
	if type(text) ~= "string" then return false end
	-- This is only done once per font
	if not font.supportedCharacters then
		-- Find all supported characters in the current font.
		-- Assume all uppercase alphanumeric are supported, and space.
		local support = "%d?%u?%s?"
		local fmt = "%s%%%s?"
		for k, v in pairs(font.characters) do
			if type(v) == "string" then
				local x = k
				-- Support ["."] = "!" replacement entries in font data.
				if v:len() == 1 then x = v end
				local ret = x:match(support)
				if not ret or ret:len() == 0 then support = fmt:format(support, x) end
			end
		end
		font.supportedCharacters = "[^".. support:gsub("%?", "") .. "]"
	end
	if type(font.supportedCharacters) == "function" then
		text = font:supportedCharacters(player, text)
	else
		text = trim(text)
		text = text:upper()
		-- Strip all non-supported characters
		text = text:gsub(font.supportedCharacters, "")
		-- Seems input fields in factorio removes newlines automatically? Still need to nuke tabs.
		text = text:gsub("\t", " ")
	end
	for l = 1, #text do
		if type(font.characters[text:sub(l, l)]) == "nil" then return false, text end
	end
	return true, text
end

local cc = {}
do
	-- It actually seems like factorio does a GC almost every tick.
	-- So we dont mark the table weak, because that churns them like crazy.
	local cache = {}
	setmetatable(cc, {
		__call = function(_, name, x, y)
			if name then
				local pos = next(cache)
				if pos then cache[pos] = nil
				else pos = {} end
				pos[1] = x
				pos[2] = y
				local obj = next(cache)
				if obj then cache[obj] = nil
				else obj = {} end
				obj.name = name
				obj.position = pos
				return obj
			else
				local r = next(cache)
				if r then cache[r] = nil
				else r = {} end
				return r
			end
		end,
	})
	local function wipe(t) for i in pairs(t) do t[i] = nil end; t.reset = 1; t.reset = nil; return t end
	cc.wipe = function(data)
		for _, item in next, data do
			cache[wipe(item.position)] = true
			cache[wipe(item)] = true
		end
		cache[wipe(data)] = true
	end
end

local tinsert = table.insert
local defaultMap = {
	["1"] = CONCRETE,
	["0"] = STONE,
	f = CONCRETE,
}
local function autoblueprintifytext(player, text)
	if type(text) ~= "string" then return end
	local map
	if global[player.index] then
		map = {}
		if global[player.index].blueprintify_lettering then map["1"] = global[player.index].blueprintify_lettering else map["1"] = CONCRETE end
		if global[player.index].blueprintify_background then map["0"] = global[player.index].blueprintify_background else map["0"] = STONE end
		if global[player.index].blueprintify_framing then map.f = global[player.index].blueprintify_framing else map.f = CONCRETE end
	else
		map = defaultMap
	end

	local height = font.height
	local width = font.width

	local blueprint = cc()
	local max = (width * #text) + 1
	for i = 0, (height+1) do
		tinsert(blueprint, cc(map.f, 0, i))
		tinsert(blueprint, cc(map.f, max, i))
	end

	local xStep = 0
	for l = 1, #text do
		local letter = font.characters[text:sub(l, l)]
		local tileOverride = nil
		if not letter or type(letter) ~= "string" then tileOverride = STONE end

		local yStep = 1
		for rX = 1, width do
			tinsert(blueprint, cc(map.f, (xStep+rX),0))
			tinsert(blueprint, cc(map.f, (xStep+rX),(height+1)))
			local counter = 1
			for rY = yStep, (yStep + height) - 1 do
				local tile = tileOverride or map[letter:sub(rY, rY)]
				tinsert(blueprint, cc(tile, xStep+rX, counter))
				counter = counter + 1
			end
			yStep = yStep + height
		end
		xStep = xStep + width
	end

	if player.cursor_stack and player.cursor_stack.valid_for_read and player.cursor_stack.name == "blueprint" then
		player.cursor_stack.clear_blueprint()
		player.cursor_stack.set_blueprint_tiles(blueprint)
	end

	cc.wipe(blueprint)
end

do
	-- Create the button for every player
	local function initGui(player)
		if not player.force.technologies["construction-robotics"].researched then return end
		if not player.force.technologies.concrete.researched then return end

		local buttons = mod_gui.get_button_flow(player)
		if not buttons.blueprintify_button then
			buttons.add({
				type = "sprite-button",
				name = "blueprintify_button",
				sprite = "recipe/blueprintify",
				style = mod_gui.button_style,
				tooltip = {"autoblueprintify.button-doit"}
			})
		end

		local frames = mod_gui.get_frame_flow(player)
		local frame = frames.blueprintify_frame
		if not frame then
			frame = frames.add ({
				type = "frame",
				name = "blueprintify_frame",
				direction = "vertical",
				caption = {"autoblueprintify.frame-caption"},
				style = mod_gui.frame_style
			})
		end
		if not frame.one then
			frame.add({
				type = "flow",
				name = "one",
				direction = "horizontal"
			})
		end
		if not frame.one.blueprintify_text then
			frame.one.add({
				type = "textfield",
				name = "blueprintify_text",
				style = "textfield"
			})
		end
		if not frame.one.blueprintify_doit then
			frame.one.add({
				type = "sprite-button",
				name = "blueprintify_doit",
				sprite = "recipe/blueprintify",
				style = mod_gui.button_style,
				tooltip = {"autoblueprintify.button-doit"}
			})
		end

		if not frame.two then
			frame.add({
				type = "flow",
				name = "two",
				direction = "horizontal"
			})
		end
		if not frame.two.blueprintify_lettering then
			frame.two.add({
				type = "sprite-button",
				name = "blueprintify_lettering",
				sprite = "item/concrete",
				style = mod_gui.button_style,
				tooltip = {"autoblueprintify.button-letter"}
			})
		end
		if not frame.two.blueprintify_background then
			frame.two.add({
				type = "sprite-button",
				name = "blueprintify_background",
				sprite = "item/stone-brick",
				style = mod_gui.button_style,
				tooltip = {"autoblueprintify.button-background"}
			})
		end
		if not frame.two.blueprintify_framing then
			frame.two.add({
				type = "sprite-button",
				name = "blueprintify_framing",
				sprite = "item/hazard-concrete",
				style = mod_gui.button_style,
				tooltip = {"autoblueprintify.button-frame"}
			})
		end

		--frame.one.style.resize_to_row_height = true
		--frame.two.style.resize_to_row_height = true

		frame.style.visible = false
	end
	script.on_event(defines.events.on_player_created, function(event)
		initGui(game.players[event.player_index])
	end)
	script.on_event(defines.events.on_research_finished, function(event)
		if not event or not event.research then return end
		if (event.research.name == "concrete" or event.research.name == "construction-robotics") then
			if event.research.force.technologies["construction-robotics"].researched and event.research.force.technologies.concrete.researched then
				for _, player in pairs(event.research.force.players) do
					initGui(player)
				end
			end
		end
	end)
	script.on_configuration_changed(function()
		for _, p in pairs(game.players) do
			if p.valid then initGui(p) end
		end
	end)
end

do
	local handle = {}
	handle["blueprintify_button"] = function(p)
		local frame = mod_gui.get_frame_flow(p).blueprintify_frame
		if not frame then return end
		frame.style.visible = not frame.style.visible
	end
	handle["blueprintify_doit"] = function(p)
		local frame = mod_gui.get_frame_flow(p).blueprintify_frame
		if not frame then return end
		local input = frame.one.blueprintify_text.text
		if type(input) ~= "string" or input:len() == 0 then return end

		local valid, sanitized = sanitizeInput(p, input)
		frame.one.blueprintify_text.text = sanitized

		if not valid then
			p.print({"autoblueprintify.invalid-input"})
			return
		end

		if p.cursor_stack and p.cursor_stack.valid_for_read and p.cursor_stack.name == "blueprint" then
			frame.style.visible = false
			autoblueprintifytext(p, sanitized)
			frame.one.blueprintify_text.text = ""
		else
			p.print({"autoblueprintify.need-blueprint"})
		end
	end

	do
		local function setTileType(object, p, e)
			if p.cursor_stack and p.cursor_stack.valid_for_read then
				local tile = p.cursor_stack.prototype.place_as_tile_result
				if tile and tile.result and tile.result.name then
					if not global[p.index] then global[p.index] = {} end
					global[p.index][object] = tile.result.name
					e.sprite = "item/" .. p.cursor_stack.name
					p.print({"autoblueprintify.changed-tile", {"tile-name." .. tile.result.name}})
					return true
				end
			end
			p.print({"autoblueprintify.need-tile"})
		end
		handle["blueprintify_lettering"] = function(player, elem) setTileType("blueprintify_lettering", player, elem) end
		handle["blueprintify_background"] = function(player, elem) setTileType("blueprintify_background", player, elem) end
		handle["blueprintify_framing"] = function(player, elem) setTileType("blueprintify_framing", player, elem) end
	end

	script.on_event(defines.events.on_gui_click, function(event)
		if handle[event.element.name] then handle[event.element.name](game.players[event.player_index], event.element) end
	end)
end


	-- you can use this code to spit out blueprints you design
		-- local p = game.players[index]
		-- if p.cursor_stack and p.cursor_stack.valid_for_read and p.cursor_stack.name == "blueprint" then
		-- 	local tiles = p.cursor_stack.get_blueprint_tiles()
		-- 	local fmt = "{name=%s,position={x=%d,y=%d}},"
		-- 	local data = "[\"" .. p.cursor_stack.label:upper() .. "\"]={"
		-- 	for i, tile in next, tiles do
		-- 		local name = "c"
		-- 		if tile.name ~= "concrete" then name = "s" end
		-- 		data = data .. fmt:format(name, tile.position.x, tile.position.y)
		-- 	end
		-- 	data = data .. "}"
		-- 	game.write_file(p.cursor_stack.label, data)
		-- 	p.cursor_stack.clear_blueprint()
		-- end
