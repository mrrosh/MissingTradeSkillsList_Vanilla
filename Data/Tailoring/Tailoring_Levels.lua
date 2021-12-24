----------------------
-- Levels Tailoring --
----------------------
MTSLDATA["Tailoring"]["levels"] = {
	{
		id = 3908,
		name = "Apprentice Tailoring",
		min_skill = 1,
		max_skill = 75,
		trainers = {
			price = 50,
			sources = {  1103, 1300, 1346, 1703, 2399, 2627, 2855, 3004, 3363, 3484, 3523, 4193, 4576, 5153, 5567, 11048, 11049, 11050, 11051, 11052, 11557 },
		},
	},
	{
		id = 3909,
		name = "Journeyman Tailoring",
		min_skill = 50,
		max_skill = 150,
		trainers = {
			price = 500,
			sources = {  1346, 2399, 2627, 3004, 3363, 3704, 4159, 4576, 5153, 5567, 11049, 11052, 11557 },
		},
	},
	{
		id = 3910,
		name = "Expert Tailoring",
		min_skill = 125,
		max_skill = 225,
		trainers = {
			price = 5000,
			sources = {  1346, 2399, 4576, 11052, 11557 },
		},
	},
	{
		id = 12180,
		name = "Artisan Tailoring",
		min_skill = 200,
		max_skill = 300,
		min_xp_level = 35,
		trainers = {
			price = 50000,
			sources = {  2399, 11052, 11557 },
		},
	},
}
