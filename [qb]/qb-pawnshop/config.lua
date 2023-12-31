Config = {}

Config.PawnLocation = {
    coords = vector3(1137.57, -470.8, 66.66),
    length = 1.5,
    width = 1.8,
    heading = 1.81,
    debugPoly = false,
    minZ = 65.66,
    maxZ = 67.66,
    distance = 2.0
}

Config.BankMoney = false -- Set to true if you want the money to go into the players bank
Config.UseTimes = false -- Set to false if you want the pawnshop open 24/7
Config.TimeOpen = 7 -- Opening Time
Config.TimeClosed = 17 -- Closing Time
Config.SendMeltingEmail = true

Config.UseTarget = GetConvar('UseTarget', 'false') == 'true'

Config.PawnItems = {
    [1] = {
        item = 'goldchain',
        price = math.random(275,375)
    },
    
    [2] = {
        item = 'diamond_ring',
        price = math.random(1750,2250)
    },
    [3] = {
        item = 'rolex',
        price = math.random(1000,1250)
    },
    [4] = {
        item = '10kgoldchain',
        price = math.random(550,850)
    },
    [5] = {
        item = 'tablet',
        price = math.random(50,100)
    },
    [6] = {
        item = 'iphone',
        price = math.random(50,100)
    },
    [7] = {
        item = 'samsungphone',
        price = math.random(50,100)
    },
    [8] = {
        item = 'laptop',
        price = math.random(50,100)
    },
    [9] = {
        item = 'goldbar',
        price = math.random(2500,3500)
    },
    [10] = {
        item = 'diamond',
        price = math.random(1250,2750)
    },
}

Config.MeltingItems = { -- meltTime is amount of time in minutes per item
    [2] = {
        item = 'diamond_ring',
        rewards = {
            [1] = {
                item = 'diamond',
                amount = 1
            },
        },
        meltTime = 0.15
    },
    [3] = {
        item = 'rolex',
        rewards = {
            [1] = {
                item = 'goldchain',
                amount = 4
            },
        },
        meltTime = 0.15
    },
    [4] = {
        item = '10kgoldchain',
        rewards = {
            [1] = {
                item = 'goldchain',
                amount = 3
            },
        },
        meltTime = 0.15
    },
}
