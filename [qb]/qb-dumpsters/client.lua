QBCore = exports['qb-core']:GetCoreObject()

local searched = {3423423424}
local canSearch = true
local dumpsters = {218085040, 666561306, -58485588, -206690185, 1511880420, 682791951}
local searchTime = 14000


exports["qb-target"]:AddTargetModel(dumpsters, {
    options = {
        {
            event = "qb-dumpsters:client:search",
            icon = "fas fa-dumpster",
            label = "Search Dumpster",
        },
    },
    distance = 3
})



RegisterNetEvent('qb-dumpsters:client:search')
AddEventHandler('qb-dumpsters:client:search', function()
    if canSearch then
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local dumpsterFound = false

        
        for i = 1, #dumpsters do
            local dumpster = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.0, dumpsters[i], false, false, false)
            local dumpPos = GetEntityCoords(dumpster)
            local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, dumpPos.x, dumpPos.y, dumpPos.z, true)
            local playerPed = PlayerPedId()


            if dist < 1.8 then
                for i = 1, #searched do
                    if searched[i] == dumpster then
                        dumpsterFound = true
                    end
                    if i == #searched and dumpsterFound then
                        QBCore.Functions.Notify('This dumpster has already been searched', 'error')
                    elseif i == #searched and not dumpsterFound then
                        QBCore.Functions.Notify('Searching dumpster')
                           startSearching(searchTime, 'amb@prop_human_bum_bin@base', 'base', 'sbop:server:rewarditem')
                        TriggerServerEvent('Og:startdumpsterTimer', dumpster)
                        table.insert(searched, dumpster)
                        Citizen.Wait(1000)
                    --    ClearPedTasks(playerPed)
                   --     FreezeEntityPosition(playerPed, false)
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('Og:removedumpster')
AddEventHandler('Og:removedumpster', function(object)
    for i = 1, #searched do
        if searched[i] == object then
            table.remove(searched, i)
        end
    end
end)

-- Functions

function startSearching(time, dict, anim, cb)
    local animDict = dict
    local animation = anim
    local ped = PlayerPedId()
    local playerPed = PlayerPedId()


    canSearch = false

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(0)
    end
    QBCore.Functions.Progressbar("reful_boat", "Searching The dumpster..", 14000)
    TaskPlayAnim(ped, animDict, animation, 8.0, 8.0, time, 1, 1, 0, 0, 0)
    FreezeEntityPosition(playerPed, true)

    local ped = PlayerPedId()

    Wait(time)
    ClearPedTasks(ped)
    FreezeEntityPosition(playerPed, false)
    canSearch = true
    TriggerServerEvent(cb)
end

function DrawText3Ds(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local factor = #text / 460
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	
	SetTextScale(0.3, 0.3)
	SetTextFont(6)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 160)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	DrawRect(_x,_y + 0.0115, 0.02 + factor, 0.027, 28, 28, 28, 95)
end