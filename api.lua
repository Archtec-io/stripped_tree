local S = stripped_tree.S

local debarked_nodes = {} -- ["default:tree"] = "default:stripped_tree"

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
		debarked_nodes[old_name] = mod_name .. ":stripped_" .. trunk_name
	end
end

minetest.register_tool("stripped_tree:chisel", {
	description = S("Chisel for Trunks"),
	inventory_image = "stripped_tree_chisel.png",
	sound = {breaks = "default_tool_breaks"},
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type ~= "node" then
			return
		end

		local pos = pointed_thing.under
		local name = user:get_player_name()
		local old_node = minetest.get_node(pos)

		if minetest.is_protected(pos, name) then
			minetest.record_protection_violation(pos, name)
			return
		end

		if debarked_nodes[old_node.name] then
			minetest.swap_node(pos, {name = debarked_nodes[old_node.name], param2 = old_node.param2})

			if not minetest.is_creative_enabled(user:get_player_name()) then
				itemstack:add_wear_by_uses(200)

				local inv = user:get_inventory()
				if inv:room_for_item("main", "stripped_tree:tree_bark") then
					inv:add_item("main", {name = "stripped_tree:tree_bark"})
				else
					minetest.add_item(pos, "stripped_tree:tree_bark")
				end

				return itemstack
			end
		end
	end
})
