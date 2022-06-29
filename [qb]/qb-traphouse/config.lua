Config = Config or {}

-- **** IMPORTANT ****
-- UseTarget should only be set to true when using qb-target
Config.UseTarget = GetConvar('UseTarget', 'false') == 'true'

Config.MinZOffset = 40
Config.TakeoverPrice = 5000
Config.TrapHouses = {
    [1] = {
        coords = {
            ["enter"] = vector3(621.66, -204.28, 54.47),
            ["interaction"] = vector3(-1207.63, -1311.75, -32.65),
        },
        polyzoneBoxData = {
            ["enter"] = {
                heading = 290,
                minZ = 4.0,
                maxZ = 6.0,
                debug = false,
                length = 1,
                width = 1,
                distance = 2.0,
                created = false
            },
            ["interaction"] = {
                heading = 180,
                debug = false,
                length = 1,
                width = 1,
                distance = 1.0,
                created = false
            },
            ["exit"] = {
                heading = 180,
                debug = false,
                length = 1,
                width = 1,
                distance = 1.0,
                created = false
            }
        },
        keyholders = {},
        pincode = 1234,
        inventory = {},
        opened = false,
        takingover = false,
        money = 0,
    }
}

Config.AllowedItems = {
    ["metalscrap"] = {
        name = "metalscrap",
        wait = 500,
        reward = 3,
    },
    ["copper"] = {
        name = "copper",
        wait = 500,
        reward = 2,
    },
    ["iron"] = {
        name = "iron",
        wait = 500,
        reward = 2,
    },
    ["aluminum"] = {
        name = "aluminum",
        wait = 500,
        reward = 2,
    },
    ["steel"] = {
        name = "steel",
        wait = 500,
        reward = 2,
    },
    ["glass"] = {
        name = "glass",
        wait = 500,
        reward = 2,
    },
    ["lockpick"] = {
        name = "lockpick",
        wait = 10000,
        reward = 150,
    },
    ["screwdriverset"] = {
        name = "screwdriverset",
        wait = 10000,
        reward = 300,
    },
    ["electronickit"] = {
        name = "electronickit",
        wait = 10000,
        reward = 300,
    },
    ["radioscanner"] = {
        name = "radioscanner",
        wait = 10000,
        reward = 850,
    },
    ["gatecrack"] = {
        name = "gatecrack",
        wait = 10000,
        reward = 600,
    },
    ["trojan_usb"] = {
        name = "trojan_usb",
        wait = 10000,
        reward = 1000,
    },
    ["weed_brick"] = {
        name = "weed_brick",
        wait = 5000,
        reward = 250,
    },
    ["phone"] = {
        name = "phone",
        wait = 2000,
        reward = 100,
    },
    ["radio"] = {
        name = "radio",
        wait = 2000,
        reward = 100,
    },
    ["handcuffs"] = {
        name = "handcuffs",
        wait = 2000,
        reward = 400,
    },
    ["goldbar"] = {
        name = "goldbar",
        wait = 10000,
        reward = 7000,
    },
    ["rolex"] = {
        name = "rolex",
        wait = 10000,
        reward = 2500,
    },
    ["10kgoldchain"] = {
        name = "10kgoldchain",
        wait = 10000,
        reward = 1500,
    },
    ["diamond_ring"] = {
        name = "diamond_ring",
        wait = 10000,
        reward = 4500,
    },
    ["goldchain"] = {
        name = "goldchain",
        wait = 10000,
        reward = 750,
    },
    ["diamond"] = {
        name = "5ctdiamond",
        wait = 10000,
        reward = 50000,
    },
}
