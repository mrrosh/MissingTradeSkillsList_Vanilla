--------------------
-- Levels Alchemy --
--------------------
MTSLDATA["Alchemy"]["levels"] = {
	{
		id = 2259,
		name = "Apprentice Alchemy",
		min_skill = 1,
		max_skill = 75,
		trainers = {
			price = 50,
			sources = {  1215, 1246, 1386, 1470, 2132, 2391, 3009, 3184, 3347, 3603, 3964, 4160, 4609, 4611, 4900, 5177, 5499, 5500, 7948, 11041, 11042, 11044, 11046, 11047 },
		},
	},
	{
		id = 3101,
		name = "Journeyman Alchemy",
		min_skill = 50,
		max_skill = 150,
		trainers = {
			price = 500,
			sources = {  1386, 2391, 3347, 3964, 4160, 4609, 4611, 4900, 5177, 5499, 7948, 11042 },
		},
	},
	{
		id = 3464,
		name = "Expert Alchemy",
		min_skill = 125,
		max_skill = 225,
		trainers = {
			price = 5000,
			sources = {  1386, 4160, 4611, 7948 },
		},
	},
	{
		id = 11611,
		name = "Artisan Alchemy",
		min_skill = 200,
		max_skill = 300,
		min_xp_level = 35,
		trainers = {
			price = 50000,
			sources = {  1386, 7948 },
		},
	},
}
