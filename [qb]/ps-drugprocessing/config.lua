Config = {}

Config.Delays = {
	WeedProcessing = 1000 * 10,
	MethProcessing = 1000 * 10,
	CokeProcessing = 1000 * 10,
	lsdProcessing = 1000 * 10,
	HeroinProcessing = 1000 * 10,
	thionylchlorideProcessing = 1000 * 10,
}

Config.CircleZones = {
	WeedField = {coords = vector3(2224.64, 5577.03, 53.85), name = ('Weed Farm'), radius = 100.0},
	WeedProcessing = {coords = vector3(2329.12, 2571.86, 46.68), name = ('Weed Process'), radius = 100.0},
	
	MethProcessing = {coords = vector3(978.17, -147.98, -48.53), name = ('Meth Process'), radius = 20.0},
	MethTemp = {coords = vector3(982.56, -145.59, -49.0), name = ('Meth Temperature'), radius = 20.0},
	MethBag = {coords = vector3(987.81, -140.43, -49.0), name = ('Meth Bagging'), radius = 20.0},
	HydrochloricAcidFarm = {coords = vector3(-1658.7, -3153.17, 35.43), name = ('Hydrochloric Acid'), radius = 35.0},

	SulfuricAcidFarm = {coords = vector3(290.38, -2430.69, 8.04), name = ('Sulfuric Acid'), radius = 50.0},
	SodiumHydroxideFarm = {coords = vector3(1582.19, 2164.24, 79.4), name = ('Sodium Hydroxide'), radius = 50.0},
	
	ChemicalsField = {coords = vector3(3110.49, 6653.1, 0.13), name = ('Chemicals'), radius = 100.0},
	ChemicalsConvertionMenu = {coords = vector3(-317.91, -1051.57, 76.89), name = ('Chemicals Process'), radius = 100.0},

	CokeField = {coords = vector3(5346.69, -5813.02, 22.18), name = ('Coke'), radius = 20.0},
	CokeProcessing = {coords = vector3(1087.14, -3195.31, -38.99), name = ('Coke Process'), radius = 20.0}, 
	CokePowder = {coords = vector3(1092.9, -3196.65, -38.99), name = ('Powder Cutting'), radius = 20.0},--vector3(1092.9, -3196.65, -38.99)
	CokeBrick = {coords = vector3(1099.57, -3194.35, -38.99), name = ('Brick Up Packages'), radius = 20.0},--vector3(1099.57, -3194.35, -38.99)
	
	HeroinField = {coords = vector3(4796.64, -5944.42, 18.55), name = ('Heroin'), radius = 20.0},
	HeroinProcessing = {coords = vector3(1413.37, -2041.74, 52.0), name = ('Heroin Process'), radius = 100.0},

	lsdProcessing = {coords = vector3(2503.84, -428.11, 92.99), heading = 178.54, name = ('LSD process'), radius = 100.0},

	thionylchlorideProcessing = {coords = vector3(-679.75, 5800.16, 17.33), heading = 158.75, name = ('Thi Clo Process'), radius = 100.0},
}


Config.MethLab = {
	["enter"] = {
        coords = vector4(3541.16, 3668.3, 28.12, 139.58),
    },
    ["exit"] = {
        coords = vector4(969.57, -147.07, -46.4, 267.52),  --vector3(969.57, -147.07, -46.4)
    },
}

Config.CokeLab = {
	["enter"] = {
        coords = vector4(-411.79, 151.95, 81.74, 302.83), --vector3(813.21, -2398.69, 23.66)
    },
    ["exit"] = {
        coords = vector4(1088.68, -3187.68, -38.99, 176.04), -- GTA DLC Biker Cocaine Lab -- vector3(1088.68, -3187.68, -38.99)
    },
}

Config.WeedLab = {
	--[[["enter"] = {
        coords = vector4(813.21, -2398.69, 23.66, 171.51), --vector3(813.21, -2398.69, 23.66)
    },
    ["exit"] = {
        coords = vector4(1088.68, -3187.68, -38.99, 176.04), -- GTA DLC Biker Cocaine Lab -- vector3(1088.68, -3187.68, -38.99)
    },]]--
}


--------------------------------
-- DRUG CONFIG AMOUNTS --
--------------------------------

--------------------------------
-- COKE PROCESSING AMOUNTS --
--------------------------------

Config.CokeProcessing = {
	CokeLeaf = 200, -- Amount of Leaf Needed to Process
	ProcessCokeLeaf = math.random(20,70), -- Amount of Coke Received
	-- Processing Small Bricks --
	Coke = 50, -- Amount of Coke Needed for Small Brick
	BakingSoda = 10, -- Amount of Baking Soda Needed for Small Brick
	SmallCokeBrick = 1,
	-- Process Small Bricks Into Large Brick --
	SmallBrick = 5, -- Amount of Small Bricks Required
	LargeBrick = 1, -- Large Bricks Received
	Bags = 500,
}

--------------------------------
-- METH PROCESSING AMOUNTS --
--------------------------------
Config.MethProcessing = {
	-- Chemical Processing --
	SulfAcid = 25, -- Amount of Sulfuric Acid Needed for Liquid Mix
	HydAcid = 25, -- Amount of Hydrochloric Acid Needed for Liquid Mix
	SodHyd = 25, -- Amount of Sodium Hydroxide Needed for Liquid Mix
	Meth = math.random(50,100), -- Amount of Meth Recevied From 1 Tray
}

--------------------------------
-- HEROIN PROCESSING AMOUNTS --
--------------------------------
Config.HeroinProcessing = {
	Poppy = 2 -- Amount of Poppy Required for 1 Heroin
}