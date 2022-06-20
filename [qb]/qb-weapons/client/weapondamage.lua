-- Weapon Damage file
-- DO NOT TOUCH THIS, EDIT IN CONFIG

Citizen.CreateThread(function()
    while true do
        for k,v in pairs(Config.WeaponDamage) do
            N_0x4757f00bc6323cfe(GetHashKey(k), v)
            Wait(0)
        end
    end
end)

--disable pistol whipping
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = PlayerPedId()
        if IsPedArmed(ped, 6) then
            DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
            
        end
    end
end)