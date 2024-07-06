local S = stripped_tree.S

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

		if stripped_tree.debarked_nodes[old_node.name] then
			minetest.swap_node(pos, {name = stripped_tree.debarked_nodes[old_node.name], param2 = old_node.param2})

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

-- Crafting
minetest.register_craft({
	output = "stripped_tree:chisel",
	recipe = {
		{"", "default:steel_ingot", "" },
		{"", "screwdriver:screwdriver", ""}
	}
})
