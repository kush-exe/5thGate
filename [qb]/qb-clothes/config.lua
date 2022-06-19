Config = {}

Config.DrawDistance = 10.0
Config.MarkerSize   = {x = 7.0, y = 7.0, z = 1.0}

Config.Money = 0 -- How much it takes from you when you open the clothing menu
Config.Debug = false

Config.ClothingShops = {
	[1] = {
		blip = true,
		coords = vector3(427.0880, -805.900, 28.491),
		MarkerSize   = {x = 7.0, y = 7.0, z = 1.0}
	},
	[2] = {
		blip = true,
		coords = vector3(73.86779, -1392.99, 28.376),
		MarkerSize   = {x = 7.0, y = 7.0, z = 1.0}
	},
	[3] = {
		blip = true,
		coords = vector3(126.6333, -225.045, 53.557),
		MarkerSize   = {x = 7.0, y = 7.0, z = 1.0}
	},
	[4] = {
		blip = true,
		coords = vector3(-164.627, -301.921, 38.733),
		MarkerSize   = {x = 7.0, y = 7.0, z = 1.0}
	},
	[5] = {
		blip = true,
		coords = vector3(-708.208, -152.955, 36.415),
		MarkerSize   = {x = 7.0, y = 7.0, z = 1.0}
	},
	[6] = {
		blip = true,
		coords = vector3(-1449.71, -238.977, 48.813),
		MarkerSize   = {x = 7.0, y = 7.0, z = 1.0}
	},
	[7] = {
		blip = true,
		coords = vector3(-1193.21, -766.425, 16.316),
		MarkerSize   = {x = 7.0, y = 7.0, z = 1.0}
	},
	[8] = {
		blip = true,
		coords = vector3(-823.166, -1072.28, 10.328),
		MarkerSize   = {x = 7.0, y = 7.0, z = 1.0}
	},
	[9] = {
		blip = true,
		coords = vector3(-1206.36, -1457.99, 3.3487),
		MarkerSize   = {x = 7.0, y = 7.0, z = 1.0}
	},
	[10] = {
		blip = true,
		coords = vector3(-3169.77, 1042.293, 19.863),
		MarkerSize   = {x = 7.0, y = 7.0, z = 1.0}
	},
	[11] = {
		blip = true,
		coords = vector3(612.9566, 2763.617, 41.088),
		MarkerSize   = {x = 7.0, y = 7.0, z = 1.0}
	},
	[12] = {
		blip = true,
		coords = vector3(1196.610, 2711.712, 37.222),
		MarkerSize   = {x = 7.0, y = 7.0, z = 1.0}
	},
	[13] = {
		blip = true,
		coords = vector3(1695.368, 4823.105, 41.063),
		MarkerSize   = {x = 7.0, y = 7.0, z = 1.0}
	},
	[14] = {
		blip = true,
		coords = vector3(5.868691, 6511.372, 30.877),
		MarkerSize   = {x = 7.0, y = 7.0, z = 1.0}
	},
	[15] = {
		blip = true,
		coords = vector3(4495.485, -4452.16, 3.3664),
		MarkerSize   = {x = 3.0, y = 5.0, z = 0.0}
	},
	[16] = {
		blip = true,
		coords = vector3(198.14, -875.92, 30.71),
		MarkerSize   = {x = 2.5, y = 2.0, z = 0.0}
	},
    [17] = {
		blip = true,
		coords = vector3(-1102.50, 2711.632, 18.107),
		MarkerSize   = {x = 2.5, y = 2.0, z = 0.0}
	},
}


Config.BarberShops = {
	vector3(922.7774, 21.39071, 70.833),
	vector3(136.8038, -1708.44, 28.291),
	vector3(-1282.60, -1116.80, 5.9938),
	vector3(1931.613, 3729.659, 31.844),
	vector3(1212.713, -472.972, 65.207),
	vector3(-32.9359, -152.341, 56.076),
	vector3(-278.205, 6228.501, 30.695),
	vector3(-814.235, -183.812, 36.568)
}

Config.ClothingRooms = {
    [1] = {requiredJob = "police", coords = vector3(462.1084, -999.1511, 30.6896)},
    [2] = {requiredJob = "ambulance", coords = vector3(298.8991, -598.097, 43.284)},
    [3] = {requiredJob = "sheriff", coords = vector3(-451.46, 6014.25, 31.72)},
    [4] = {requiredJob = "sicarios", coords = vector3(153.28, -3014.15, 7.04)}
}

