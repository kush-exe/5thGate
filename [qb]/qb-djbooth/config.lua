Config = {}

Config.DefaultVolume = 0.1 -- Accepted values are 0.01 - 1

Config.Locations = {
    ['vanilla'] = {
        ['job'] = 'vanilla', -- Required job to use booth
        ['radius'] = 60, -- The radius of the sound from the booth
        ['coords'] = vector3(117.16, -1281.38, 29.26), -- Where the booth is located
        ['playing'] = false
    },
    ['pizza'] = {
        ['job'] = 'pizza', -- Required job to use booth
        ['radius'] = 20, -- The radius of the sound from the booth
        ['coords'] = vector3(284.25, -972.67, 29.43), -- Where the booth is located
        ['playing'] = false
    }
}
