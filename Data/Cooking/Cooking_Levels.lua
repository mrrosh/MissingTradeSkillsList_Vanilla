--------------------
-- Levels Cooking --
--------------------
MTSLDATA["Cooking"]["levels"] = {
	{
		id = 2550,
		name = "Apprentice Cooking",
		min_skill = 1,
		max_skill = 75,
		trainers = {
			price = 50,
			sources = {  1355, 1382, 1430, 1699, 3026, 3067, 3087, 3399, 4210, 4552, 5159, 5482, 6286, 8306 },
		},
	},
	{
		id = 3102,
		name = "Journeyman Cooking",
		min_skill = 50,
		max_skill = 150,
		trainers = {
			price = 500,
			sources = {  1355, 1382, 1430, 1699, 3026, 3067, 3087, 3399, 4210, 4552, 5159, 5482, 6286, 8306 },
		},
	},
	{
		id = 3413,
		name = "Expert Cooking",
		min_skill = 125,
		max_skill = 225,
		item = 16072,
	},
	{
		id = 18260,
		name = "Artisan Cooking",
		min_skill = 200,
		max_skill = 300,
		min_xp_level = 35,
		quests = { 6610 },
	},
}