Config.Outfits = {
    ["police"] = {
        ["male"] = {
            [1] = {
                outfitLabel = "LSPD Jacket Uniform",
                outfitData = {
                    ["pants"]       = { item = 35, texture = 0},  -- Broek
                    ["arms"]        = { item = 8, texture = 0},  -- Armen
                    ["t-shirt"]     = { item = 52, texture = 0},  -- T Shirt
                    ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                    ["torso2"]      = { item = 39, texture = 1},  -- Jas / Vesten
                    ["shoes"]       = { item = 24, texture = 0},  -- Schoenen
                    ["decals"]      = { item = 0, texture = 0},  -- Decals
                    ["accessory"]   = { item = 8, texture = 0},  -- Nek / Das
                    ["bag"]         = { item = 0, texture = 0},  -- Tas
                    ["hat"]         = { item = -1, texture = -1},  -- Pet
                    ["glass"]       = { item = 0, texture = 0},  -- Bril
            --      ["ear"]         = { item = 0, texture = 0},  -- Oor accessoires
                    ["mask"]         = { item = 0, texture = 0},  -- Masker
                },
            },
            [2] = {
                outfitLabel = "LSPD Uniform",
                outfitData = {
                    ["pants"]       = { item = 35, texture = 0},  -- Broek
                    ["arms"]        = { item = 0, texture = 0},  -- Armen
                    ["t-shirt"]     = { item = 53, texture = 0},  -- T Shirt
                    ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                    ["torso2"]      = { item = 18, texture = 0},  -- Jas / Vesten
                    ["shoes"]       = { item = 24, texture = 0},  -- Schoenen
                    ["decals"]      = { item = 0, texture = 0},  -- Decals
                    ["accessory"]   = { item = 8, texture = 0},  -- Nek / Das
                    ["bag"]         = { item = 0, texture = 0},  -- Tas
                    ["hat"]         = { item = -1, texture = -1},  -- Pet
            --      ["glass"]       = { item = 0, texture = 0},  -- Bril
                    ["ear"]         = { item = 0, texture = 0},  -- Oor accessoires
                    ["mask"]         = { item = 0, texture = 0},  -- Masker
                },
            },
            [3] = {
                outfitLabel = "LSPD Uniform with Vest",
                outfitData = {
                    ["pants"]       = { item = 35, texture = 0},  -- Pants
                    ["arms"]        = { item = 0, texture = 0},  -- Arms
                    ["t-shirt"]     = { item = 53, texture = 0},  -- T Shirt
                    ["vest"]        = { item = 12, texture = 3},  -- Body Vest
                    ["torso2"]      = { item = 18, texture = 0},  -- Jacket / Vests
                    ["shoes"]       = { item = 24, texture = 0},  -- Shoes
                    ["decals"]      = { item = 0, texture = 0},  -- Decals
                    ["accessory"]   = { item = 8, texture = 0},  -- Neck / Tie
                    ["bag"]         = { item = 0, texture = 0},  -- Bags
                    ["hat"]         = { item = -1, texture = -1},  -- Hats
            --      ["glass"]       = { item = 0, texture = 0},  -- Glasses
                    ["ear"]         = { item = 0, texture = 0},  -- Ear
                    ["mask"]         = { item = 0, texture = 0},  -- Mask
                },
            },
            [4] = {
                outfitLabel = "LSPD Uniform 2",
                outfitData = {
                    ["pants"]       = { item = 35, texture = 0},  -- Broek
                    ["arms"]        = { item = 1, texture = 0},  -- Armen
                    ["t-shirt"]     = { item = 53, texture = 0},  -- T Shirt
                    ["vest"]        = { item = 14, texture = 0},  -- Body Vest
                    ["torso2"]      = { item = 52, texture = 0},  -- Jas / Vesten
                    ["shoes"]       = { item = 25, texture = 0},  -- Schoenen
                    ["decals"]      = { item = 0, texture = 0},  -- Decals
                    ["accessory"]   = { item = 8, texture = 0},  -- Nek / Das
                    ["bag"]         = { item = 0, texture = 0},  -- Tas
                    ["hat"]         = { item = -1, texture = -1},  -- Pet
            --      ["glass"]       = { item = 0, texture = 0},  -- Bril
                    ["ear"]         = { item = 0, texture = 0},  -- Oor accessoires
                    ["mask"]         = { item = 0, texture = 0},  -- Masker
                },
            },
            [5] = {
                outfitLabel = "SWAT",
                outfitData = {
                    ["pants"]       = { item = 31, texture = 2}, 
                    ["arms"]        = { item = 1, texture = 0}, 
                    ["t-shirt"]     = { item = 15, texture = 0},  
                    ["vest"]        = { item = 15, texture = 0},  
                    ["torso2"]      = { item = 49, texture = 2},  
                    ["shoes"]       = { item = 25, texture = 0},  
                    ["decals"]      = { item = 3, texture = 0},  
                    ["accessory"]   = { item = 8, texture = 0},  
                    ["bag"]         = { item = 0, texture = 0},
                    ["hat"]         = { item = 39, texture = 2},  
            --      ["glass"]       = { item = 0, texture = 0},  
                    ["ear"]         = { item = -1, texture = 0}, 
                    ["mask"]         = { item = 0, texture = 0},  
                },
            },
        },
        ["female"] = {
        	[1] = {
                outfitLabel = "LSPD Jacket Uniform",
                outfitData = {
                    ["pants"]       = { item = 34, texture = 0},  -- Pants
                    ["arms"]        = { item = 14, texture = 0},  -- Arms
                    ["t-shirt"]     = { item = 53, texture = 0},  -- T Shirt
                    ["vest"]        = { item = 2, texture = 0},  -- Body Vest
                    ["torso2"]      = { item = 172, texture = 1},  -- Jacket / Vests
                    ["shoes"]       = { item = 25, texture = 0},  -- Shoes
                    ["decals"]      = { item = 0, texture = 0},  -- Decals
                    ["accessory"]   = { item = 8, texture = 0},  -- Neck / Tie
                    ["bag"]         = { item = 0, texture = 0},  -- Bags
                    ["hat"]         = { item = -1, texture = -1},  -- Hats
            --      ["glass"]       = { item = 0, texture = 0},  -- Glasses
                    ["ear"]         = { item = 0, texture = 0},  -- Ear
                    ["mask"]         = { item = 0, texture = 0},  -- Mask
                },
            },
            [2] = {
                outfitLabel = "LSPD Uniform",
                outfitData = {
                    ["pants"]       = { item = 34, texture = 0},  -- Pants
                    ["arms"]        = { item = 14, texture = 0},  -- Arms
                    ["t-shirt"]     = { item = 34, texture = 0},  -- T Shirt
                    ["vest"]        = { item = 1, texture = 0},  -- Body Vest
                    ["torso2"]      = { item = 36, texture = 0},  -- Jacket / Vests
                    ["shoes"]       = { item = 25, texture = 0},  -- Shoes
                    ["decals"]      = { item = 0, texture = 0},  -- Decals
                    ["accessory"]   = { item = 8, texture = 0},  -- Neck / Tie
                    ["bag"]         = { item = 0, texture = 0},  -- Bags
                    ["hat"]         = { item = -1, texture = -1},  -- Hats
            --      ["glass"]       = { item = 0, texture = 0},  -- Glasses
                    ["ear"]         = { item = 0, texture = 0},  -- Ear
                    ["mask"]         = { item = 0, texture = 0},  -- Mask
                },
            },
            [3] = {
                outfitLabel = "Neck Cover",
                outfitData = {
                    ["vest"]        = { item = 28, texture = 0},  -- Body Vest
                },
            },
        }
    },
    ["ambulance"] = {
        ["male"] = {
            [1] = {
                outfitLabel = "Paramedic",
                outfitData = {
                    
                    ["arms"]        = { item = 85, texture = 0},  -- Arms
                    ["t-shirt"]     = { item = 129, texture = 0},  -- T Shirt
                    ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                    ["torso2"]      = { item = 250, texture = 0},  -- Jacket / Vests
                    ["pants"]       = { item = 35,texture = 0},  -- Pants
                    ["decals"]      = { item = 58, texture = 1},  -- Decals
                    ["accessory"]   = { item = 0, texture = 0},  -- Neck Tie
                    ["bag"]         = { item = 0, texture = 0},  -- Bag
                    ["hat"]         = { item = -1, texture = -1},  -- Hat
                    --["glass"]       = { item = 0, texture = 0},  -- Glasses
                    ["ear"]         = { item = -1, texture = 0},  -- Ear
                    ["mask"]        = { item = 0, texture = 0},  -- Mask
                    ["shoes"]       = { item = 25, texture = 0},  -- Shoes
                },
            },
            [2] = {
                outfitLabel = "Hat 1",
                outfitData = {
                    ["hat"]         = { item = 122, texture = 0},  -- Hat
                },
            },
			[3] = {
                outfitLabel = "Hat 2",
                outfitData = {
                    ["hat"]         = { item = 122, texture = 1},  -- Hat
                },
			},
			[4] = {
                outfitLabel = "Gloves 1",
                outfitData = {
                    ["arms"]        = { item = 85, texture = 1},  -- Arms
                },
            },
            [5] = {
                outfitLabel = "Gloves 2",
                outfitData = {
                    ["arms"]        = { item = 85, texture = 0},  -- Arms
                },
            },
        },
        ["female"] = {
        	[1] = {
                outfitLabel = "Paramedic",
                outfitData = {
                    ["arms"]        = { item = 100, texture = 0},  -- Arms
                    ["t-shirt"]     = { item = 159, texture = 0},  -- T Shirt
                    ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                    ["torso2"]      = { item = 258, texture = 0},  -- Jacket / Vests
                    ["pants"]       = { item = 34,texture = 0},  -- Pants
                    ["decals"]      = { item = 66, texture = 1},  -- Decals
                    ["accessory"]   = { item = 0, texture = 0},  -- Neck Tie
                    ["bag"]         = { item = 0, texture = 0},  -- Bag
                    ["hat"]         = { item = -1, texture = -1},  -- Hat
                    --["glass"]       = { item = 0, texture = 0},  -- Glasses
                    ["ear"]         = { item = -1, texture = 0},  -- Ear
                    ["mask"]        = { item = 0, texture = 0},  -- Mask
                    ["shoes"]       = { item = 25, texture = 0},  -- Shoes
                },
            },
            [2] = {
                outfitLabel = "Hat 1",
                outfitData = {
                    ["hat"]        = { item = 121, texture = 0},  -- Hat
                },
            },
            [3] = {
                outfitLabel = "Hat 2",
                outfitData = {
                    ["hat"]        = { item = 121, texture = 1},  -- Hat
                   
                },
            },
            [4] = {
                outfitLabel = "Gloves 1",
                outfitData = {
                    ["arms"]        = { item = 100, texture = 1},  -- Arms
                },
            },
            [5] = {
                outfitLabel = "Gloves 2",
                outfitData = {
                    ["arms"]        = { item = 100, texture = 0},  -- Arms
                   
                },
            },
        },
    },
    ["doctor"] = {
        ["male"] = {
            [1] = {
                outfitLabel = "Doctor",
                outfitData = {
                    ["arms"]        = { item = 88, texture = 0},  -- Arms
                    ["t-shirt"]     = { item = 15, texture = 0},  -- T Shirt
                    ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                    ["torso2"]      = { item = 3, texture = 6},  -- Jacket / Vests
                    ["pants"]       = { item = 35,texture = 0},  -- Pants
                    ["decals"]      = { item = 58, texture = 1},  -- Decals
                    ["accessory"]   = { item = 0, texture = 0},  -- Neck Tie
                    ["bag"]         = { item = 0, texture = 0},  -- Bag
                    ["hat"]         = { item = -1, texture = -1},  -- Hat
                    --["glass"]       = { item = 0, texture = 0},  -- Glasses
                    ["ear"]         = { item = -1, texture = 0},  -- Ear
                    ["mask"]        = { item = 0, texture = 0},  -- Mask
                    ["shoes"]       = { item = 25, texture = 0},  -- Shoes
				},
			},
			[2] = {
                outfitLabel = "Gloves 1",
                outfitData = {
                    ["arms"]        = { item = 88, texture = 1},  -- Arms
                },
			},			
			[3] = {
                outfitLabel = "Gloves 2",
                outfitData = {
                    ["arms"]        = { item = 88, texture = 0},  -- Arms
                },
			},
			[4] = {
                outfitLabel = "Paramedic",
                outfitData = {
                    
                    ["arms"]        = { item = 85, texture = 0},  -- Arms
                    ["t-shirt"]     = { item = 129, texture = 0},  -- T Shirt
                    ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                    ["torso2"]      = { item = 250, texture = 0},  -- Jacket / Vests
                    ["pants"]       = { item = 35,texture = 0},  -- Pants
                    ["decals"]      = { item = 58, texture = 1},  -- Decals
                    ["accessory"]   = { item = 0, texture = 0},  -- Neck Tie
                    ["bag"]         = { item = 0, texture = 0},  -- Bag
                    ["hat"]         = { item = -1, texture = -1},  -- Hat
                    --["glass"]       = { item = 0, texture = 0},  -- Glasses
                    ["ear"]         = { item = -1, texture = 0},  -- Ear
                    ["mask"]        = { item = 0, texture = 0},  -- Mask
                    ["shoes"]       = { item = 25, texture = 0},  -- Shoes
                },
			},
			[5] = {
                outfitLabel = "Hat 1",
                outfitData = {
                    ["hat"]         = { item = 122, texture = 0},  -- Hat
                },
            },
			[6] = {
                outfitLabel = "Hat 2",
                outfitData = {
                    ["hat"]         = { item = 122, texture = 1},  -- Hat
                },
			},
		},		
        ["female"] = {
            [1] = {
                outfitLabel = "Paramedic",
                outfitData = {
                    ["arms"]        = { item = 100, texture = 0},  -- Arms
                    ["t-shirt"]     = { item = 159, texture = 0},  -- T Shirt
                    ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                    ["torso2"]      = { item = 258, texture = 0},  -- Jacket / Vests
                    ["pants"]       = { item = 34,texture = 0},  -- Pants
                    ["decals"]      = { item = 66, texture = 1},  -- Decals
                    ["accessory"]   = { item = 0, texture = 0},  -- Neck Tie
                    ["bag"]         = { item = 0, texture = 0},  -- Bag
                    ["hat"]         = { item = -1, texture = -1},  -- Hat
                    --["glass"]       = { item = 0, texture = 0},  -- Glasses
                    ["ear"]         = { item = -1, texture = 0},  -- Ear
                    ["mask"]        = { item = 0, texture = 0},  -- Mask
                    ["shoes"]       = { item = 25, texture = 0},  -- Shoes
                },
            },
            [2] = {
                outfitLabel = "Hat 1",
                outfitData = {
                    ["hat"]        = { item = 121, texture = 0},  -- Hat
                },
            },
            [3] = {
                outfitLabel = "Hat 2",
                outfitData = {
                    ["hat"]        = { item = 121, texture = 1},  -- Hat
                   
                },
            },
            [4] = {
                outfitLabel = "Gloves 1",
                outfitData = {
                    ["arms"]        = { item = 100, texture = 1},  -- Arms
                },
            },
            [5] = {
                outfitLabel = "Gloves 2",
                outfitData = {
                    ["arms"]        = { item = 100, texture = 0},  -- Arms
                   
                },
            },
        },
    },
    ["sicarios"] = {
        ["male"] = {
            [1] = {
                outfitLabel = "Sicarios 1",
                outfitData = {
                    ["arms"]        = { item = 88, texture = 0},  -- Arms
                    ["t-shirt"]     = { item = 15, texture = 0},  -- T Shirt
                    ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                    ["torso2"]      = { item = 3, texture = 6},  -- Jacket / Vests
                    ["pants"]       = { item = 35,texture = 0},  -- Pants
                    ["decals"]      = { item = 58, texture = 1},  -- Decals
                    ["accessory"]   = { item = 0, texture = 0},  -- Neck Tie
                    ["bag"]         = { item = 0, texture = 0},  -- Bag
                    ["hat"]         = { item = -1, texture = -1},  -- Hat
                    --["glass"]       = { item = 0, texture = 0},  -- Glasses
                    ["ear"]         = { item = -1, texture = 0},  -- Ear
                    ["mask"]        = { item = 0, texture = 0},  -- Mask
                    ["shoes"]       = { item = 25, texture = 0},  -- Shoes
				},
			},
		},		
        ["female"] = {
            [1] = {
                outfitLabel = "Sicarios 1",
                outfitData = {
                    ["arms"]        = { item = 100, texture = 0},  -- Arms
                    ["t-shirt"]     = { item = 159, texture = 0},  -- T Shirt
                    ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                    ["torso2"]      = { item = 258, texture = 0},  -- Jacket / Vests
                    ["pants"]       = { item = 34,texture = 0},  -- Pants
                    ["decals"]      = { item = 66, texture = 1},  -- Decals
                    ["accessory"]   = { item = 0, texture = 0},  -- Neck Tie
                    ["bag"]         = { item = 0, texture = 0},  -- Bag
                    ["hat"]         = { item = -1, texture = -1},  -- Hat
                    --["glass"]       = { item = 0, texture = 0},  -- Glasses
                    ["ear"]         = { item = -1, texture = 0},  -- Ear
                    ["mask"]        = { item = 0, texture = 0},  -- Mask
                    ["shoes"]       = { item = 25, texture = 0},  -- Shoes
                },
            },
        },
    },
}

