-- Zones for Menues
Config = Config or {}

Config.UseTarget = GetConvar('UseTarget', 'false') == 'true' -- Use qb-target interactions (don't change this, go to your server.cfg and add `setr UseTarget true` to use this and just that from true to false or the other way around)

Config.BossMenus = {
    ['police'] = {
        vector3(461.45, -986.2, 30.73),
    },
    ['ambulance'] = {
        vector3(335.46, -594.52, 43.28),
    },
    ['realestate'] = {
        vector3(-716.11, 261.21, 84.14),
    },
    ['taxi'] = {
        vector3(907.24, -150.19, 74.17),
    },
    ['cardealer'] = {
        vector3(-781.23, -206.88, 37.08),
    },
    ['mechanic'] = {
        vector3(837.75, -933.08, 32.39),
    },
    ['vanilla'] = {
        vector3(97.62, -1303.48, 29.26),
    },
    ['pizza'] = {
        vector3(292.42, -988.49, 29.43)
    },
}

Config.BossMenuZones = {
    ['police'] = {
        { coords = vector3(461.45, -986.2, 30.73), length = 0.35, width = 0.45, heading = 351.0, minZ = 30.58, maxZ = 30.68 } ,
    },
    ['ambulance'] = {
        { coords = vector3(335.46, -594.52, 43.28), length = 1.2, width = 0.6, heading = 341.0, minZ = 43.13, maxZ = 43.73 },
    },
    ['realestate'] = {
        { coords = vector3(-716.11, 261.21, 84.14), length = 0.6, width = 1.0, heading = 25.0, minZ = 83.943, maxZ = 84.74 },
    },
    ['taxi'] = {
        { coords = vector3(907.24, -150.19, 74.17), length = 1.0, width = 3.4, heading = 327.0, minZ = 73.17, maxZ = 74.57 },
    },
    ['cardealer'] = {
        { coords = vector3(-781.23, -206.88, 37.08), length = 2.4, width = 1.05, heading = 340.0, minZ = 24.07, maxZ = 25.67 },
    },
    ['mechanic'] = {
        { coords = vector3(837.75, -933.08, 32.39), length = 1.15, width = 2.6, heading = 353.0, minZ = 30.59, maxZ = 33.99 },
    },
    ['vanilla'] = {
        { coords = vector3(97.62, -1303.48, 29.26), length = 1.15, width = 2.6, heading = 353.0, minZ = 29.0-1, maxZ = 33.99 },
    },
    ['pizza'] = {
        { coords = vector3(292.42, -988.49, 29.43), length = 1.15, width = 2.6, heading = 353.0, minZ = 29.0-1, maxZ = 33.99 },
    },
}

Config.GangMenus = {
    ['lostmc'] = {
        vector3(0, 0, 0),
    },
    ['ballas'] = {
        vector3(0,0, 0),
    },
    ['vagos'] = {
        vector3(0, 0, 0),
    },
    ['cartel'] = {
        vector3(0, 0, 0),
    },
    ['families'] = {
        vector3(0, 0, 0),
    },
}

Config.GangMenuZones = {
    --[[
    ['gangname'] = {
        { coords = vector3(0.0, 0.0, 0.0), length = 0.0, width = 0.0, heading = 0.0, minZ = 0.0, maxZ = 0.0 },
    },
    ]]
}
