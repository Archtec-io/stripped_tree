local S = stripped_tree.S

stripped_tree.debarked_nodes = {} -- ["default:tree"] = "default:stripped_tree"

function stripped_tree.register_trunks(mod_name, trunk_names)
	for _, trunk_name in ipairs(trunk_names) do
		local old_name = mod_name .. ":" .. trunk_name
		local old_def = minetest.registered_nodes[old_name]
		local def = table.copy(old_def)

		-- Override params
		def.description = S("Stripped") .. " " .. old_def.description
		def.tiles = {
			"stripped_tree_" .. mod_name .. "_" .. trunk_name .. "_top.png",
			"stripped_tree_" .. mod_name .. "_" .. trunk_name .. "_top.png",
			"stripped_tree_" .. mod_name .. "_" .. trunk_name .. ".png"
		}
		def.groups.not_in_creative_inventory = 1

		minetest.register_node(":" .. mod_name .. ":stripped_" .. trunk_name, def)
		stripped_tree.debarked_nodes[old_name] = mod_name .. ":stripped_" .. trunk_name
	end
end
