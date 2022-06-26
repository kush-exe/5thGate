Config = {}

Config.DefaultVolume = 0.1 -- Accepted values are 0.01 - 1

Config.Locations = {
    ['vanilla'] = {
        ['job'] = 'police', -- Required job to use booth
        ['radius'] = 30, -- The radius of the sound from the booth
        ['coords'] = vector3(11.7, -1598.41, 29.38), -- Where the booth is located
        ['playing'] = false
    }
}
