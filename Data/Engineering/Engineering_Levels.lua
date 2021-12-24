------------------------
-- Levels Engineering --
------------------------
MTSLDATA["Engineering"]["levels"] = {
	{
		id = 4036,
		name = "Apprentice Engineering",
		min_skill = 1,
		max_skill = 75,
		trainers = {
			price = 50,
			sources = {  1702, 2857, 3290, 3412, 3494, 4586, 5174, 5518, 8736, 10993, 11017, 11025, 11026, 11028, 11029, 11031, 11037 },
		},
	},
	{
		id = 4037,
		name = "Journeyman Engineering",
		min_skill = 50,
		max_skill = 150,
		trainers = {
			price = 500,
			sources = {  3412, 5174, 5518, 8736, 11017, 11029, 11031 },
		},
	},
	{
		id = 4038,
		name = "Expert Engineering",
		min_skill = 125,
		max_skill = 225,
		trainers = {
			price = 5000,
			sources = {  5174, 8736, 11017 },
		},
	},
	{
		id = 12656,
		name = "Artisan Engineering",
		min_skill = 200,
		max_skill = 300,
		min_xp_level = 35,
		trainers = {
			price = 50000,
			sources = {  8736 },
		},
	},
}