Config.PedQube = {
	[1] = {
		["nome"] = "pedclothing10",
        ["coordinate"] = vector3(427.0880, -805.900, 28.491), --215
		["heading"] = 94.49, --ped heading
		["modello"] = "ig_miguelmadrazo",
		["dict"] = "anim@amb@nightclub@peds@", --animation dict
        ["anim"] = "rcmme_amanda1_stand_loop_cop", --anim name
		["fisso"] = false, --whether the ped should spawn or despawn based on distance 
        ["spawnato"] = false, --bool to check if the ped has already spawned (don't touch if you don't know what you are doing) 
	},
	[2] = {
		["nome"] = "pedclothing11",
        ["coordinate"] = vector3(73.86779, -1392.99, 28.376), --134
		["heading"] = 274.8, --ped heading
        ["modello"] = "ig_miguelmadrazo",
		["dict"] = "anim@amb@nightclub@peds@", --animation dict
        ["anim"] = "rcmme_amanda1_stand_loop_cop", --anim name
		["fisso"] = false, --whether the ped should spawn or despawn based on distance 
        ["spawnato"] = false, --bool to check if the ped has already spawned (don't touch if you don't know what you are doing) 
	},
	[3] = {
        ["nome"] = "pedclothing12",
		["coordinate"] = vector3(126.6333, -225.045, 53.557), --583
		["heading"] = 24.14, --ped heading
		["modello"] = "ig_miguelmadrazo",
		["dict"] = "anim@amb@nightclub@peds@", --animation dict
        ["anim"] = "rcmme_amanda1_stand_loop_cop", --anim name
		["fisso"] = false, --whether the ped should spawn or despawn based on distance 
        ["spawnato"] = false, --bool to check if the ped has already spawned (don't touch if you don't know what you are doing) 
	},
	[4] = {
        ["nome"] = "pedclothing13",
		["coordinate"] = vector3(-164.627, -301.921, 38.733), --539
		["heading"] = 249.9, --ped heading
		["modello"] = "ig_miguelmadrazo",
		["dict"] = "anim@amb@nightclub@peds@", --animation dict
        ["anim"] = "rcmme_amanda1_stand_loop_cop", --anim name
		["fisso"] = false, --whether the ped should spawn or despawn based on distance 
        ["spawnato"] = false, --bool to check if the ped has already spawned (don't touch if you don't know what you are doing) 
	},
	[5] = {
        ["nome"] = "pedclothing14",
		["coordinate"] = vector3(-708.208, -152.955, 36.415), --696
		["heading"] = 116.1, --ped heading
		["modello"] = "ig_miguelmadrazo",
		["dict"] = "anim@amb@nightclub@peds@", --animation dict
        ["anim"] = "rcmme_amanda1_stand_loop_cop", --anim name
		["fisso"] = false, --whether the ped should spawn or despawn based on distance 
        ["spawnato"] = false, --bool to check if the ped has already spawned (don't touch if you don't know what you are doing) 
	},
	[6] = {
        ["nome"] = "pedclothing15",
		["coordinate"] = vector3(-1449.71, -238.977, 48.813), --644
		["heading"] = 49.51, --ped heading
		["modello"] = "ig_miguelmadrazo",
		["dict"] = "anim@amb@nightclub@peds@", --animation dict
        ["anim"] = "rcmme_amanda1_stand_loop_cop", --anim name
		["fisso"] = false, --whether the ped should spawn or despawn based on distance 
        ["spawnato"] = false, --bool to check if the ped has already spawned (don't touch if you don't know what you are doing) 
	},
	[7] = {
        ["nome"] = "pedclothing16",
		["coordinate"] = vector3(-1193.21, -766.425, 16.316), --342
		["heading"] = 219.9, --ped heading
		["modello"] = "ig_miguelmadrazo",
		["dict"] = "anim@amb@nightclub@peds@", --animation dict
        ["anim"] = "rcmme_amanda1_stand_loop_cop", --anim name
		["fisso"] = false, --whether the ped should spawn or despawn based on distance 
        ["spawnato"] = false, --bool to check if the ped has already spawned (don't touch if you don't know what you are doing) 
	},
	[8] = {
        ["nome"] = "pedclothing17",
		["coordinate"] = vector3(-823.166, -1072.28, 10.328), --354
		["heading"] = 221.6, --ped heading
		["modello"] = "ig_miguelmadrazo",
		["dict"] = "anim@amb@nightclub@peds@", --animation dict
        ["anim"] = "rcmme_amanda1_stand_loop_cop", --anim name
		["fisso"] = false, --whether the ped should spawn or despawn based on distance 
        ["spawnato"] = false, --bool to check if the ped has already spawned (don't touch if you don't know what you are doing) 
	},
	[9] = {
        ["nome"] = "pedclothing18",
		["coordinate"] = vector3(-1206.36, -1457.99, 3.3487), --307
		["heading"] = 36.66, --ped heading
		["modello"] = "ig_miguelmadrazo",
		["dict"] = "anim@amb@nightclub@peds@", --animation dict
        ["anim"] = "rcmme_amanda1_stand_loop_cop", --anim name
		["fisso"] = false, --whether the ped should spawn or despawn based on distance 
        ["spawnato"] = false, --bool to check if the ped has already spawned (don't touch if you don't know what you are doing) 
	},
	[10] = {
		["nome"] = "pedclothing19",
        ["coordinate"] = vector3(-3169.77, 1042.293, 19.863), --908
		["heading"] = 61.47, --ped heading
		["modello"] = "ig_miguelmadrazo",
		["dict"] = "anim@amb@nightclub@peds@", --animation dict
        ["anim"] = "rcmme_amanda1_stand_loop_cop", --anim name
		["fisso"] = false, --whether the ped should spawn or despawn based on distance 
        ["spawnato"] = false, --bool to check if the ped has already spawned (don't touch if you don't know what you are doing) 
	},
	[11] = {
		["nome"] = "pedclothing20",
        ["coordinate"] = vector3(612.9566, 2763.617, 41.088), --930
		["heading"] = 274.6, --ped heading
		["modello"] = "ig_miguelmadrazo",
		["dict"] = "anim@amb@nightclub@peds@", --animation dict
        ["anim"] = "rcmme_amanda1_stand_loop_cop", --anim name
		["fisso"] = false, --whether the ped should spawn or despawn based on distance 
        ["spawnato"] = false, --bool to check if the ped has already spawned (don't touch if you don't know what you are doing) 
	},
	[12] = {
		["nome"] = "pedclothing21",
        ["coordinate"] = vector3(1196.610, 2711.712, 37.222), --940
		["heading"] = 178.4, --ped heading
		["modello"] = "ig_miguelmadrazo",
		["dict"] = "anim@amb@nightclub@peds@", --animation dict
        ["anim"] = "rcmme_amanda1_stand_loop_cop", --anim name
		["fisso"] = false, --whether the ped should spawn or despawn based on distance 
        ["spawnato"] = false, --bool to check if the ped has already spawned (don't touch if you don't know what you are doing) 
	},
	[13] = {
        ["coordinate"] = vector3(1695.368, 4823.105, 41.063), --2014
		["heading"] = 99.91, --ped heading
		["modello"] = "ig_miguelmadrazo",
		["dict"] = "anim@amb@nightclub@peds@", --animation dict
        ["anim"] = "rcmme_amanda1_stand_loop_cop", --anim name
		["fisso"] = false, --whether the ped should spawn or despawn based on distance 
        ["spawnato"] = false, --bool to check if the ped has already spawned (don't touch if you don't know what you are doing) 
	},
	[14] = {
		["nome"] = "pedclothing22",
        ["coordinate"] = vector3(5.868691, 6511.372, 30.877), --3024
		["heading"] = 42.43, --ped heading
		["modello"] = "ig_miguelmadrazo",
		["dict"] = "anim@amb@nightclub@peds@", --animation dict
        ["anim"] = "rcmme_amanda1_stand_loop_cop", --anim name
		["fisso"] = false, --whether the ped should spawn or despawn based on distance 
        ["spawnato"] = false, --bool to check if the ped has already spawned (don't touch if you don't know what you are doing) 
	},
	[15] = {
		["nome"] = "pedclothing23",
        ["coordinate"] = vector3(4495.485, -4452.16, 3.3664), --cayo perico
		["heading"] = 209.2, --ped heading
		["modello"] = "ig_miguelmadrazo",
		["dict"] = "anim@amb@nightclub@peds@", --animation dict
        ["anim"] = "rcmme_amanda1_stand_loop_cop", --anim name
		["fisso"] = false, --whether the ped should spawn or despawn based on distance 
        ["spawnato"] = false, --bool to check if the ped has already spawned (don't touch if you don't know what you are doing) 
	},
	[16] = {
		["nome"] = "pedclothing24",
        ["coordinate"] = vector3(-1102.50, 2711.632, 18.107), --cayo perico
		["heading"] = 220.8, --ped heading
		["modello"] = "ig_miguelmadrazo",
		["dict"] = "anim@amb@nightclub@peds@", --animation dict
        ["anim"] = "rcmme_amanda1_stand_loop_cop", --anim name
		["fisso"] = false, --whether the ped should spawn or despawn based on distance 
        ["spawnato"] = false, --bool to check if the ped has already spawned (don't touch if you don't know what you are doing) 
	},
	----barber
	[17] = {
		["nome"] = "pedclothing25",
        ["coordinate"] = vector3(922.7774, 21.39071, 70.833), --dove deve spawnare il ped vector3
		["heading"] = 287.1, --ped heading
		["modello"] = "ig_miguelmadrazo",
		["dict"] = "anim@amb@nightclub@peds@", --animation dict
        ["anim"] = "rcmme_amanda1_stand_loop_cop", --anim name
		["fisso"] = false, --whether the ped should spawn or despawn based on distance 
        ["spawnato"] = false, --bool to check if the ped has already spawned (don't touch if you don't know what you are doing) 
	},
	[18] = {
		["nome"] = "pedclothing26",
        ["coordinate"] = vector3(136.8038, -1708.44, 28.291), --129
		["heading"] = 137.8, --ped heading
		["modello"] = "s_f_y_clubbar_02",
		["dict"] = "anim@amb@nightclub@peds@", --animation dict
        ["anim"] = "rcmme_amanda1_stand_loop_cop", --anim name
		["fisso"] = false, --whether the ped should spawn or despawn based on distance 
        ["spawnato"] = false, --bool to check if the ped has already spawned (don't touch if you don't know what you are doing) 
	},
	[19] = {
		["nome"] = "pedclothing27",
        ["coordinate"] = vector3(-1282.60, -1116.80, 5.9938), --314
		["heading"] = 138.6, --ped heading
		["modello"] = "s_f_y_clubbar_02",
		["dict"] = "anim@amb@nightclub@peds@", --animation dict
        ["anim"] = "rcmme_amanda1_stand_loop_cop", --anim name
		["fisso"] = false, --whether the ped should spawn or despawn based on distance 
        ["spawnato"] = false, --bool to check if the ped has already spawned (don't touch if you don't know what you are doing) 
	},
	[20] = {
		["nome"] = "pedclothing28",
        ["coordinate"] = vector3(1931.613, 3729.659, 31.844), --1033
		["heading"] = 220.3, --ped heading
		["modello"] = "s_f_y_clubbar_02",
		["dict"] = "anim@amb@nightclub@peds@", --animation dict
        ["anim"] = "rcmme_amanda1_stand_loop_cop", --anim name
		["fisso"] = false, --whether the ped should spawn or despawn based on distance 
        ["spawnato"] = false, --bool to check if the ped has already spawned (don't touch if you don't know what you are doing) 
	},
	[21] = {
		["nome"] = "pedclothing29",
        ["coordinate"] = vector3(1212.713, -472.972, 65.207), --436
		["heading"] = 78.45, --ped heading
		["modello"] = "s_f_y_clubbar_02",
		["dict"] = "anim@amb@nightclub@peds@", --animation dict
        ["anim"] = "rcmme_amanda1_stand_loop_cop", --anim name
		["fisso"] = false, --whether the ped should spawn or despawn based on distance 
        ["spawnato"] = false, --bool to check if the ped has already spawned (don't touch if you don't know what you are doing) 
	},
	[22] = {
		["nome"] = "pedclothing30",
        ["coordinate"] = vector3(-32.9359, -152.341, 56.076), --571
		["heading"] = 340.4, --ped heading
		["modello"] = "s_f_y_clubbar_02",
		["dict"] = "anim@amb@nightclub@peds@", --animation dict
        ["anim"] = "rcmme_amanda1_stand_loop_cop", --anim name
		["fisso"] = false, --whether the ped should spawn or despawn based on distance 
        ["spawnato"] = false, --bool to check if the ped has already spawned (don't touch if you don't know what you are doing) 
	},
	[23] = {
		["nome"] = "pedclothing31",
        ["coordinate"] = vector3(-278.205, 6228.501, 30.695), --3012
		["heading"] = 52.88, --ped heading
		["modello"] = "s_f_y_clubbar_02",
		["dict"] = "anim@amb@nightclub@peds@", --animation dict
        ["anim"] = "rcmme_amanda1_stand_loop_cop", --anim name
		["fisso"] = false, --whether the ped should spawn or despawn based on distance 
        ["spawnato"] = false, --bool to check if the ped has already spawned (don't touch if you don't know what you are doing) 
	},
	[24] = {
		["nome"] = "pedclothing32",
        ["coordinate"] = vector3(-814.235, -183.812, 36.568), --682
		["heading"] = 129.5, --ped heading
		["modello"] = "s_f_y_clubbar_02",
		["dict"] = "anim@amb@nightclub@peds@", --animation dict
        ["anim"] = "rcmme_amanda1_stand_loop_cop", --anim name
		["fisso"] = false, --whether the ped should spawn or despawn based on distance 
        ["spawnato"] = false, --bool to check if the ped has already spawned (don't touch if you don't know what you are doing) 
	},
    [25] = {
		["nome"] = "pedclothing33",
        ["coordinate"] = vector3(197.3, -872.04, 29.71), --682
		["heading"] = 205.87, --ped heading
		["modello"] = "ig_miguelmadrazo",
		["dict"] = "anim@amb@nightclub@peds@", --animation dict
        ["anim"] = "rcmme_amanda1_stand_loop_cop", --anim name
		["fisso"] = false, --whether the ped should spawn or despawn based on distance 
        ["spawnato"] = false, --bool to check if the ped has already spawned (don't touch if you don't know what you are doing) 
	},
}
