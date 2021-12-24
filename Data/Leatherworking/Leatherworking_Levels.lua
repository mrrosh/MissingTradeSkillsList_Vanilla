---------------------------
-- Levels Leatherworking --
---------------------------
MTSLDATA["Leatherworking"]["levels"] = {
	{
		id = 2108,
		name = "Apprentice Leatherworking",
		min_skill = 1,
		max_skill = 75,
		trainers = {
			price = 50,
			sources = {  223, 1466, 1632, 3008, 3069, 3549, 3605, 5784, 5811, 7866, 7867, 7868, 7869, 7870, 11083, 11096 },
		},
	},
	{
		id = 3104,
		name = "Journeyman Leatherworking",
		min_skill = 50,
		max_skill = 150,
		trainers = {
			price = 500,
			sources = {  1385, 3365, 3703, 3967, 4588, 5127, 5564, 7866, 7867, 7868, 7869, 7870, 8153, 11081, 11084 },
		},
	},
	{
		id = 3811,
		name = "Expert Leatherworking",
		min_skill = 125,
		max_skill = 225,
		trainers = {
			price = 5000,
			sources = {  3007, 4212, 7870 },
		},
	},
	{
		id = 10662,
		name = "Artisan Leatherworking",
		min_skill = 200,
		max_skill = 300,
		min_xp_level = 35,
		trainers = {
			price = 50000,
			sources = {  7870, 11097, 11098 },
		},
	},
}
