local Config={}
--Types[1], Types[2], Types[3] = {}, {}, {}
-------------------------------------------------------------------------------
-- Settings
-------------------------------------------------------------------------------
-- It's possible to interact with entities through walls so this should be low
Config.MaxDistance = 3.0

-- Enable debug options and distance preview
Config.Debug = false

-- Enable outlines around the entity you're looking at
Config.EnableOutline = false

-- Enable default options (Toggling vehicle doors)
Config.EnableDefaultOptions = false

-------------------------------------------------------------------------------
-- Target Configs
-------------------------------------------------------------------------------

-- These are all empty for you to fill in, refer to the wiki and .md files for help in filling these in

Config.CircleZones = {

}

Config.BoxZones = {

}

Config.PolyZones = {

}

Config.TargetBones = {

}

Config.TargetEntities = {

}

Config.EntityZones = {

}

Config.TargetModels = {

}

Config.GlobalPedOptions = {
}

Config.GlobalVehicleOptions = {

}

Config.GlobalObjectOptions = {

}

Config.GlobalPlayerOptions = {

}

Config.Peds = {
	--stores (convienience and liquor)
	{
		model = 'u_f_o_moviestar', --nancy pillbox hospital
		coords = vector4(308.44, -595.31, 43.28, 72.77),
		minusOne = true,
		gender = 'female',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'mp_m_shopkeep_01', --shop keeper grove st
		coords = vector4(-47.165, -1758.707, 29.421-0.95, 48.975),
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'mp_m_shopkeep_01', --shop keeper forum
		coords = vector4(24.502,  -1345.626, 29.497-0.95, 265.975),
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'mp_m_shopkeep_01', --shop keeper lil seoul
		coords = vector4(-706.017, -914.453, 19.216-0.95, 87.975),
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'mp_m_shopkeep_01', --shop keeper vinewood
		coords = vector4(372.951, 328.117, 103.566-0.95, 249.975),
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'mp_m_shopkeep_01', --shop keeper Paleto
		coords = vector4(160.69648, 6641.7963, 31.698944, 222.25073),
		gender = 'male',
		minusOne = true,
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'mp_m_shopkeep_01', --shop keeper insenso rd west
		coords = vector4(-3040.612, 584.042, 7.909-0.95, 15.975),
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'mp_m_shopkeep_01', --shop keeper insenso rd east
		coords = vector4(-3243.932, 1000.088, 12.831-0.95, 350.975),
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'mp_m_shopkeep_01', --shop keeper mirror park LTD east
		coords = vector4(1164.836, -323.648,  69.205-0.95, 98.975),
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'mp_m_shopkeep_01', --shop keeper north rockford ltd
		coords = vector4(-1819.544, 793.518, 138.086-0.95, 131.975),
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'mp_m_shopkeep_01', --shop keeper sandy
		coords = vector4(549.328, 2669.604, 42.156-0.95, 91.975),
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'mp_m_shopkeep_01', --shop keeper sandy 2
		coords = vector4(1959.253, 3741.500, 32.344-0.95, 295.975),
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'mp_m_shopkeep_01', --shop keeper grapeseed LTD
		coords = vector4(1697.254, 4923.475, 42.064-0.95, 318.975),
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'mp_m_shopkeep_01', --shop keeper north north LTD
		coords = vector4(1728.529, 6416.731, 35.037-0.95, 242.975),
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'mp_m_shopkeep_01', --shop keeper Licquor Insenso Road 3 (west)
		coords = vector4(-2966.325, 391.624, 15.043-0.95, 95.975),
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'mp_m_shopkeep_01', --shop keeper Licquor Prosperity st (west)
		coords = vector4(-1486.590, -377.572, 40.163-0.95, 132.975),
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'mp_m_shopkeep_01', --shop keeper liquor vespucci (burger shot)
		coords = vector4(-1221.438, -908.001, 12.326-0.95, 25.975),
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'mp_m_shopkeep_01', --shop keeper liquor vespucci blvd
		coords = vector4(1134.218, -983.201,  46.416-0.95, 276.975),
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'mp_m_shopkeep_01', --shop keeper sandy east
		coords = vector4(1165.302, 2710.887, 38.158-0.95, 174.975),
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'mp_m_shopkeep_01', --shop keeper paleto east
		coords = vector4(-160.761, 6320.935, 31.587-0.95, 308.975),
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 's_m_m_lathandy_01', --shop keeper hardware strawberry
		coords = vector4(46.59, -1749.39, 29.64, 46.24),
		minusOne = true,
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 's_m_m_lathandy_01', --shop keeper hawdware sandy
		coords = vector4(2747.91, 3472.8, 55.67, 253.42),
		minusOne = true,
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 's_m_m_lathandy_01', --PIER STORE
		coords = vector4(-1686.9, -1072.23, 13.15, 49.02),
		minusOne = true,
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 's_m_m_lathandy_01', --shop keeper hardware paleto
		coords = vector4(-421.55, 6136.7, 31.88, 177.51),
		minusOne = true,
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'cs_wade', --Weed Store
		coords = vector4(-1170.99, -1571.262, 4.6636285, 133.92623),
		minusOne = true,
		gender = 'female',
		freeze = true,
		invincible = true,
		blockevents = true,
	},

	--garages
	{
		model = 'ig_trafficwarden', --garage motel
		coords = vector4(274.64, -344.41, 45.17, 75.37),
		minusOne = true,
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'ig_trafficwarden', --garage airport
		coords = vector4(-796.9232, -2024.762, 8.8897333, 153.07299),
		minusOne = true,
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'ig_trafficwarden', --garage beach
		coords = vector4(-1183.17, -1511.087, 4.3630127, 213.38923),
		minusOne = true,
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'ig_trafficwarden', --garage caesars24
		coords = vector4(69.85437, 12.539829, 68.959251, 257.09634),
		minusOne = true,
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'ig_trafficwarden', --garage dumbo
		coords = vector4(160.16807, -3238.009, 5.9924221, 282.99462),
		minusOne = true,
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'ig_trafficwarden', --garage haan
		coords = vector4(84.76976, 6421.4531, 31.534305, 315.44735),
		minusOne = true,
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'ig_trafficwarden', --garage laguna
		coords = vector4(364.37106, 297.87832, 103.49333, 253.44842),
		minusOne = true,
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'ig_trafficwarden', --garage liquor
		coords = vector4(954.57226, 3619.8652, 32.650661, 97.69651),
		minusOne = true,
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'ig_trafficwarden', --garage San Andreas
		coords = vector4(-330.1826, -780.2631, 33.964481, 50.034839),
		minusOne = true,
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'ig_trafficwarden', --garage Caesars2
		coords = vector4(-475.3212, -818.7654, 30.466123, 272.34692),
		minusOne = true,
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'ig_trafficwarden', --garage Shore
		coords = vector4(1726.304, 3707.1044, 34.174266, 29.799741),
		minusOne = true,
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'ig_trafficwarden', --garage Spanish Ave
		coords = vector4(-1160.849, -741.3594, 19.641942, 125.13539),
		minusOne = true,
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'ig_trafficwarden', --garage Motor Hotel
		coords = vector4(1141.0053, 2663.8549, 38.160865, 92.107254),
		minusOne = true,
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'ig_floyd', --depot strawberry
		coords = vector4(408.15939, -1625.004, 29.291952, 226.00161),
		minusOne = true,
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	
	--tattoo shops
	{
		model = 'g_f_y_lost_01', --tattoo shop paleto
		coords = vector4(-294.85, 6200.41, 31.49, 249.2),
		minusOne = true,
		gender = 'female',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'g_f_y_lost_01', --tattoo shop chumash
		coords = vector4(-3168.79, 1077.38, 20.83, 159.99),
		minusOne = true,
		gender = 'female',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'g_f_y_lost_01', --tattoo shop vespucci
		coords = vector4(-1155.68, -1426.76, 4.95 , 325.33),
		minusOne = true,
		gender = 'female',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'g_f_y_lost_01', --tattoo shop fudge lane
		coords = vector4(-1321.15, -1653.33, 52.28, 315.0),
		minusOne = true,
		gender = 'female',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'g_f_y_lost_01', --tattoo shop vinewood
		coords = vector4(324.31, 179.52, 103.59, 64.82),
		minusOne = true,
		gender = 'female',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'g_f_y_lost_01', --tattoo shop sandy
		coords = vector4(1865.56, 3746.75, 33.03, 46.56),
		minusOne = true,
		gender = 'female',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'g_f_y_lost_01', --tattoo shop sandy
		coords = vector4(1321.4326, -1653.328, 52.275188, 319.04605),
		minusOne = true,
		gender = 'female',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	--[[{
		model = 'mp_m_weapexp_01', --Legion Gun Shop
		coords = vector4(20.888828, -1104.931, 29.797012, 164.71984),
		minusOne = true,
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},]]
	{
		model = 'mp_m_weapexp_01', --Sandy Shores Gun Shop
		coords = vector4(1690.9809, 3759.6606, 34.705314, 224.21914),
		minusOne = true,
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'mp_m_weapexp_01', --Highway Gun Shop
		coords = vector4(2569.4641, 292.55212, 108.73486, 359.25399),
		minusOne = true,
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'mp_m_weapexp_01', --Fort Zancudo Gun Shop
		coords = vector4(-1120.53, 2698.4394, 18.554132, 218.82119),
		minusOne = true,
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'mp_m_weapexp_01', --Paleto Gun Shop
		coords = vector4(-333.0049, 6083.541, 31.454771, 222.31753),
		minusOne = true,
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'mp_m_weapexp_01', --Docs Gun Shop
		coords = vector4(812.16577, -2159.065, 29.618995, 358.28662),
		minusOne = true,
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'mp_m_weapexp_01', --Vespucci Gun Shop
		coords = vector4(-664.3577, -933.613, 21.829227, 172.89535),
		minusOne = true,
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'mp_m_weapexp_01', --Hollywood BLVD Gun Shop
		coords = vector4(254.58493, -48.65179, 69.94107, 63.874408),
		minusOne = true,
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'mp_m_weapexp_01', --Customs Gun Shop
		coords = vector4(844.18353, -1035.25, 28.194875, 355.79147),
		minusOne = true,
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'ig_natalia', --Clothing Store
		coords = vector4(126.81866, -224.481, 54.557876, 43.55),
		minusOne = true,
		gender = 'female',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'ig_natalia', --Clothing Store
		coords = vector4(1695.3248, 4822.7597, 42.063121, 93.486259),
		minusOne = true,
		gender = 'female',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'ig_natalia', --Clothing Store
		coords = vector4(-708.3459, -152.6694, 37.415138, 120.29331),
		minusOne = true,
		gender = 'female',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'ig_natalia', --Clothing Store
		coords = vector4(-1193.521, -766.6292, 17.31619, 220.57485),
		minusOne = true,
		gender = 'female',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'ig_natalia', --Clothing Store
		coords = vector4(426.97964, -806.2895, 29.491134, 75.735084),
		minusOne = true,
		gender = 'female',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'ig_natalia', --Clothing Store
		coords = vector4(-164.5845, -301.8706, 39.73328, 247.0805),
		minusOne = true,
		gender = 'female',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'ig_natalia', --Clothing Store
		coords = vector4(73.879905, -1392.769, 29.376127, 267.37158),
		minusOne = true,
		gender = 'female',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'ig_natalia', --Clothing Store
		coords = vector4(-823.0946, -1072.307, 11.328111, 207.29679),
		minusOne = true,
		gender = 'female',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'ig_natalia', --Clothing Store
		coords = vector4(-1449.831, -239.087, 49.81343, 46.488571),
		minusOne = true,
		gender = 'female',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'ig_natalia', --Clothing Store
		coords = vector4(5.9474482, 6511.5493, 31.877832, 45.196197),
		minusOne = true,
		gender = 'female',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'ig_natalia', --Clothing Store
		coords = vector4(612.93811, 2763.518, 42.088096, 270.58392),
		minusOne = true,
		gender = 'female',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'ig_natalia', --Clothing Store
		coords = vector4(1196.3917, 2711.7517, 38.222599, 187.36061),
		minusOne = true,
		gender = 'female',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'ig_natalia', --Clothing Store
		coords = vector4(-3169.847, 1042.3283, 20.863212, 69.715866),
		minusOne = true,
		gender = 'female',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'ig_natalia', --Clothing Store
		coords = vector4(-1102.764, 2711.4003, 19.107849, 228.95544),
		minusOne = true,
		gender = 'female',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'ig_abigail', --Barber Store
		coords = vector4(-34.33749, -154.8674, 57.076499, 330.72451),
		minusOne = true,
		gender = 'female',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'ig_abigail', --Barber Store
		coords = vector4(138.96305, -1706.471, 29.291603, 124.34352),
		minusOne = true,
		gender = 'female',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'ig_abigail', --Barber Store
		coords = vector4(-811.8323, -182.6813, 37.568893, 112.64623),
		minusOne = true,
		gender = 'female',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'ig_abigail', --Barber Store
		coords = vector4(-1280.352, -1117.75, 6.9901123, 81.010848),
		minusOne = true,
		gender = 'female',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'ig_abigail', --Barber Store
		coords = vector4(1930.5108, 3732.354, 32.844425, 225.05581),
		minusOne = true,
		gender = 'female',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'ig_abigail', --Barber Store
		coords = vector4(1214.5328, -473.5645, 66.208007, 71.92884),
		minusOne = true,
		gender = 'female',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'ig_abigail', --Barber Store
		coords = vector4(-276.492, 6226.0131, 31.695514, 41.618957),
		minusOne = true,
		gender = 'female',
		freeze = true,
		invincible = true,
		blockevents = true,
	},

	--banks
	{
		model = 'cs_debra', --Bank Legion
		coords = vector4(149.39093, -1042.056, 29.367971, 339.11575),
		minusOne = true,
		gender = 'female',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'cs_debra', --Bank Hawick
		coords = vector4(-351.4513, -51.20806, 49.036525, 342.13818),
		minusOne = true,
		gender = 'female',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'cs_debra', --Bank Motel
		coords = vector4(313.68399, -280.4945, 54.164722, 339.74996),
		minusOne = true,
		gender = 'female',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'cs_debra', --Bank Del Perro
		coords = vector4(-1212.021, -331.9804, 37.780918, 29.807104),
		minusOne = true,
		gender = 'female',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'cs_debra', --Bank Ocean Highway
		coords = vector4(-2961.172, 482.87591, 15.697013, 86.071189),
		minusOne = true,
		gender = 'female',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'cs_debra', --Bank Route 68
		coords = vector4(1175.0444, 2708.217, 38.087978, 177.21842),
		minusOne = true,
		gender = 'female',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'cs_debra', --Bank Pacific
		coords = vector4(242.99472, 226.484, 106.28744, 159.78074),
		minusOne = true,
		gender = 'female',
		freeze = true,
		invincible = true,
		blockevents = true,
	},
	{
		model = 'cs_debra', --Bank Paleto
		coords = vector4(-112.2003, 6471.0883, 31.626707, 134.76998),
		minusOne = true,
		gender = 'female',
		freeze = true,
		invincible = true,
		blockevents = true,
	},

	--cityhall
	{
		model = 'cs_mrsphillips', 
		coords = vector4(-553.5645, -189.2685, 38.219665, 207.36166),
		minusOne = true,
		gender = 'female',
		freeze = true,
		invincible = true,
		blockevents = true,
	},

	{
		model = 'csb_prolsec', --PD Heli
		coords = vector4(458.7778, -981.1287, 43.691616, 95.563278),
		minusOne = true,
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},

	{
		model = 's_m_m_doctor_01', --EMS Garage
		coords = vector4(338.19146, -576.7095, 28.796859, 79.916084),
		minusOne = true,
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},

	{
		model = 's_m_m_pilot_02', --EMS Heli
		coords = vector4(341.11004, -589.7984, 74.161712, 251.72952),
		minusOne = true,
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},

	{
		model = 'ig_karen_daniels', --Prison Check
		coords = vector4(1714.3057, 2524.4318, 45.56488, 210.56455),
		minusOne = true,
		gender = 'female',
		freeze = true,
		invincible = true,
		blockevents = true,
	},

	{
		model = 'cs_paper', --Insurance Open
		coords = vector4(462.77111, -566.0045, 28.525495, 173.46708),
		minusOne = true,
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},

	{
		model = 'csb_ramp_hic', --Insurance Open
		coords = vector4(-1038.2, -1397.039, 5.5531916, 75.735977),
		minusOne = true,
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
	},

}

-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------

if Config.EnableDefaultOptions then
	Config.ToggleDoor = function(vehicle, door)
		if GetVehicleDoorLockStatus(vehicle) ~= 2 then
			if GetVehicleDoorAngleRatio(vehicle, door) > 0.0 then
				SetVehicleDoorShut(vehicle, door, false)
			else
				SetVehicleDoorOpen(vehicle, door, false)
			end
		end
	end
end

-------------------------------------------------------------------------------
-- Default options
-------------------------------------------------------------------------------

if Config.EnableDefaultOptions then
	Bones['seat_dside_f'] = {
		options = {
			{
				icon = "fas fa-door-open",
				label = "Toggle front Door",
				canInteract = function(entity)
					return GetEntityBoneIndexByName(entity, 'door_dside_f') ~= -1
				end,
				action = function(entity)
					Config.ToggleDoor(entity, 0)
				end
			},
		},
		distance = 1.2
	}

	Bones['seat_pside_f'] = {
		options = {
			{
				icon = "fas fa-door-open",
				label = "Toggle front Door",
				canInteract = function(entity)
					return GetEntityBoneIndexByName(entity, 'door_pside_f') ~= -1
				end,
				action = function(entity)
					Config.ToggleDoor(entity, 1)
				end
			},
		},
		distance = 1.2
	}

	Bones['seat_dside_r'] = {
		options = {
			{
				icon = "fas fa-door-open",
				label = "Toggle rear Door",
				canInteract = function(entity)
					return GetEntityBoneIndexByName(entity, 'door_dside_r') ~= -1
				end,
				action = function(entity)
					Config.ToggleDoor(entity, 2)
				end
			},
		},
		distance = 1.2
	}

	Bones['seat_pside_r'] = {
		options = {
			{
				icon = "fas fa-door-open",
				label = "Toggle rear Door",
				canInteract = function(entity)
					return GetEntityBoneIndexByName(entity, 'door_pside_r') ~= -1
				end,
				action = function(entity)
					Config.ToggleDoor(entity, 3)
				end
			},
		},
		distance = 1.2
	}

	Bones['bonnet'] = {
		options = {
			{
				icon = "fa-duotone fa-engine",
				label = "Toggle Hood",
				action = function(entity)
					Config.ToggleDoor(entity, 4)
				end
			},
		},
		distance = 0.9
	}
end

-------------------------------------------------------------------------------
return Config, Players, Types, Entities, Models, Zones, Bones, PlayerData
-------------------------------------------------------------------------------
