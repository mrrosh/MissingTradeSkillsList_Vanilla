-----------------------
-- Levels Enchanting --
-----------------------
MTSLDATA["Enchanting"]["levels"] = {
	{
		id = 7411,
		name = "Apprentice Enchanting",
		min_skill = 1,
		max_skill = 75,
		trainers = {
			price = 50,
			sources = {  1317, 3011, 3345, 3606, 4616, 5157, 5695, 7949, 11065, 11066, 11067, 11068, 11070, 11071, 11072, 11073, 11074 },
		},
	},
	{
		id = 7412,
		name = "Journeyman Enchanting",
		min_skill = 50,
		max_skill = 150,
		trainers = {
			price = 500,
			sources = {  1317, 3011, 3345, 4213, 4616, 5157, 7949, 11072, 11073, 11074 },
		},
	},
	{
		id = 7413,
		name = "Expert Enchanting",
		min_skill = 125,
		max_skill = 225,
		trainers = {
			price = 5000,
			sources = {  11072, 11073, 11074 },
		},
	},
	{
		id = 13920,
		name = "Artisan Enchanting",
		min_skill = 200,
		max_skill = 300,
		min_xp_level = 35,
		trainers = {
			price = 50000,
			sources = {  11073 },
		},
	},
}
