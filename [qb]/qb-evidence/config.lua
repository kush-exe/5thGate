Config = {}

Config.Debug = {
    DebugCommand = true, -- enable debug command
    Evidence = {enabled = false, label = "Print evidence creation to console."}, -- enable this to print debug information when normal evidence is created
    CarEvidence = {enabled = false, label = "Print car evidence creation to console."}, -- enable this to print debug information when car evidence is created
    Database = {enabled = false, label = "Print database events to server console.", server = true}, -- enable this to print debug information related to vehicle evidence being uploaded to the database
    Bucket = {enabled = false, label = "Print current bucket to console."}, -- enable this to print debug information relating to routing buckets here
    ViewEvidence = {enabled = false, label = "View evidence without camera or police job"}, -- enable seeing evidence at all times without use of camera for testing
    PrintGSR = {enabled = false, label = "Print the contents of the PlayerGSR table to server console during loop", server = true}, -- this will print the PlayerGSR table every loop
    PrintBAC = {enabled = false, label = "Print the contents of the PlayerBAC table to server console during loop", server = true}, -- this will print the PlayerBAC table every loop
    PrintStatus = {enabled = false, label = "Print the contents of the PlayerBAC table to server console during loop", server = true}, -- this will print the PlayerBAC table every loop
    PrintFade =  {enabled = false, label = "Print evidence expiring to server console", server = true}, -- this will print evidence pieces being removed by the time check loop to server console
    PrintTest = {enabled = false, label = "Print result of player checks/tests to server console", server = true}, -- print results of BAC, GSR, frisks, and investigates to server console
    PrintTestC = {enabled = false, label = "Print data sent to player check/test events to console."}, -- print data sent to BAC, GSR, frisks, and investigates to console
}

Config.Bleed = {
    EnableCommand = true, -- set to FALSE to disabled the /bleed command that allows players to generate blood evidence (but recieve damage when doing so)
    Cooldown = 10, -- the amount, in seconds, to set the cooldown timer for the /bleed command
    Chance = 60, -- chance from 0 to 100 of blood being dropped on player damage
}

Config.GSR = {
    MinShotsStatus = 5, -- the amount of times someone can fire nearby a player before they get a gunpowder status effect
    MinShotsPositive = 2, -- the amount of times a player needs to shoot to test positive for GSR (not get a gunpowder status effect)
    FadeTime = 10, -- the amount, in minutes, it takes for a player to not test positive for GSR
    WhileAiming = true, -- this sets whether or not aiming a weapon will generate a positive GSR test
    AimingTime = 5, -- the time, in seconds, it takes for a player to test positive for GSR if aiming a weapon
    ShootingChance = 70, -- set to FALSE to use only MinShotsPositive, or set to a number between 1 and 100 to enable a chance of becoming GSR positive (less realistic, more rp leeway)
    NearbyChance = 70, -- set to FALSE to use only MinShotsStatus, or set to a number between 1 and 100 to enable a chance of becoming GSR positive (less realistic, more rp leeway)
    AimingChance = 50, -- set to FALSE to use only AimingTime, or set to a number between 1 and 100 to enable a chance of becoming GSR positive (less realistic, more rp leeway)
}

Config.Consume = {
    GSR = false, -- set this to true if you want GSR tests to be consumed upon use
    DNA = false, -- set this to true if you want DNA tests to be consumed upon use
}

Config.EvidenceFadeTime = {
    Fingerprint = 30, -- time, in minutes, that fingerprint evidence gets removed without player intervention
    Tampering = 30, -- time, in minutes, that lock tamperings get removed
    Impact = 45, -- time, in minutes, that bullet impacts remain in workd before being removed
    VehFingerprints = 3, -- time, in days, that vehicle fingerprints gets removed from vehicles without player intervention
    VehCasings = 14, -- time, in days, that vehicle casings get removed from vehicles without player intervention
    VehBlood = 21, -- time, in days, that vehicle blood get removed from vehicles without player intervention
    NetImpact = 30, -- time in minutes, that network entity remain in world before getting removed
    NetPedImpact = 30, -- time in minutes, that network ped impacts remain in world before getting removed
}

Config.Copy = { -- this config allows you to format the text created by using an evidence bag, use %s where you want the evidence info to be replaced
    Fingerprint = 'Tracking ID: %s, Fingerprint ID: %s', -- 2 variables, tracking number and fingerprint 
    Casing = 'Tracking ID: %s, Serial Number: %s, Caliber: %s', -- 3 variables: tracking number, serial number and caliber of casing
    Blood = 'Tracking ID: %s, DNA ID: %s, Blood Type: %s', -- 3 variables: tracking number, DNA code and blood type
    DNA = 'DNA ID: %s', -- 1 variable: DNA code
}

