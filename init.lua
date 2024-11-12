stripped_tree = {}
stripped_tree.S = core.get_translator("stripped_tree")

local path = core.get_modpath("stripped_tree")

dofile(path .. "/api.lua")
dofile(path .. "/chisel.lua")
dofile(path .. "/tree_bark.lua")

-- Support for other mods
dofile(path .. "/support_default.lua")

if core.get_modpath("ethereal") then
	dofile(path .. "/support_ethereal.lua")
end

if core.get_modpath("moretrees") then
	dofile(path .. "/support_moretrees.lua")
end
