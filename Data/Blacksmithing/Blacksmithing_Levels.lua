--------------------------
-- Levels Blacksmithing --
--------------------------
MTSLDATA["Blacksmithing"]["levels"] = {
	{
		id = 2018,
		name = "Apprentice Blacksmithing",
		min_skill = 1,
		max_skill = 75,
		trainers = {
			price = 50,
			sources = {  514, 957, 1241, 1383, 2836, 2998, 3174, 3355, 3557, 4258, 4605, 5511, 6299, 10266, 10276, 10277, 10278 },
		},
	},
	{
		id = 3100,
		name = "Journeyman Blacksmithing",
		min_skill = 50,
		max_skill = 150,
		trainers = {
			price = 500,
			sources = {  1383, 2836, 2998, 3136, 3355, 3478, 4258, 4596, 5511, 10276 },
		},
	},
	{
		id = 3538,
		name = "Expert Blacksmithing",
		min_skill = 125,
		max_skill = 225,
		trainers = {
			price = 5000,
			sources = {  2836, 3355, 4258 },
		},
	},
	{
		id = 9785,
		name = "Artisan Blacksmithing",
		min_skill = 200,
		max_skill = 300,
		min_xp_level = 35,
		trainers = {
			price = 50000,
			sources = {  2836 },
		},
	},
}