Config.DB = { -- this config sets what table you are using to store vehicle evidence
    Vehicle = 'player_vehicles', -- set this to your player vehicle table
    Plate = 'plate'
}

Config.VehCasingChance = 70 -- set this to a number between 1 and 100, higher equals greater chance of casings staying in vehicle when fired in drive by

Config.Breathalyzer = true -- set this to true if you want to use the breathalyzer events contained in this script (requires additional setup)

Config.ActionsSubmenu = false -- set this to true if you wish to have only one qb-target option that opens a qb-menu, false creates seperate police actions

Config.UsableEvidence = true -- set to false to disable copying text from evidence bags

-- camera webhooks, these allow the camera to upload evidence to a discord channel using screeenshot-basic

Config.CivWebhook = ''
Config.LEOWebhook = 'https://discord.com/api/webhooks/990054907140780093/ktxD6bg7sL2Z5tR_VMyrreUSQUGo75WOFjCAMXP52C3txVrhCgp-ztCqloJoxejEdE2Z'

-- station polyzones

Config.ImpactLabels = {
    [1950175060] = "Pistol Caliber",
    [1820140472] = "Pistol Caliber",
    [218444191] = "Rifle Caliber",
    [1788949567] = "Rifle Caliber",
    [`ammo_stungun`] = "Taser Prongs",
    [-1878508229] = "Shotgun Shell",
    [1285032059] = "High-Caliber Rifle Round",
    [`ammo_rpg`] = "Explosive",

}

Config.StatusList = {
    ['fight'] = 'Red hands',
    ['widepupils'] = 'Wide pupils',
    ['redeyes'] = 'Red eyes',
    ['weedsmell'] = 'Smells like weed',
    ['gunpowder'] = 'Smells like gunpowder',
    ['chemicals'] = 'smells chemical',
    ['heavybreath'] = 'Breathes heavily',
    ['sweat'] = 'Sweats a lot',
    ['handbleed'] = 'Blood on hands',
    ['confused'] = 'Confused',
    ['alcohol'] = 'Smells like alcohol',
    ['heavyalcohol'] = 'Smells very much like alcohol'
}

-- Weapons that do not create drops

Config.NoGSRWeapon = {
    [`weapon_unarmed`] = true,
    [`weapon_snowball`] = true,
    [`weapon_stungun`] = true,
    [`weapon_petrolcan`] = true,
    [`weapon_hazardcan`] = true,
    [`weapon_fireextinguisher`] = true,
    [`weapon_raypistol`] = true,
    [`weapon_raycarbine`] = true,
    [`weapon_railgun`] = true,
    [`weapon_rayminigun`] = true,
    [`weapon_grenade`] = true,
    [`weapon_bzgas`] = true,
    [`weapon_molotov`] = true,
    [`weapon_stickybomb`] = true,
    [`weapon_proxmine`] = true,
    [`weapon_pipebomb`] = true,
    [`weapon_ball`] = true,
    [`weapon_smokegrenade`] = true,
    [`weapon_flare`] = true,
}

Config.NoCasingWeapon = {
    [`weapon_unarmed`] = true,
    [`weapon_snowball`] = true,
    [`weapon_petrolcan`] = true,
    [`weapon_hazardcan`] = true,
    [`weapon_fireextinguisher`] = true,
    [`weapon_raycarbine`] = true,
    [`weapon_musket`] = true,
    [`weapon_revolver`] = true,
    [`weapon_navyrevolver`] = true,
    [`weapon_firework`] = true,
    [`weapon_railgun`] = true,
    [`weapon_rayminigun`] = true,
    [`weapon_molotov`] = true,
    [`weapon_stickybomb`] = true,
    [`weapon_proxmine`] = true,
    [`weapon_pipebomb`] = true,
    [`weapon_ball`] = true,
    [`weapon_rpg`] = true
}

Config.NoImpactWeapon = {
    [`weapon_unarmed`] = true,
    [`weapon_snowball`] = true,
    [`weapon_petrolcan`] = true,
    [`weapon_hazardcan`] = true,
    [`weapon_fireextinguisher`] = true,
    [`weapon_grenade`] = true,
    [`weapon_bzgas`] = true,
    [`weapon_molotov`] = true,
    [`weapon_stickybomb`] = true,
    [`weapon_proxmine`] = true,
    [`weapon_pipebomb`] = true,
    [`weapon_ball`] = true,
    [`weapon_smokegrenade`] = true,
    [`weapon_flare`] = true,
}