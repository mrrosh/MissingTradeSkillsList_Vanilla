----------------------
-- Levels First Aid --
----------------------
MTSLDATA["First Aid"]["levels"] = {
	{
		id = 3273,
		name = "Apprentice First Aid",
		min_skill = 1,
		max_skill = 75,
		trainers = {
			price = 50,
			sources = {  2326, 2327, 2329, 2798, 3181, 3373, 4211, 4591, 5150, 5759, 5939, 5943, 6094 },
		},
	},
	{
		id = 3274,
		name = "Journeyman First Aid",
		min_skill = 50,
		max_skill = 150,
		trainers = {
			price = 500,
			sources = {  2326, 2327, 2329, 2798, 3181, 3373, 4211, 4591, 5150, 5759, 5939, 5943, 6094 },
		},
	},
	{
		id = 7924,
		name = "Expert First Aid",
		min_skill = 125,
		max_skill = 225,
		item = 16084,
	},
	{
		id = 10846,
		name = "Artisan First Aid",
		min_skill = 200,
		max_skill = 300,
		min_xp_level = 35,
		quests = { 6622, 6624 },
	},
}
