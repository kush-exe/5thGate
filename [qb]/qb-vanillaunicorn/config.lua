Config = Config or {}

Config.Locations = {
	['shop'] = { ['x'] = 135.21, ['y'] = -1286.14, ['z'] = 29.26, ['h'] = 208.43 },
	['claim'] = { ['x'] = 129.28, ['y'] = -1285.65, ['z'] = 29.0, ['h'] = 126.39421 },
	['vip'] = { ['x'] = 133.84, ['y'] = -1280.55, ['z'] = 29.26, ['h'] = 120.21 },
	['stripper'] = { ['x'] = 97.05, ['y'] = -1306.18, ['z'] = 29.29, ['h'] = 212.00  },
	['boss'] = { ['x'] = 200.22, ['y'] = -1297.73, ['z'] = 29.26, ['h'] = 290.99  },
}

Config['PoleDance'] = { -- allows you to pole dance at the strip club, you can of course add more locations if you want.
    ['Enabled'] = true,
    ['Locations'] = {
        {['Position'] = vector3(108.705, -1286.80, 28.45), ['Number'] = '1'},
    }
}

Strings = {
    ['Pole_Dance'] = '[~r~E~w~] Poledance',
}

Config.Strippers = {
    ['locations'] ={
        {
            ['taken'] = 0,
            ['model'] = nil,
            ['sit'] = vector4(110.55, -1287.95, 28.269432, 31.382211),
            ['stand'] = vector4(110.55, -1287.95, 28.45, 254.4),
        },
        {
            ['taken'] = 0,
            ['model'] = nil,
            ['sit'] = vector4(109.02, -1285.04, 28.273693, 32.705486),
            ['stand'] = vector4(109.02, -1285.04, 28.45, 338.14),
        },
        {
            ['taken'] = 0,
            ['model'] = nil,
            ['sit'] = vector4(104.5, -1289.57, 28.85, 25.138725),
            ['stand'] = vector4(104.5, -1289.57, 28.85, 301.39),
        },
        {
            ['taken'] = 0,
            ['model'] = nil,
            ['sit'] = vector4(100.81, -1294.59, 29.25, 30.056648),
            ['stand'] = vector4(100.81, -1294.59, 29.25, 292.77),
        },
        {
            ['taken'] = 0,
            ['model'] = nil,
            ['sit'] = vector4(100.81, -1294.59, 29.25, 30.056648),
            ['stand'] = vector4(100.81, -1294.59, 29.25, 292.77),
        },
    },
    ['peds'] = {
       'csb_stripper_01', -- White Stripper
	   's_f_y_stripperlite', -- Black Stripper
       'mp_f_stripperlite', -- Black Stripper
    }
}

Config.Items = {
    label = "Vanilla Unicorn",
    slots = 1,
    items = {
        [1] = {
            name = "beer",
            price = 4,
            amount = 125,
            info = {},
            type = "item",
            slot = 1,
		},
        [2] = {
            name = "bloodymary",
            price = 4,
            amount = 125,
            info = {},
            type = "item",
            slot = 2,
        },
        [3] = {
            name = "dusche",
            price = 4,
            amount = 125,
            info = {},
            type = "item",
            slot = 3,
        },
        [4] = {
            name = "tequilashot",
            price = 4,
            amount = 125,
            info = {},
            type = "item",
            slot = 4,
        },
        [5] = {
            name = "pinacolada",
            price = 4,
            amount = 125,
            info = {},
            type = "item",
            slot = 5,
		},
        [6] = {
            name = "beer",
            price = 4,
            amount = 1251,
            info = {},
            type = "item",
            slot = 6,
        },
        [7] = {
            name = "whiskey",
            price = 4,
            amount = 125,
            info = {},
            type = "item",
            slot = 7,
        },
        [8] = {
            name = "vodka",
            price = 4,
            amount = 125,
            info = {},
            type = "item",
            slot = 8,
		},
        [9] = {
            name = "tequila",
            price = 4,
            amount = 125,
            info = {},
            type = "item",
            slot = 9,
		},
    }
}

Config.BossItems = {
    label = "Vanilla Unicorn VIP",
    slots = 1,
    items = {
        [1] = {
            name = "champagne",
            price = 1500,
            amount = 125,
            info = {},
            type = "item",
            slot = 1,	
		},
        [2] = {
            name = "whitewine",
            price = 1000,
            amount = 125,
            info = {},
            type = "item",
            slot = 2,	
		},
        [3] = {
            name = "glasschampagne",
            price = 0,
            amount = 125,
            info = {},
            type = "item",
            slot = 3,
        },
        [4] = {
            name = "glasswhiskey",
            price = 0,
            amount = 125,
            info = {},
            type = "item",
            slot = 4,
        },
        [5] = {
            name = "glasswine",
            price = 0,
            amount = 125,
            info = {},
            type = "item",
            slot = 5,
        }
    }
}