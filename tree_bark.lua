local S = stripped_tree.S

-- Register Item
minetest.register_craftitem("stripped_tree:tree_bark", {
	description = S("Tree Bark"),
	inventory_image = "stripped_tree_bark.png"
})

minetest.register_alias("default:tree_bark", "stripped_tree:tree_bark")

-- Crafts
minetest.register_craft({
	type = "fuel",
	recipe = "stripped_tree:tree_bark",
	burntime = 15
})

minetest.register_craft({
	output = "default:paper 8",
	recipe = {
		{"stripped_tree:tree_bark", "stripped_tree:tree_bark", "stripped_tree:tree_bark"},
		{"stripped_tree:tree_bark", "bucket:bucket_water", "stripped_tree:tree_bark"},
		{"stripped_tree:tree_bark", "stripped_tree:tree_bark", "stripped_tree:tree_bark"}
	},
	replacements = {
		{"bucket:bucket_water", "bucket:bucket_empty"}
	}
})

if minetest.get_modpath("bonemeal") then
	minetest.register_craft({
		output = "bonemeal:mulch 4",
		recipe = {
			{"stripped_tree:tree_bark", "stripped_tree:tree_bark", "stripped_tree:tree_bark"},
			{"stripped_tree:tree_bark", "stripped_tree:tree_bark", "stripped_tree:tree_bark"}
		}
	})
end
