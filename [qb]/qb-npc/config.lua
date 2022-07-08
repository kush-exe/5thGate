-- Leaked By: Leaking Hub | J. Snow | leakinghub.com
Config = {}

Config.Key = 38 -- [E] Key to open the interaction, check here the keys ID: https://docs.fivem.net/docs/game-references/controls/#controls

Config.AutoCamPosition = true -- If true it'll set the camera position automatically

Config.AutoCamRotation = true -- If true it'll set the camera rotation automatically

Config.HideMinimap = true -- If true it'll hide the minimap when interacting with an NPC

Config.UseOkokTextUI = true -- If true it'll use okokTextUI 

Config.CameraAnimationTime = 1000 -- Camera animation time: 1000 = 1 second

Config.TalkToNPC = {
	--[[
	{
		npc = 'u_m_y_abner', 										-- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
		header = 'Employee of the', 								-- Text over the name
		name = 'Pacific Bank', 										-- Text under the header
		uiText = "Pacific Bank's Employee",							-- Name shown on the notification when near the NPC
		dialog = 'Hey, how can I help you?',						-- Text showm on the message bubble 
		coordinates = vector3(254.17, 222.8, 105.3), 				-- coordinates of NPC
		heading = 160.0,											-- Heading of NPC (needs decimals, 0.0 for example)
		camOffset = vector3(0.0, 0.0, 0.0), 						-- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
		camRotation = vector3(0.0, 0.0, 0.0),						-- Camera rotation 					| (only works if Config.AutoCamRotation = false)
		interactionRange = 2.5, 									-- From how far the player can interact with the NPC
		options = {													-- Options shown when interacting (Maximum 6 options per NPC)
			{'Where is the toilet?', 'okokTalk:toilet', 'c'},		-- 'c' for client
			{'How can I rob the bank?', 'okokTalk:rob', 'c'},		-- 's' for server (if you write something else it'll be server by default)
			{"I want to access my safe.", 'okokTalk:safe', 'c'}, 
			{"I want to make a new credit card.", 'okokTalk:card', 'c'}, 
			{"I lost my credit card.", 'okokTalk:lost', 'c'}, 
			{"Is Jennifer working?", 'okokTalk:jennifer', 'c'}, 
		},
		jobs = {													-- Jobs that can interact with the NPC
			
		},
	},--]]

	{
		npc = "u_m_y_smugmech_01", -- legion
		header = "Redline Performance",
		name = "Redline Mechanic",
		uiText = "Roberto",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(-588.94, -930.6, 23.89-1),
		heading = 97.74,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Call a mechanic", 'qb-smallresources:client:sendJobNotiMech', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},

	{
		npc = "u_f_o_moviestar",
		header = "Pillbox Hospital",
		name = "Nancy",
		uiText = "Pillbox Secretary",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(308.44, -595.31, 42.28),
		heading = 72.77,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		options = {
			{"Check in", 'qb-ambulancejob:checkin', 'c'},
			{"Call Doctor", 'hospital:server:SendDoctorAlert', 's'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "u_f_o_moviestar",
		header = "Pillbox Hospital",
		name = "Nancy",
		uiText = "Pillbox Secretary",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(308.44, -595.31, 42.28),
		heading = 72.77,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		options = {
			{"Check in", 'qb-ambulancejob:checkin', 'c'},
			{"Call Doctor", 'hospital:server:SendDoctorAlert', 's'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "a_m_y_acult_01",
		header = "Antoine Johnson",
		name = "Antoine",
		uiText = "Antoine",
		dialog = "What you want?",
		coordinates = vector3(-486.27, 291.45, 83.8-1),
		heading = 68.77,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		options = {
			{"Speak with Antoine", 'qb-drugs:client:dealer', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	--[[
	{
		npc = "mp_m_shopkeep_01", --grove
		header = "24/7 Supermarket",
		name = "Ock",
		uiText = "Habibi",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(-47.165, -1758.707, 29.421-0.95),
		heading = 48.975,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		options = {
			{"Purchase Items", 'qb-shops:client:shop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "mp_m_shopkeep_01", -- shop forum
		header = "24/7 Supermarket",
		name = "Ock",
		uiText = "Habibi",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(24.502,  -1345.626, 29.497-0.95),
		heading = 265.975,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		options = {
			{"Purchase Items", 'qb-shops:client:shop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "mp_m_shopkeep_01", -- shop lil seul
		header = "24/7 Supermarket",
		name = "Ock",
		uiText = "Habibi",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(-706.017, -914.453, 19.216-0.95),
		heading = 87.975,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		options = {
			{"Purchase Items", 'qb-shops:client:shop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "mp_m_shopkeep_01", -- shop vinewood
		header = "24/7 Supermarket",
		name = "Ock",
		uiText = "Habibi",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(372.951, 328.117, 103.566-0.95),
		heading = 249.975,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		options = {
			{"Purchase Items", 'qb-shops:client:shop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "mp_m_shopkeep_01", --shop paleto
		header = "24/7 Supermarket",
		name = "Ock",
		uiText = "Habibi",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(160.69648, 6641.7963, 30.698944),
		heading = 222.25,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		options = {
			{"Purchase Items", 'qb-shops:client:shop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "mp_m_shopkeep_01", --shop insenso rd west
		header = "24/7 Supermarket",
		name = "Ock",
		uiText = "Habibi",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(-3040.612, 584.042, 7.909-0.95),
		heading = 15.9725,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		options = {
			{"Purchase Items", 'qb-shops:client:shop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "mp_m_shopkeep_01", --shop insenso rd east
		header = "24/7 Supermarket",
		name = "Ock",
		uiText = "Habibi",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(-3243.932, 1000.088, 12.831-0.95),
		heading = 350.975,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		options = {
			{"Purchase Items", 'qb-shops:client:shop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "mp_m_shopkeep_01", --shop mirror park ltd east
		header = "24/7 Supermarket",
		name = "Ock",
		uiText = "Habibi",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(1164.836, -323.648,  69.205-0.95),
		heading = 98.975,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		options = {
			{"Purchase Items", 'qb-shops:client:shop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "mp_m_shopkeep_01", --shop north rockford ltd
		header = "24/7 Supermarket",
		name = "Ock",
		uiText = "Habibi",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(-1819.544, 793.518, 138.086-0.95),
		heading = 131.975,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		options = {
			{"Purchase Items", 'qb-shops:client:shop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "mp_m_shopkeep_01", --shop keeper sandy
		header = "24/7 Supermarket",
		name = "Ock",
		uiText = "Habibi",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(549.328, 2669.604, 42.156-0.95),
		heading = 91.975,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		options = {
			{"Purchase Items", 'qb-shops:client:shop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "mp_m_shopkeep_01", --shop keeper sandy 2
		header = "24/7 Supermarket",
		name = "Ock",
		uiText = "Habibi",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(1959.253, 3741.500, 32.344-0.95),
		heading = 295.975,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		options = {
			{"Purchase Items", 'qb-shops:client:shop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "mp_m_shopkeep_01", --shop keeper grapeseed LTD
		header = "24/7 Supermarket",
		name = "Ock",
		uiText = "Habibi",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(1697.254, 4923.475, 42.064-0.95),
		heading = 318.975,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		options = {
			{"Purchase Items", 'qb-shops:client:shop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "mp_m_shopkeep_01", --shop keeper north north LTD
		header = "24/7 Supermarket",
		name = "Ock",
		uiText = "Habibi",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(1728.529, 6416.731, 35.037-0.95),
		heading = 242.975,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		options = {
			{"Purchase Items", 'qb-shops:client:shop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "mp_m_shopkeep_01", --shop keeper Licquor Insenso Road 3 (west)
		header = "24/7 Supermarket",
		name = "Ock",
		uiText = "Habibi",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(-2966.325, 391.624, 15.043-0.95),
		heading = 95.975,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		options = {
			{"Purchase Items", 'qb-shops:client:shop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "mp_m_shopkeep_01", --shop keeper  Licquor Prosperity st (west)
		header = "24/7 Supermarket",
		name = "Ock",
		uiText = "Habibi",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(-1486.590, -377.572, 40.163-0.95),
		heading = 132.975,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		options = {
			{"Purchase Items", 'qb-shops:client:shop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "mp_m_shopkeep_01", --shop keeper  Licquor Prosperity st (west)
		header = "24/7 Supermarket",
		name = "Ock",
		uiText = "Habibi",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(-1221.438, -908.001, 12.326-0.95),
		heading = 25.975,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		options = {
			{"Purchase Items", 'qb-shops:client:shop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "mp_m_shopkeep_01", --shop keeper   liquor vespucci blvd
		header = "24/7 Supermarket",
		name = "Ock",
		uiText = "Habibi",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(1134.218, -983.201,  46.416-0.95),
		heading = 276.975,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		options = {
			{"Purchase Items", 'qb-shops:client:shop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "mp_m_shopkeep_01", --shop keeper  sandy east
		header = "24/7 Supermarket",
		name = "Ock",
		uiText = "Habibi",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(1165.302, 2710.887, 38.158-0.95),
		heading = 174.975,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		options = {
			{"Purchase Items", 'qb-shops:client:shop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "mp_m_shopkeep_01", --shop keeper Paleto east
		header = "24/7 Supermarket",
		name = "Ock",
		uiText = "Habibi",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(-160.761, 6320.935, 31.587-0.95),
		heading = 308.975,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		options = {
			{"Purchase Items", 'qb-shops:client:shop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},--]]
	{
		npc = "s_m_m_lathandy_01", --shop keeper HARDWARE strawberry
		header = "Hardware Store",
		name = "Braxton",
		uiText = "Braxton",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(46.59, -1749.39, 28.64),
		heading = 46.24,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		options = {
			{"Purchase Items", 'qb-shops:client:shop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "s_m_m_lathandy_01", --shop keeper HARDWARE SANDY
		header = "Hardware Store",
		name = "Braxton",
		uiText = "Braxton",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(2747.91, 3472.8, 54.67),
		heading = 253.24,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		options = {
			{"Purchase Items", 'qb-shops:client:shop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "s_m_m_lathandy_01", --shop keeper HARDWARE Paleto
		header = "Hardware Store",
		name = "Braxton",
		uiText = "Braxton",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(-421.55, 6136.7, 30.88),
		heading = 177.24,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		options = {
			{"Purchase Items", 'qb-shops:client:shop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	--[[
	{
		npc = "cs_wade", --shop keeper WEED STORE
		header = "Smoke On the Water",
		name = "",
		uiText = "Wade",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(-1170.99, -1571.262, 3.6636285),
		heading = 133.92,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Purchase Items", 'qb-shops:client:shop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
--]]

	--banks


	{
		npc = "cs_debra", --Bank Legion
		header = "Fleeca Bank",
		name = "Teller",
		uiText = "Debra",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(149.39093, -1042.056, 28.367971),
		heading = 339.115,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Access your account", 'qb-banking:openBankScreen', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "cs_debra", --Bank Hawick
		header = "Fleeca Bank",
		name = "Teller",
		uiText = "Debra",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(-351.4513, -51.20806, 48.036525),
		heading = 342.115,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Access your account", 'qb-banking:openBankScreen', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "cs_debra", --Bank Motel
		header = "Fleeca Bank",
		name = "Teller",
		uiText = "Debra",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(313.68399, -280.4945, 53.164722),
		heading = 342.115,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Access your account", 'qb-banking:openBankScreen', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "cs_debra", --Bank del perro
		header = "Fleeca Bank",
		name = "Teller",
		uiText = "Debra",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(-1212.021, -331.9804, 36.7809182),
		heading = 29.115,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Access your account", 'qb-banking:openBankScreen', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "cs_debra", --Bankocean highway
		header = "Fleeca Bank",
		name = "Teller",
		uiText = "Debra",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(-2961.172, 482.87591, 14.697013),
		heading = 86.115,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Access your account", 'qb-banking:openBankScreen', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "cs_debra", --Bank r68
		header = "Fleeca Bank",
		name = "Teller",
		uiText = "Debra",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(1175.0444, 2708.217, 37.087978),
		heading = 177.115,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Access your account", 'qb-banking:openBankScreen', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "cs_debra", --Bank pacific
		header = "Fleeca Bank",
		name = "Teller",
		uiText = "Debra",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(242.99472, 226.484, 105.28744),
		heading = 159.7,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Access your account", 'qb-banking:openBankScreen', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "cs_debra", --Bank paleto
		header = "Fleeca Bank",
		name = "Teller",
		uiText = "Debra",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(-112.2003, 6471.0883, 30.626707),
		heading = 134.7,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Access your account", 'qb-banking:openBankScreen', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},

	-- clothing stores
--[[
	{
		npc = "ig_miguelmadrazo", --Bank paleto
		header = "Clothing Shop",
		name = "Miguel",
		uiText = "clothing store employee",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(427.0880, -805.900, 28.491),
		heading = 94.49,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Change clothes", 'qb-clothes:clothingShop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "ig_miguelmadrazo", --Bank paleto
		header = "Clothing Shop",
		name = "Miguel",
		uiText = "clothing store employee",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(73.86779, -1392.99, 28.376),
		heading = 274.8,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Change clothes", 'qb-clothes:clothingShop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "ig_miguelmadrazo", --Bank paleto
		header = "Clothing Shop",
		name = "Miguel",
		uiText = "clothing store employee",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(126.6333, -225.045, 53.557),
		heading = 24.14,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Change clothes", 'qb-clothes:clothingShop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "ig_miguelmadrazo", --Bank paleto
		header = "Clothing Shop",
		name = "Miguel",
		uiText = "clothing store employee",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(-164.627, -301.921, 38.733),
		heading = 249.9,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Change clothes", 'qb-clothes:clothingShop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "ig_miguelmadrazo", --Bank paleto
		header = "Clothing Shop",
		name = "Miguel",
		uiText = "clothing store employee",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(-708.208, -152.955, 36.415),
		heading = 116.1,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Change clothes", 'qb-clothes:clothingShop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "ig_miguelmadrazo", --Bank paleto
		header = "Clothing Shop",
		name = "Miguel",
		uiText = "clothing store employee",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(-1449.71, -238.977, 48.813),
		heading = 49.51,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Change clothes", 'qb-clothes:clothingShop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "ig_miguelmadrazo", --Bank paleto
		header = "Clothing Shop",
		name = "Miguel",
		uiText = "clothing store employee",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(-1193.21, -766.425, 16.316),
		heading = 219.9,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Change clothes", 'qb-clothes:clothingShop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "ig_miguelmadrazo", --Bank paleto
		header = "Clothing Shop",
		name = "Miguel",
		uiText = "clothing store employee",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(-823.166, -1072.28, 10.328),
		heading = 221.9,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Change clothes", 'qb-clothes:clothingShop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "ig_miguelmadrazo", --Bank paleto
		header = "Clothing Shop",
		name = "Miguel",
		uiText = "clothing store employee",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(-1206.36, -1457.99, 3.3487),
		heading = 36.69,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Change clothes", 'qb-clothes:clothingShop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "ig_miguelmadrazo", --Bank paleto
		header = "Clothing Shop",
		name = "Miguel",
		uiText = "clothing store employee",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(-3169.77, 1042.293, 19.863),
		heading = 61.47,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Change clothes", 'qb-clothes:clothingShop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "ig_miguelmadrazo", --Bank paleto
		header = "Clothing Shop",
		name = "Miguel",
		uiText = "clothing store employee",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(612.9566, 2763.617, 41.088),
		heading = 274.47,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Change clothes", 'qb-clothes:clothingShop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "ig_miguelmadrazo", --Bank paleto
		header = "Clothing Shop",
		name = "Miguel",
		uiText = "clothing store employee",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(1196.610, 2711.712, 37.222),
		heading = 178.47,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Change clothes", 'qb-clothes:clothingShop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "ig_miguelmadrazo", --Bank paleto
		header = "Clothing Shop",
		name = "Miguel",
		uiText = "clothing store employee",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(1695.368, 4823.105, 41.063),
		heading = 99.91,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Change clothes", 'qb-clothes:clothingShop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "ig_miguelmadrazo", --Bank paleto
		header = "Clothing Shop",
		name = "Miguel",
		uiText = "clothing store employee",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(5.868691, 6511.372, 30.877),
		heading = 42.43,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Change clothes", 'qb-clothes:clothingShop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "ig_miguelmadrazo", --Bank paleto
		header = "Clothing Shop",
		name = "Miguel",
		uiText = "clothing store employee",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(4495.485, -4452.16, 3.3664),
		heading = 209.2,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Change clothes", 'qb-clothes:clothingShop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "ig_miguelmadrazo", --Bank paleto
		header = "Clothing Shop",
		name = "Miguel",
		uiText = "clothing store employee",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(-1102.50, 2711.632, 18.107),
		heading = 220.8,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Change clothes", 'qb-clothes:clothingShop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	--BARBERS
	{
		npc = "ig_miguelmadrazo", --Bank paleto
		header = "Clothing Shop",
		name = "Miguel",
		uiText = "clothing store employee",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(922.7774, 21.39071, 70.833),
		heading = 287.8,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Change clothes", 'qb-clothes:clothingShop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "s_f_y_clubbar_02", --Bank paleto
		header = "Barber Shop",
		name = "Barbara",
		uiText = "Barber",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(136.8038, -1708.44, 28.291),
		heading = 137.8,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Change Appearance", 'qb-clothing:client:openMenu', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "s_f_y_clubbar_02", --Bank paleto
		header = "Barber Shop",
		name = "Barbara",
		uiText = "Barber",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(-1282.60, -1116.80, 5.9938),
		heading = 138.6,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Change Appearance", 'qb-clothing:client:openMenu', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "s_f_y_clubbar_02", --Bank paleto
		header = "Barber Shop",
		name = "Barbara",
		uiText = "Barber",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(1931.613, 3729.659, 31.844),
		heading = 220.3,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Change Appearance", 'qb-clothing:client:openMenu', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "s_f_y_clubbar_02", --Bank paleto
		header = "Barber Shop",
		name = "Barbara",
		uiText = "Barber",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(1212.713, -472.972, 65.207),
		heading = 78.45,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Change Appearance", 'qb-clothing:client:openMenu', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "s_f_y_clubbar_02", --Bank paleto
		header = "Barber Shop",
		name = "Barbara",
		uiText = "Barber",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(-32.9359, -152.341, 56.076),
		heading = 340.45,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Change Appearance", 'qb-clothing:client:openMenu', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "s_f_y_clubbar_02", --Bank paleto
		header = "Barber Shop",
		name = "Barbara",
		uiText = "Barber",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(-278.205, 6228.501, 30.695),
		heading = 52.45,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Change Appearance", 'qb-clothing:client:openMenu', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "s_f_y_clubbar_02", --Bank paleto
		header = "Barber Shop",
		name = "Barbara",
		uiText = "Barber",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(-814.235, -183.812, 36.568),
		heading = 129.45,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Change Appearance", 'qb-clothing:client:openMenu', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "s_f_y_clubbar_02", --Bank paleto
		header = "Barber Shop",
		name = "Barbara",
		uiText = "Barber",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(197.3, -872.04, 29.71),
		heading = 205.45,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Change Appearance", 'qb-clothing:client:openMenu', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "s_f_y_clubbar_02", --Bank paleto
		header = "Barber Shop",
		name = "Barbara",
		uiText = "Barber",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(2514.77, -343.56, 101.89),
		heading = 47.99,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Change Appearance", 'qb-clothing:client:openMenu', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
--]]
	--weapon store
	{
		npc = "mp_m_weapexp_01", -- legion
		header = "Gun Shop",
		name = "Cleetus",
		uiText = "ammunation employee",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(22.7, -1105.44, 29.8-1),
		heading = 168.99,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Purchase Items", 'qb-shops:client:shop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	--[[
	{
		npc = "mp_m_weapexp_01", --Bank paleto
		header = "Gun Shop",
		name = "Cleetus",
		uiText = "ammunation employee",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(1690.9809, 3759.6606, 33.705314),
		heading = 224.99,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Purchase Items", 'qb-shops:client:shop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},

	{
		npc = "mp_m_weapexp_01", --557
		header = "Gun Shop",
		name = "Cleetus",
		uiText = "ammunation employee",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(2569.4641, 292.55212, 107.73486),
		heading = 359.99,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Purchase Items", 'qb-shops:client:shop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},

	{
		npc = "mp_m_weapexp_01", --route 68
		header = "Gun Shop",
		name = "Cleetus",
		uiText = "ammunation employee",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(-1120.53, 2698.4394, 17.554132),
		heading = 218.99,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Purchase Items", 'qb-shops:client:shop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "mp_m_weapexp_01", --Bank paleto
		header = "Gun Shop",
		name = "Cleetus",
		uiText = "ammunation employee",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(-333.0049, 6083.541, 30.454771),
		heading = 222.99,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Purchase Items", 'qb-shops:client:shop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "mp_m_weapexp_01", --807
		header = "Gun Shop",
		name = "Cleetus",
		uiText = "ammunation employee",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(813.88, -2155.65, 29.62),
		heading = 358.28,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Purchase Items", 'qb-shops:client:shop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "mp_m_weapexp_01", --726
		header = "Gun Shop",
		name = "Cleetus",
		uiText = "ammunation employee",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(-664.3577, -933.613, 20.829227),
		heading = 172.28,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Purchase Items", 'qb-shops:client:shop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "mp_m_weapexp_01", --608
		header = "Gun Shop",
		name = "Cleetus",
		uiText = "ammunation employee",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(254.58493, -48.65179, 68.94107),
		heading = 63.28,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Purchase Items", 'qb-shops:client:shop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	{
		npc = "mp_m_weapexp_01", -- 769
		header = "Gun Shop",
		name = "Cleetus",
		uiText = "ammunation employee",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(844.18353, -1035.25, 27.194875),
		heading = 355.28,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Purchase Items", 'qb-shops:client:shop', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
	--cityhall
	{
		npc = "cs_mrsphillips", -- 769
		header = "City Hall",
		name = "Janice",
		uiText = "Janice",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(-550.08, -191.06, 38.23-0.95),
		heading = 207.361,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Open City Hall", 'qb-cityhall:client:open', 'c'},
		},
		jobs = {	-- Example jobs
		},
	},
--[[
	{
		npc = "csb_burgerdrug", -- burgershot
		header = "BurgerShot Garage",
		name = "Wayne",
		uiText = "Wayne",
		dialog = "Hello, how may I help you?",
		coordinates = vector3(-1177.75, -891.41, 12.77),
		heading = 302.5,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 3,
		options = {
			{"Open Garage", 'garage:BurgerShotGarage', 'c'},
		},
		jobs = {	-- Example jobs
			"burgershot"
		},
	},
--]]

	--[[
	-- This is the template to create new NPCs
	{
		npc = "",
		header = "",
		name = "",
		uiText = "",
		dialog = "",
		coordinates = vector3(0.0, 0.0, 0.0),
		heading = 0.0,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 0,
		options = {
			{"", 'client:event', 'c'},
			{"", 'client:event', 'c'},
			{"", 'client:event', 'c'}, 
			{"", 'server:event', 's'}, 
			{"", 'server:event', 's'}, 
			{"", 'server:event', 's'}, 
		},
		jobs = {	-- Example jobs
			'police',
			'ambulance',
		},
	},
	]]--
}