local QBCore = exports['qb-core']:GetCoreObject()

local function PreloadAnimation(dick)
	RequestAnimDict(dick)
    while not HasAnimDictLoaded(dick) do
        Citizen.Wait(0)
    end
end

local function SpawnDoor()
    DeleteEntity(currentobject)
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    PreloadAnimation("anim@heists@box_carry@")
    TaskPlayAnim(ped, "anim@heists@box_carry@" ,"idle", 5.0, -1, -1, 50, 0, false, false, false)
    currentobject = CreateObject(GetHashKey('prop_car_door_01'), coords.x, coords.y, coords.z,  true,  true, true)
    AttachEntityToEntity(currentobject, ped, GetPedBoneIndex(ped, 56604), 0.1, 0.40, -0.65, 0.0, 0.0, 180.0, true, true, false, true, 1, true)
end

function SpawnBonnet()
    DeleteEntity(currentobject)
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    PreloadAnimation("anim@heists@box_carry@")
    TaskPlayAnim(ped, "anim@heists@box_carry@" ,"idle", 5.0, -1, -1, 50, 0, false, false, false)
    currentobject = CreateObject(GetHashKey('imp_prop_impexp_bonnet_02a'), coords.x, coords.y, coords.z,  true,  true, true)
    AttachEntityToEntity(currentobject, ped, GetPedBoneIndex(ped, 56604), 0.0, 0.75, 0.45, 2.0, 0.0, 0.0, true, true, false, true, 1, true)
end

function SpawnTrunk()
    DeleteEntity(currentobject)
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    PreloadAnimation("anim@heists@box_carry@")
    TaskPlayAnim(ped, "anim@heists@box_carry@" ,"idle", 5.0, -1, -1, 50, 0, false, false, false)
    currentobject = CreateObject(GetHashKey('imp_prop_impexp_trunk_01a'), coords.x, coords.y, coords.z,  true,  true, true)
    AttachEntityToEntity(currentobject, ped, GetPedBoneIndex(ped, 56604), 0.0, 0.40, 0.1, 0.0, 0.0, 180.0, true, true, false, true, 1, true)
end

Citizen.CreateThread(function()
    local timer = 0
    while true do
        Wait(10000)
        if currentobject ~= 0 or currentobject ~= nil then
            timer = timer + 1
        end
        if timer >= 6 then
            DeleteEntity(currentobject)
            timer = 0
        end
    end
end)

RegisterNetEvent('qb-stealparts:client:stealbodypart', function(part)
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasItem)
        if hasItem then
            local ped = PlayerPedId()
            --Get Closest Rim
            local nearestDoor = 10
            local coord = GetEntityCoords(ped)-vec3(0,0,5.0)
            local bones = {
                [0] = 'VEH_EXT_DOOR_DSIDE_F',
                [1] = 'VEH_EXT_DOOR_DSIDE_R',
                [2] = 'VEH_EXT_DOOR_PSIDE_F',
                [3] = 'VEH_EXT_DOOR_PSIDE_R',
                [4] = 'VEH_EXT_BONNET',
                [5] = 'VEH_EXT_BOOT'
            }
            local dist = 99
            for k,v in pairs(bones) do
                local wheelworldpos = GetWorldPositionOfEntityBone(vehicle,GetEntityBoneIndexByName(vehicle,v))
                local wheelpos = GetOffsetFromEntityGivenWorldCoords(vehicle, wheelworldpos.x, wheelworldpos.y, wheelworldpos.z)
                
                local wheelcoord = #(coord - wheelworldpos)
                if wheelcoord < dist then
                    nearestWheel = k
                    dist = wheelcoord
                end
            end
            --print(nearestWheel)
            if dist > 15 then return end
            --do animation
                exports['ps-ui']:Circle(function(success)
                    if success then
                        QBCore.Functions.Progressbar("hotwire_vehicle", "Stealing Rims...", 25000, false, true, {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true
                        }, {
                            animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                            anim = "machinic_loop_mechandplayer",
                            flags = 16
                        }, {}, {}, function() -- Done
                            StopAnimTask(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
                            TriggerServerEvent('hud:server:GainStress', math.random(1, 4))
                            --Set Rim to under the car
                            SetVehicleWheelTireColliderSize(vehicle, nearestWheel, -5.0)
                            TriggerServerEvent('qb-stealparts:server:giverim')
                            SpawnWheel()
                        end, function() -- Cancel
                            StopAnimTask(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
                            
                        end)
                    else
                        QBCore.Functions.Notify('You failed!', 'error')
                    end
                end, 6, 10)
        else
            QBCore.Functions.Notify("You need a Toolkit to do this!", "error")
        end
    end, 'screwdriverset')
end)

RegisterNetEvent('qb-stealparts:client:AddBodyPart', function(part)
    print('here')
    local ped = PlayerPedId()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    SpawnWheel()
    
    --Get Closest Rim
    local nearestWheel = 10
    local coord = GetEntityCoords(ped)-vec3(0,0,5.0)
    local bones = {
        [0] = 'wheel_lf',
        [1] = 'wheel_rf',
        [2] = 'wheel_lr',
        [3] = 'wheel_rr'
    }
    local dist = 99
    for k,v in pairs(bones) do
        local wheelworldpos = GetWorldPositionOfEntityBone(vehicle,GetEntityBoneIndexByName(vehicle,v))
        local wheelpos = GetOffsetFromEntityGivenWorldCoords(vehicle, wheelworldpos.x, wheelworldpos.y, wheelworldpos.z)
        
        local wheelcoord = #(coord - wheelworldpos)
        if wheelcoord < dist then
            nearestWheel = k
            dist = wheelcoord
        end
    end
    print(nearestWheel)
    if dist > 15 then return end

    if GetVehicleWheelTireColliderSize(vehicle,nearestWheel) < 0 then
        exports['ps-ui']:Circle(function(success)
            if success then
                QBCore.Functions.Progressbar("hotwire_vehicle", "Attaching Rim...", 25000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true
                }, {
                    animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                    anim = "machinic_loop_mechandplayer",
                    flags = 16
                }, {}, {}, function() -- Done
                    StopAnimTask(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
                    --Set Rim to normal
                    SetVehicleWheelTireColliderSize(vehicle, nearestWheel, 0.4)
                    TriggerServerEvent('qb-stealparts:server:takerim')
                    DeleteEntity(currentobject)
                end, function() -- Cancel
                    StopAnimTask(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
                end)
            else
                QBCore.Functions.Notify('You failed!', 'error')
                DeleteEntity(currentobject)
            end
        end, 6, 10)
    end
end)