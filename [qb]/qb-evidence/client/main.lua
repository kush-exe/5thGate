local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData() -- get player data on resource restart
local loaded = false -- this variable is changed once when flying in to load evidence in city

-- evidence tables

local CurrentStatusList = {}
local Casings, Blooddrops, Fingerprints, BulletImpacts, LockTamperings, CarEvidence, NetworkedBulletImpacts, NetworkedPedBulletImpacts = {}, {}, {}, {}, {}, {}, {}, {}
local AreaEvidence, CamEvidence, AreaNetEvidence, AreaNetEvidenceCache = {}, {}, {}, {}
local CurEv, CurrentEvidence = {} , nil

-- random variables

local gsr, shotAmount, gsrpos, freeaiming, lplayer = 0, 0, false, false, nil -- gsr related variables
local inmenu, newmenu = false, false
local JustBled = false
local lastdamaged, lastwep, boneindex, bonepos = nil, nil, nil, nil
local coords1, coords2 = nil, nil

-- flashlight configs

local usingflashlight, gsrtimeout, curev = false, false, false -- do not touch
local curopac = 200 -- opacity of current pickup
local cursize = 0.1
local flashdist = 8 -- distance flashlight reveals evidence
local curdist = 5 -- distance current evidence drop is visible
local areadist = 20 -- distance that evidence is cached, larger radius will decrease preformance but be less 'choppy' moving with a flashlight
local areanetdist = 100 -- distance that evidence attached to networked entities will be cached
local pudist = 1.5 -- distance the player must be within to have a current evidence pickup
local curbucket = 0
local collection = nil -- used to set time of collection for evidence
local time = nil -- used to compare time

-- Camera Config

local policecamera = true -- do not touch
local camlim = 20 -- limits how many 3D text tags are drawn by the camera, due to fivem limitations, only 32 tags can be drawn at a time, any more will appear in the top left corner of the screen
local camdist = 10 -- distance camera reveals evidence
local cammin = 2 -- distance evidence has to be away from ped to be tagged
local camopac = 170 -- opacity of evidence markers drawn by camera
local bmark = {r = 214, g = 48, b = 36} -- blood marker color
local cmark = {r = 97, g = 230, b = 87} -- casings marker color
local fmark = {r = 67, g = 209, b = 166} -- fingerprint marker color 
local imark = {r = 197, g = 197, b = 197} -- impact marker color
local tmark = {r = 197, g = 197, b = 197} -- tampering marker color
local bsize = 0.045 -- size of blood marker
local csize = 0.045 -- size of casing marker
local fsize = 0.045 -- size of fingerprint marker
local isize = 0.030 -- size of impact marker
local tsize = 0.030 -- size of tampering marker

-- Status Config


AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    if not loaded then TriggerServerEvent('evidence:server:FetchEv') end
    loaded = true
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('evidence:client:LoadEvidence', function(evtable)
    for k, v in pairs(evtable) do
        if v.evtype == 'casing' then
            TriggerEvent('evidence:client:AddCasing', k, v.type, v.coords, v.serial, v.bucket)
        elseif v.evtype == 'fingerprint' then
            TriggerEvent('evidence:client:AddFingerPrint', k, v.fingerprint, v.coords, v.bucket)
        elseif v.evtype == 'blood' then
            TriggerEvent('evidence:client:AddBlooddrop', k, v.dna, v.bloodtype, v.coords, v.bucket)
        elseif v.evtype == 'tampering' then
            TriggerEvent('evidence:client:AddFingerPrint', k, v.time, v.coords, v.bucket)
        elseif v.evtype == 'impact' then
            TriggerEvent('evidence:client:AddBulletImpact', k, v.ammotype, v.coords, v.norm, v.bucket)
        elseif v.evtype == 'netimpact' then
            TriggerEvent('evidence:client:AddNetworkedBulletImpact', k, v.ammotype, v.netid, v.offset, v.normoffset, v.model)
        elseif v.evtype == 'netpedimpact' then
            TriggerEvent('evidence:client:AddNetworkedPedBulletImpact', k, v.ammotype, v.netid, v.boneindex, v.model)
        elseif v.evtype == 'carcasing' then
            TriggerEvent('evidence:client:AddCarCasing', k, v.type, v.plate, v.serial, v.bucket)
        elseif v.evtype == 'carfingerprint' then
            TriggerEvent('evidence:client:AddCarFingerprint', k, v.fingerprint, v.plate, v.location, v.bucket)
        elseif v.evtype == 'carblood' then
            TriggerEvent('evidence:client:AddCarBlood', k, v.dna, v.bloodtype, v.plate, v.seat, v.bucket)
        end
    end
end)

-- Functions

local function DrawText3D(x, y, z, text)
    SetTextScale(0.3, 0.3)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextOutline(3, 0, 0, 0, 255)
    SetTextEntry('STRING')
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z + .1, 0)
    EndTextCommandDisplayText(0.0, 0.0)
    ClearDrawOrigin()
end

local function DnaHash(s)
    local h = string.gsub(s, '.', function(c)
        return string.format('%02x', string.byte(c))
    end)
    return h
end

local function SetGSR(time)
    if not gsrtimeout then
        TriggerEvent('evidence:client:SetStatus', 'gunpowder', time)
        gsrtimeout = true
        SetTimeout(1000, function()
            gsrtimeout = false
        end)
    end
end

local function CreateBlood()
    if not IsPedInAnyVehicle(ped) then
        local randX = math.random() + math.random(-1, 1)
        local randY = math.random() + math.random(-1, 1)
        local coords = GetOffsetFromEntityInWorldCoords(ped, randX, randY, 0)
        local is, groundz = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z, false)
        local coords =  {x = coords.x, y = coords.y, z = groundz + .02}
        TriggerServerEvent("evidence:server:CreateBloodEvidence", PlayerData.citizenid, PlayerData.metadata["bloodtype"], coords)
    else
        local veh = GetVehiclePedIsIn(ped)
        local vehseats = GetVehicleModelNumberOfSeats(GetHashKey(GetEntityModel(veh)))
        for i = -1, vehseats do
            local occupant = GetPedInVehicleSeat(veh, i)
            if occupant == ped then
                local plate = QBCore.Functions.GetPlate(veh) 
                TriggerServerEvent("evidence:server:CreateCarBlood", PlayerData.citizenid, PlayerData.metadata["bloodtype"], plate, i)
            end
        end
    end
end

-- functions that supply information for the creation of weapon evidence 

local function CreateCarCasing(weapon, plate)
    TriggerServerEvent('evidence:server:CreateCarCasing', weapon, plate)
end

local function DropBulletCasing(weapon, ped)
    local randX = math.random() + math.random(-1, 1)
    local randY = math.random() + math.random(-1, 1)
    local coords = GetOffsetFromEntityInWorldCoords(ped, randX, randY, 0)
    local is, groundz = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z, false)
    local coords =  {x = coords.x, y = coords.y, z = groundz + .02}
    TriggerServerEvent('evidence:server:CreateCasing', weapon, curserial, curwephash, coords)
    Wait(100)
end

local function CreateBulletImpact(weapon, ped, impactcoords)
    CreateThread(function()

        local ammotype = GetPedAmmoTypeFromWeapon(ped, weapon)
        local wep = GetCurrentPedWeaponEntityIndex(ped)
        local muz = GetEntityBoneIndexByName(wep, 'Gun_Muzzle')       
        local coords = nil

        if muz ~= -1 then
            coords = GetWorldPositionOfEntityBone(wep, muz)
        else
            coords = GetEntityCoords(ped)
        end

        if IsPedDoingDriveby(ped) and #(impactcoords - coords) < 1 then lastdamaged, lastwep, boneindex = nil, nil, nil return end -- this ends the bullet impact creation if the impact is too close to the gun's muzzle while in a vehicle, this is the lazy of fixing weapon impacts while in first person appearing where they pass through the shooter's windshield

        if lastdamaged and weapon == lastwep then
            if IsEntityAPed(lastdamaged) and boneindex then
                local isplayer = false
                if IsPedAPlayer(lastdamaged) then isplayer = GetPlayerServerId(NetworkGetPlayerIndexFromPed(lastdamaged)) end
                TriggerServerEvent('evidence:server:CreateNetworkedPedBulletImpact', ammotype, NetworkGetNetworkIdFromEntity(lastdamaged), boneindex, isplayer)
            else
                nrm = (norm(coords - impactcoords)) + impactcoords
                TriggerServerEvent('evidence:server:CreateNetworkedBulletImpact', ammotype, NetworkGetNetworkIdFromEntity(lastdamaged), GetOffsetFromEntityGivenWorldCoords(lastdamaged, impactcoords.x, impactcoords.y, impactcoords.z), GetOffsetFromEntityGivenWorldCoords(lastdamaged, nrm.x, nrm.y, nrm.z))
            end

            lastdamaged, lastwep, boneindex = nil, nil, nil
        else
            nrm = (norm(coords - impactcoords)) + impactcoords
            TriggerServerEvent('evidence:server:CreateBulletImpact', ammotype, impactcoords, nrm)
            lastdamaged, lastwep, boneindex = nil, nil
        end
    end)
end

-- Events

RegisterNetEvent("evidence:client:GetBloodInfo", function()
    CreateBlood()
end)

RegisterNetEvent('weapons:client:SetCurrentWeapon', function(data, bool) -- this listens for events from qb-weapons
    if data then    
        curserial = data.info.serie
        curwephash = joaat(data.name)
    else
        curserial = nil
        curwephash = nil
    end
end)

AddEventHandler('gameEventTriggered', function (name, args)
    if name == 'CEventNetworkEntityDamage' and args[1] ~= ped then
        lastdamaged = args[1]
        lastwep = args[7]

        if lastdamaged then
            if IsEntityAPed(lastdamaged) then
                local _, bone = GetPedLastDamageBone(lastdamaged)
                boneindex = GetPedBoneIndex(lastdamaged, bone)
                bonepos = GetWorldPositionOfEntityBone(lastdamaged, boneindex)
                bonerot = GetEntityBoneRotation(lastdamaged, boneindex)
            end
        end
    elseif name == 'CEventNetworkEntityDamage' and args[1] == ped then
        local chance = math.random(0, 100)
        if chance > Config.Bleed.Chance then
            CreateBlood()                
        end
    end
end)

RegisterNetEvent('hospital:client:Revive', function()
    TriggerServerEvent('evidence:server:RemoveNetPedImpacts')
end)

RegisterNetEvent('evidence:client:SetBucket', function(plybucket)
    curbucket = plybucket
end)

RegisterNetEvent('evidence:client:CopyEvidence', function(text)
    SendNUIMessage({
        copy = text,
    })
end)

RegisterNetEvent('evidence:client:UpdatePlayerID', function(evtable)
    for k, v in pairs(evtable) do
        if NetworkedPedBulletImpacts[k] then
            NetworkedPedBulletImpacts[k].netid = v
        end
    end
end)

------------------- events related to statuses and blood alcohol -------------------------

RegisterNetEvent('police:client:CheckStatus', function() --- this is so qb-radial menu works the same way as the target function
    QBCore.Functions.GetPlayerData(function(PlayerData)
        if PlayerData.job.name == "police" or Playerdata.job.name == "ambulance" then
            local player, distance = GetClosestPlayer()
            if player ~= -1 and distance < 5.0 then
                local playerId = GetPlayerServerId(player)
                QBCore.Functions.TriggerCallback('police:GetPlayerStatus', function(result)
                    local status = ''
                    if result then
                        for k, v in pairs(result) do
                            if status == '' then status = v else status = ("%s, %s"):format(status, v) end
                        end
                    end
                    if status == "" then
                        QBCore.Functions.Notify('You notice nothing unusual')
                        
                    else
                        QBCore.Functions.Notify('You notice '..status, 'warning')
                        
                    end
                end, playerId)
            else
                QBCore.Functions.Notify("No One Nearby", "error")
            end
        end
    end)
end)

RegisterNetEvent('evidence:client:investigate', function(data)
    local target = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity))

    if Config.Debug.PrintTestC.enabled then print(("Investigate event triggered for %s: %s"):format(target, json.encode(data))) end

    QBCore.Functions.Progressbar("investigating", "Investigating person...", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@amb@board_room@whiteboard@",
        anim = "examine_close_01_amy_skater_01",
        flags = 16,
    }, {}, {}, function() -- Done
        ClearPedTasks(ped)
        
        if #(GetEntityCoords(ped) - GetEntityCoords(data.entity)) < 4 then
            TriggerEvent('evidence:client:investigateresult', data)
        else
            QBCore.Functions.Notify("They're evading, breh!", 'error')                    
        end
        
    end, function() -- Cancel
        ClearPedTasks(ped)
    end)
end)

RegisterNetEvent('evidence:client:investigateresult', function(data)
    local playerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity))
    QBCore.Functions.TriggerCallback('police:GetPlayerStatus', function(result)
        local status = ''
        if result then
            for k, v in pairs(result) do
                if status == '' then status = v else status = ("%s, %s"):format(status, v) end
            end
        end
        if status == "" then
            QBCore.Functions.Notify('You notice nothing unusual')
            
        else
            QBCore.Functions.Notify('You notice ' .. status, 'warning')
            
        end
    end, playerId)
end)

RegisterNetEvent('evidence:client:SetStatus', function(statusId, time, abv)
    if Config.Breathalyzer and (statusId == 'alcohol' or statusId == 'heavyalcohol') then
        TriggerServerEvent('evidence:server:IncreaseBAC', abv or 15) -- increases BAC by .015 or by abv if a third argument is supplied
    end

    if time > 0 and Config.StatusList[statusId] then
        if (CurrentStatusList == nil or CurrentStatusList[statusId] == nil) or (CurrentStatusList[statusId] and CurrentStatusList[statusId].time < 20) then
            CurrentStatusList[statusId] = {
                text = Config.StatusList[statusId],
                time = time
            }
            QBCore.Functions.Notify(''..CurrentStatusList[statusId].text..'')
        end
    elseif Config.StatusList[statusId] then
        CurrentStatusList[statusId] = nil
    end
    TriggerServerEvent('evidence:server:UpdateStatus', CurrentStatusList)
end)

RegisterNetEvent('evidence:client:breathalyze', function(data)
    local target = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity))

    TriggerServerEvent('evidence:server:notifytarget', target, '%s is attempting to breathalyze you.')

    if Config.Debug.PrintTestC.enabled then print(("Breathalyzer event triggered for %s: %s"):format(target, json.encode(data))) end

    QBCore.Functions.Progressbar("breathalyzing", "Using Breathalyzer...", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = nil,
        anim = nil,
        flags = nil,
    }, {}, {}, function() -- Done
        ClearPedTasks(ped)

        if #(GetEntityCoords(ped) - GetEntityCoords(data.entity)) < 4 then
            TriggerEvent('evidence:client:BACresult', data)
        else
            QBCore.Functions.Notify("They're evading, breh!", 'error')                    
        end
        

    end, function() -- Cancel
        ClearPedTasks(ped)
    end)
end)

RegisterNetEvent('evidence:client:BACresult', function(data)
    local playerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity))
    QBCore.Functions.TriggerCallback('police:GetPlayerBAC', function(result)
        if result ~= "0.0" then
            QBCore.Functions.Notify('Breathalyzer Result: '.. result, 'warning')
            
        else
            QBCore.Functions.Notify('Breathalyzer Result: 0.0')
            
        end
    end, playerId)
end)


------------------- GSR events -----------------------------

RegisterNetEvent('evidence:client:SetGSR', function(bool)
    if bool then
        if not gsrpos then 
            TriggerServerEvent('evidence:server:SetGSR', bool) 
            gsrpos = bool
        end
    else
        if gsrpos then 
            TriggerServerEvent('evidence:server:SetGSR', bool) 
            gsrpos = bool 
        end
    end
end)

RegisterNetEvent('evidence:client:GSRtest', function(data)
    local target = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity))

    TriggerServerEvent('evidence:server:notifytarget', target, '%s is attempting to GSR test you.')


    if Config.Debug.PrintTestC.enabled then print(("GSR test event triggered for %s: %s"):format(target, json.encode(data))) end

    QBCore.Functions.Progressbar("gsrtest", "Preforming GSR test...", 4000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mp_arresting",
        anim = "a_uncuff",
        flags = 16,
    }, {}, {}, function() -- Done
        ClearPedTasks(ped)

        if #(GetEntityCoords(ped) - GetEntityCoords(data.entity)) < 4 then
            if Config.Consume.GSR then 
                TriggerServerEvent("QBCore:Server:RemoveItem", 'gsrtestkit', 1) 
                TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["gsrtestkit"], "remove") 
            end

            TriggerEvent('evidence:client:GSRresult', data)
        else
            QBCore.Functions.Notify("They're evading, breh!", 'error')                    
        end
    end, function() -- Cancel
        ClearPedTasks(ped)
    end)
end)

RegisterNetEvent('evidence:client:GSRresult', function(data)
    local playerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity))
    QBCore.Functions.TriggerCallback('police:GetPlayerGSR', function(result)
        if result then
            QBCore.Functions.Notify('GSR Field Test: POSITIVE', 'warning')

            local s1, s2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z)

            if s2 then
                street = tostring(GetStreetNameFromHashKey(s1)) .. ' | ' .. tostring(GetStreetNameFromHashKey(s2))
            else
                street = tostring(GetStreetNameFromHashKey(s1))
            end

            local info = {
                label = 'Positive GSR Field Test',
                type = 'gsr',
                street = street:gsub("%'", ""),
                date = collection
            }
            TriggerServerEvent('evidence:server:AddGSRToInventory', info) 
        else
            QBCore.Functions.Notify('GSR Field Test: NEGATIVE')
            
        end
    end, playerId)
end)

------------------------- events related to DNA and frisks -----------------------------------

RegisterNetEvent('evidence:client:DNAswab', function(data)
    local target = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity))

    TriggerServerEvent('evidence:server:notifytarget', target, '%s is attempting to DNA swab you.')

    if Config.Debug.PrintTestC.enabled then print(("DNA Swab event triggered for %s: %s"):format(target, json.encode(data))) end

    QBCore.Functions.Progressbar("dnaswab", "Preforming DNA Swab...", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mp_arresting",
        anim = "a_uncuff",
        flags = 16,
    }, {}, {}, function() -- Done
        ClearPedTasks(ped)

        if Config.Consume.DNA then 
            TriggerServerEvent("QBCore:Server:RemoveItem", 'dnatestkit', 1) 
            TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["dnatestkit"], "remove") 
        end

        TriggerServerEvent('evidence:server:AddDNAToInventory', target)
    end, function() -- Cancel
        ClearPedTasks(ped)
    end)
end)

RegisterNetEvent('evidence:client:frisk', function(data)
    local target = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity))

    if Config.Debug.PrintTestC.enabled then print(("Frisk event triggered on %s: %s"):format(target, json.encode(data))) end

    TriggerServerEvent('evidence:server:notifytarget', target, '%s is attempting to frisk you.')

    QBCore.Functions.Progressbar("frisk", "Preforming Terry Frisk...", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mp_arresting",
        anim = "a_uncuff",
        flags = 16,
    }, {}, {}, function() -- Done
        ClearPedTasks(ped)

        if #(GetEntityCoords(ped) - GetEntityCoords(data.entity)) < 4 then
            TriggerServerEvent('evidence:server:frisk', target)
        else
            QBCore.Functions.Notify("They're evading, breh!", 'error')                    
        end
    end, function() -- Cancel
        ClearPedTasks(ped)
    end)
end)


-- Events that add evidence to evidence tables

RegisterNetEvent('evidence:client:AddCasing', function(evidenceId, weapon, coords, serie, bucket)
    if Config.Debug.Evidence.enabled then print('Created Casing', evidenceId, weapon, coords, serie, bucket) end
    Casings[evidenceId] = {
        bucket = bucket,
        type = weapon,
        serie = serie or 'Unknown',
        coords = {
            x = coords.x,
            y = coords.y,
            z = coords.z
        }
    }
end)

RegisterNetEvent('evidence:client:AddBlooddrop', function(evidenceId, citizenid, bloodtype, coords, bucket)
    if Config.Debug.Evidence.enabled then print('Created Blooddrop', evidenceId, citizenid, bloodtype, coords, bucket) end
    Blooddrops[evidenceId] = {
        bucket = bucket,
        citizenid = citizenid,
        bloodtype = bloodtype,
        coords = {
            x = coords.x,
            y = coords.y,
            z = coords.z
        }
    }
end)

RegisterNetEvent('evidence:client:AddFingerPrint', function(evidenceId, fingerprint, coords, bucket)
    if Config.Debug.Evidence.enabled then print('Created Fingerprint', evidenceId, fingerprint, coords, bucket) end
    Fingerprints[evidenceId] = {
        bucket = bucket,
        fingerprint = fingerprint,
        coords = {
            x = coords.x,
            y = coords.y,
            z = coords.z
        }
    }
end)

RegisterNetEvent('evidence:client:AddLockTampering', function(evidenceId, tamperingTime, coords, bucket)
    if Config.Debug.Evidence.enabled then print('Created Lock Tampering', evidenceId, tamperingTime, coords, bucket) end
    LockTamperings[evidenceId] = {
        bucket = bucket,
        tamperingTime = tamperingTime,
        coords = {
            x = coords.x,
            y = coords.y,
            z = coords.z
        }
    }
end)

RegisterNetEvent('evidence:client:AddBulletImpact', function(evidenceId, ammotype, coords, norm, bucket)
    if Config.Debug.Evidence.enabled then print('Created Bullet Impact (Non-Network)', evidenceId, ammotype, coords, norm, bucket) end
    BulletImpacts[evidenceId] = {
        bucket = bucket,
        ammotype = ammotype,
        coords = {
            x = coords.x,
            y = coords.y,
            z = coords.z
        },
        norm = norm,
    }
end)

RegisterNetEvent('evidence:client:AddNetworkedBulletImpact', function(evidenceId, ammotype, netid, offset, normoffset, model)
    if Config.Debug.Evidence.enabled then print('Bullet Impact (Network Entity)', evidenceId, ammotype, offset, normoffset) end
    NetworkedBulletImpacts[evidenceId] = {
        ammotype = ammotype,
        netid = netid,
        offset = offset,
        norm = normoffset,
        model = model,
    }
end)
 
RegisterNetEvent('evidence:client:AddNetworkedPedBulletImpact', function(evidenceId, ammotype, netid, boneindex, model)
    if Config.Debug.Evidence.enabled then print('Bullet Impact (Network Ped)', evidenceId, ammotype, boneindex) end
    NetworkedPedBulletImpacts[evidenceId] = {
        ammotype = ammotype,
        netid = netid,
        boneindex = boneindex,
        model = model,
    }
end)

-- car evidence events --

RegisterNetEvent('evidence:client:AddCarCasing', function(evidenceId, weapon, plate, serial)
    if Config.Debug.CarEvidence.enabled then print('carcasing', evidenceId, weapon, plate, serial) end
    if not CarEvidence[plate] then CarEvidence[plate] = {} end
    CarEvidence[plate][evidenceId] = {
        evtype = "carcasing",
        type = weapon,
        serial = serial or 'Unknown',
    }
end)

RegisterNetEvent('evidence:client:AddCarFingerprint', function(evidenceId, fingerprint, plate, location)
    if Config.Debug.CarEvidence.enabled then print('carfingerprint', evidenceId, fingerprint, plate, location) end
    if not CarEvidence[plate] then CarEvidence[plate] = {} end
    CarEvidence[plate][evidenceId] = {
        evtype = "carfingerprint",
        fingerprint = fingerprint,
        location = location,
    }
end)

RegisterNetEvent('evidence:client:AddCarBlood', function(evidenceId, citizenid, bloodtype, plate, seat)
    if Config.Debug.CarEvidence.enabled then print('carblood', evidenceId, citizenid, bloodtype, plate, seat) end
    if not CarEvidence[plate] then CarEvidence[plate] = {} end
    CarEvidence[plate][evidenceId] = {
        evtype = "carblood",
        citizenid = citizenid,
        bloodtype = bloodtype,
        seat = seat,
    }
end)

-- Events that remove evidence from tables

RegisterNetEvent('evidence:client:RemoveFingerprint', function(evidenceId)
    Fingerprints[evidenceId] = nil
    AreaEvidence[evidenceId] = nil
    if CurrentEvidence == evidenceId then CurrentEvidence = nil end
end)

RegisterNetEvent('evidence:client:RemoveCasing', function(evidenceId)
    Casings[evidenceId] = nil
    AreaEvidence[evidenceId] = nil
    if CurrentEvidence == evidenceId then CurrentEvidence = nil end
end)

RegisterNetEvent('evidence:client:RemoveBlooddrop', function(evidenceId)
    Blooddrops[evidenceId] = nil
    AreaEvidence[evidenceId] = nil
    if CurrentEvidence == evidenceId then CurrentEvidence = nil end
end)

RegisterNetEvent('evidence:client:RemoveLockTampering', function(evidenceId)
    LockTamperings[evidenceId] = nil
    AreaEvidence[evidenceId] = nil
    if CurrentEvidence == evidenceId then CurrentEvidence = nil end
end)

RegisterNetEvent('evidence:client:RemoveImpact', function(evidenceId)
    BulletImpacts[evidenceId] = nil
    AreaEvidence[evidenceId] = nil
    if CurrentEvidence == evidenceId then CurrentEvidence = nil end
end)

RegisterNetEvent('evidence:client:RemoveNetImpact', function(evidenceId)
    NetworkedBulletImpacts[evidenceId] = nil
    AreaNetEvidenceCache[evidenceId] = nil
    AreaNetEvidence[evidenceId] = nil
end)

RegisterNetEvent('evidence:client:RemoveNetPedImpact', function(evidenceId)
    local key = tostring(NetworkGetEntityFromNetworkId(NetworkedPedBulletImpacts[evidenceId].netid))..tostring(NetworkedPedBulletImpacts[evidenceId].boneindex)
    NetworkedPedBulletImpacts[evidenceId] = nil
    AreaNetEvidenceCache[key] = nil
    AreaNetEvidence[key] = nil
end)

RegisterNetEvent('evidence:client:RemoveCarEv', function(evidenceId, plate)
    CarEvidence[plate][evidenceId] = nil
end)

RegisterNetEvent('evidence:client:RemoveCarEvidence', function(plate)
    CarEvidence[plate] = nil
end)

-- car evidence menu

local function CarEvidenceMenu(evtable, plate)
    inmenu = true

    CreateThread(function()
        while inmenu do
            Wait(200)
            if not newmenu and not IsNuiFocused() then
                ClearPedTasks(ped)
                inmenu = false
            end
        end   
    end)

    local evMenu = {
        {
            header = ('Collect Evidence from %s'):format(plate),
            isMenuHeader = true,
        }
    }

    for k, v in pairs(evtable) do
        if v.evtype == 'carcasing' then
            evMenu[#evMenu+1] = {
                header = ('Casing %s, Tracking ID: %s'):format(string.upper(v.serial), k),
                params = {
                    event = 'evidence:client:collectcarevidence',
                    args = {
                        evidenceId = k,
                        plate = plate,
                    }
                }
            }
        elseif v.evtype == "carfingerprint" then
            evMenu[#evMenu+1] = {
                header = ('Fingerprint %s, Tracking ID: %s'):format(v.fingerprint, k),
                text = ('Found on %s'):format(v.location),
                params = {
                    event = 'evidence:client:collectcarevidence',
                    args = {
                        evidenceId = k,
                        plate = plate,
                        location = v.location
                    }
                }
            }
        elseif v.evtype == 'carblood' then
            evMenu[#evMenu+1] = {
                header = ('Blood %s, Tracking ID: %s'):format(string.upper(DnaHash(v.citizenid)), k),
                text = ('Found near Seat %s'):format(v.seat),
                params = {
                    event = 'evidence:client:collectcarevidence',
                    args = {
                        evidenceId = k,
                        plate = plate,
                        seat = v.seat,
                    }
                }
            }
        end
    end

    evMenu[#evMenu+1] = {
        header = "Close (ESC)",
        params = {
            event = 'qb-menu:client:closeMenu',
        }
    }
    exports['qb-menu']:openMenu(evMenu)
end

RegisterNetEvent('evidence:client:checkcarevidence', function(data)  
    local plate = QBCore.Functions.GetPlate(data.entity)

    if not CarEvidence[plate] then TriggerServerEvent('evidence:server:LoadCarEvidence', plate) end
    
    TaskTurnPedToFaceEntity(ped, data.entity, 1000)
    Wait(1000)
    
    local doors = GetNumberOfVehicleDoors(data.entity)
    for i = -1, doors, 1 do SetVehicleDoorOpen(data.entity, i, false, false) end
    QBCore.Functions.Progressbar("checkingcar", "Investigating vehicle..", 10000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
        anim = "machinic_loop_mechandplayer",
        flags = 1,
    }, {}, {}, function() -- Done
        if not CarEvidence[plate] then ClearPedTasks(ped) QBCore.Functions.Notify('Did not discover any evidence in ' .. plate) return end
        CarEvidenceMenu(CarEvidence[plate], plate)
    end, function() -- Cancel
        ClearPedTasks(ped)
    end)
end)

RegisterNetEvent('evidence:client:collectcarevidence', function(data)
    newmenu = true
    if CarEvidence[data.plate][data.evidenceId].evtype == 'carcasing' then
        local info = {
            label = 'Spent Casing',
            tracking = data.evidenceId,
            type = 'casing',
            street = ("Vehicle %s"):format(data.plate),
            ammolabel = QBCore.Shared.Weapons[CarEvidence[data.plate][data.evidenceId].type]['caliber'],
            serie = CarEvidence[data.plate][data.evidenceId].serial,
            date = collection
        }
        TriggerServerEvent('evidence:server:AddCarEvToInventory', data.evidenceId, info, data.plate)                        
    elseif CarEvidence[data.plate][data.evidenceId].evtype == 'carblood' then
        local info = {
            label = 'Blood Sample',
            tracking = data.evidenceId,
            type = 'blood',
            street = ("%s, Seat %s"):format(data.plate, data.seat),
            dnalabel = DnaHash(CarEvidence[data.plate][data.evidenceId].citizenid),
            bloodtype = CarEvidence[data.plate][data.evidenceId].bloodtype,
            date = collection
        }
        TriggerServerEvent('evidence:server:AddCarEvToInventory', data.evidenceId, info, data.plate)
    elseif CarEvidence[data.plate][data.evidenceId].evtype == 'carfingerprint' then
        local info = {
            label = 'Fingerprint',
            tracking = data.evidenceId,
            type = 'fingerprint',
            street = ("%s, %s"):format(data.plate, data.location),
            fingerprint = CarEvidence[data.plate][data.evidenceId].fingerprint,
            date = collection
        }
        TriggerServerEvent('evidence:server:AddCarEvToInventory', data.evidenceId, info, data.plate)                        
    end

    if next(CarEvidence[data.plate]) then
        Wait(500)
        CarEvidenceMenu(CarEvidence[data.plate], data.plate) 
        newmenu = false
    else
        inmenu = false
        newmenu = false
    end    
end)


if Config.Bleed.EnableCommand then
    RegisterCommand("bleed", function(source, args) -- this command allows players to create blood evidence during rp situations that may not generate actual blood evidence
        if JustBled or QBCore.Functions.GetPlayerData().metadata['inlaststand'] or QBCore.Functions.GetPlayerData().metadata['isdead'] then return end

        JustBled = true

        local currentHealth = GetEntityHealth(ped)
        SetEntityHealth(ped, currentHealth - math.random(5, 10))

        AnimpostfxPlay("MP_corona_switch" , 1000, false)

        QBCore.Functions.Notify('Blood trickles from your wound as you feel weaker', 'error')

        if not IsPedInAnyVehicle(ped) then
            local randX = math.random() + math.random(-1, 1)
            local randY = math.random() + math.random(-1, 1)
            local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), randX, randY, 0)
            local is, groundz = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z, false)
            local coords =  {x = coords.x, y = coords.y, z = groundz + .02}
            TriggerServerEvent("evidence:server:CreateBloodDrop", QBCore.Functions.GetPlayerData().citizenid, QBCore.Functions.GetPlayerData().metadata["bloodtype"], coords)
        else
            local veh = GetVehiclePedIsIn(PlayerPedId())
            local vehseats = GetVehicleModelNumberOfSeats(GetHashKey(GetEntityModel(veh)))
            for i = -1, vehseats do
                local occupant = GetPedInVehicleSeat(veh, i)
                if occupant == ped then
                    local plate = QBCore.Functions.GetPlate(veh) 
                    TriggerServerEvent('evidence:server:CreateCarBlood', QBCore.Functions.GetPlayerData().citizenid, QBCore.Functions.GetPlayerData().metadata["bloodtype"], plate, i)
                end
            end
        end

        Wait(Config.Bleed.Cooldown * 1000)

        JustBled = false
    end, false)
end

----------------- Debug Menu and other Debug Events --------------------------

RegisterNetEvent('evidence:client:debugmenu', function() -- this event is triggered by the debug command
    local debugMenu = {
        {
            header = ('r14-evidence Debug Menu'):format(plate),
            isMenuHeader = true,
        }
    }

    for k, v in pairs(Config.Debug) do
        if k ~= 'DebugCommand' then
            if not v.server then
                debugMenu[#debugMenu+1] = {
                    header = ('%s'):format(v.label),
                    text = ('Current State: %s'):format(string.upper(tostring(v.enabled))),
                    params = {
                        event = 'evidence:client:setdebugvariable',
                        args = {
                            var = k,
                            bool = v.enabled,
                        }
                    }
                }
            else
                debugMenu[#debugMenu+1] = {
                    header = ('%s'):format(v.label),
                    text = ('Current State: %s'):format(string.upper(tostring(v.enabled))),
                    params = {
                        isServer = true,
                        event = 'evidence:server:SetServerDebugVariable',
                        args = {
                            var = k,
                            bool = v.enabled,
                        }
                    }
                }
            end
        end
    end

    debugMenu[#debugMenu+1] = {
        header = "Close (ESC)",
        params = {
            event = 'qb-menu:client:closeMenu',
        }
    }
    exports['qb-menu']:openMenu(debugMenu)
end)

RegisterNetEvent('evidence:client:setdebugvariable', function(data)
    Config.Debug[data.var].enabled = not data.bool
end)

-------------------------------------------------------------------------------------------------------------------

---[[ these are debug commands for testing target options when no one is around, you can uncomment this by adding a dash to the start of this line if you wish to use them

RegisterCommand('selfinvestigate', function()
    local data = {entity = PlayerPedId()}
    TriggerEvent('evidence:client:investigate', data)
end)

RegisterCommand('selfgsrtest', function()
    local data = {entity = PlayerPedId()}
    TriggerEvent('evidence:client:GSRtest', data)
end)

RegisterCommand('selfdnaswab', function()
    local data = {entity = PlayerPedId()}
    TriggerEvent('evidence:client:DNAswab', data)
end) 

RegisterCommand('selffrisk', function()
    local data = {entity = PlayerPedId()}
    TriggerEvent('evidence:client:frisk', data)
end)

RegisterCommand('selfbreathalyze', function()
    local data = {entity = PlayerPedId()}
    TriggerEvent('evidence:client:breathalyze', data)
end) 

----------------------------------------------------------------------------------------------------------------- ]] 

--------- qb menu event for workaround/police action menu option

RegisterNetEvent('r14-evidence:client:workaround', function(data)
    local workaroundMenu = {
        {
            header = ('Police Actions'):format(plate),
            isMenuHeader = true,
        }
    }

    workaroundMenu[#workaroundMenu] = {
        header = 'Frisk Suspect',
        params = {
            event = 'evidence:client:frisk',
            args = {
                entity = data.entity
            }
        }
    }

    workaroundMenu[#workaroundMenu] = {
        header = 'Frisk Suspect',
        params = {
            event = 'evidence:client:investigate',
            args = {
                entity = data.entity
            }
        }
    }

    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
        if result then
            workaroundMenu[#workaroundMenu] = {
                header = 'GSR Test',
                params = {
                    event = 'evidence:client:GSRtest',
                    args = {
                        entity = data.entity
                    }
                }
            }
        end
    end, "gsrtestkit")



    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
        if result then
            workaroundMenu[#workaroundMenu] = {
                header = 'DNA Swab',
                params = {
                    event = 'evidence:client:DNAswab',
                    args = {
                        entity = data.entity
                    }
                }
            }
        end
    end, "dnatestkit")

    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
        if result then
            workaroundMenu[#workaroundMenu] = {
                header = 'Breathalyze',
                params = {
                    event = 'evidence:client:breathalyze',
                    args = {
                        entity = data.entity
                    }
                }
            }
        end
    end, "breathalyzer")


    workaroundMenu[#workaroundMenu] = {
        header = "Close (ESC)",
        params = {
            event = 'qb-menu:client:closeMenu',
        }
    }
    exports['qb-menu']:openMenu(evMenu)
end)


-- events that clear evidence from tables

RegisterNetEvent('evidence:client:ClearEvidenceInArea', function()
    QBCore.Functions.Progressbar('clear_casings', 'Cleaning up crime scene...', 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent('evidence:server:ClearEvidence', pos)
    end, function() -- Cancel
        QBCore.Functions.Notify('You couldn\'t even do this right.', 'error')
    end)
end)

-- qb-target exports to define target interactions for this script

exports['qb-target']:AddGlobalPlayer({
  options = {
    { 
      type = "client", 
      event = 'evidence:client:GSRtest',
      icon = 'fa-solid fa-gun',
      label = 'Perform Field GSR Test',
      item = 'gsrtestkit',
      entity = entity,
      canInteract = function(entity)
        if QBCore.Functions.GetPlayerData().metadata['inlaststand'] or QBCore.Functions.GetPlayerData().metadata['isdead'] then return false end
        if GetEntitySpeed(entity) > 0.5 then return false end 
        return true
      end,
      job = 'police',
    },
    { 
      type = "client", 
      event = 'evidence:client:frisk',
      icon = 'fa-solid fa-gun',
      label = 'Frisk Person',
      entity = entity,
      canInteract = function(entity)
        if QBCore.Functions.GetPlayerData().metadata['inlaststand'] or QBCore.Functions.GetPlayerData().metadata['isdead'] then return false end
        if GetEntitySpeed(entity) > 0.5 then return false end 
        return true
      end,
    },
    { 
      type = "client", 
      event = 'evidence:client:DNAswab',
      icon = 'fa-solid fa-dna',
      label = 'Collect DNA',
      item = 'dnatestkit',
      entity = entity,
      canInteract = function(entity)
        if QBCore.Functions.GetPlayerData().metadata['inlaststand'] or QBCore.Functions.GetPlayerData().metadata['isdead'] then return false end
        if GetEntitySpeed(entity) > 0.5 then return false end 
        return true
      end,
      job = {["police"] = 0, ["ambulance"] = 0},
    },
    { 
      type = "client", 
      event = 'evidence:client:investigate',
      icon = 'fa-solid fa-magnifying-glass',
      label = 'Investigate Person',
      entity = entity,
      canInteract = function(entity)
        if QBCore.Functions.GetPlayerData().metadata['inlaststand'] or QBCore.Functions.GetPlayerData().metadata['isdead'] then return false end
        if GetEntitySpeed(entity) > 0.5 then return false end 
        return true
      end,
      job = {["police"] = 0, ["ambulance"] = 0},
    },
    { 
      type = "client", 
      event = 'evidence:client:breathalyze',
      icon = 'fa-solid fa-dna',
      label = 'Breathalyze Person',
      item = 'breathalyzer',
      entity = entity,
      canInteract = function(entity)
        if QBCore.Functions.GetPlayerData().metadata['inlaststand'] or QBCore.Functions.GetPlayerData().metadata['isdead'] then return false end
        if GetEntitySpeed(entity) > 0.5 then return false end 
        return true
      end,
      job = {["police"] = 0, ["ambulance"] = 0},
    },
  },
  distance = 2.5, 
})

exports['qb-target']:AddGlobalVehicle({
    options = {
    { 
            type = "client",
            event = 'evidence:client:checkcarevidence',
            icon = "fa-solid fa-gun",
            label = "Conduct Evidence Sweep",
			job = {	["police"] = 0},
			entity = entity,
    }
    },
    distance = 3.0, 
})

if Config.ActionsSubmenu then
    exports['qb-target']:AddGlobalPlayer({
      options = {
        { 
          type = "client", 
          event = 'r14-evidence:client:workaround',
          icon = 'fa-solid fa-shield-halved',
          label = 'Police Actions',
          entity = entity,
          canInteract = function(entity)
            if QBCore.Functions.GetPlayerData().metadata['inlaststand'] or QBCore.Functions.GetPlayerData().metadata['isdead'] then return false end
            if GetEntitySpeed(entity) > 0.5 then return false end 
            return true
          end,
          job = 'police',
        },
      },
      distance = 2.5, 
    })
else
    exports['qb-target']:AddGlobalPlayer({
      options = {
        { 
          type = "client", 
          event = 'evidence:client:GSRtest',
          icon = 'fa-solid fa-gun',
          label = 'Perform Field GSR Test',
          item = 'gsrtestkit',
          entity = entity,
          canInteract = function(entity)
            if QBCore.Functions.GetPlayerData().metadata['inlaststand'] or QBCore.Functions.GetPlayerData().metadata['isdead'] then return false end
            if GetEntitySpeed(entity) > 0.5 then return false end 
            return true
          end,
          job = 'police',
        },
        { 
          type = "client", 
          event = 'evidence:client:frisk',
          icon = 'fa-solid fa-gun',
          label = 'Frisk Person',
          entity = entity,
          canInteract = function(entity)
            if QBCore.Functions.GetPlayerData().metadata['inlaststand'] or QBCore.Functions.GetPlayerData().metadata['isdead'] then return false end
            if GetEntitySpeed(entity) > 0.5 then return false end 
            return true
          end,
        },
        { 
          type = "client", 
          event = 'evidence:client:DNAswab',
          icon = 'fa-solid fa-dna',
          label = 'Collect DNA',
          item = 'dnatestkit',
          entity = entity,
          canInteract = function(entity)
            if QBCore.Functions.GetPlayerData().metadata['inlaststand'] or QBCore.Functions.GetPlayerData().metadata['isdead'] then return false end
            if GetEntitySpeed(entity) > 0.5 then return false end 
            return true
          end,
          job = {["police"] = 0, ["ambulance"] = 0},
        },
        { 
          type = "client", 
          event = 'evidence:client:investigate',
          icon = 'fa-solid fa-magnifying-glass',
          label = 'Investigate Person',
          entity = entity,
          canInteract = function(entity)
            if QBCore.Functions.GetPlayerData().metadata['inlaststand'] or QBCore.Functions.GetPlayerData().metadata['isdead'] then return false end
            if GetEntitySpeed(entity) > 0.5 then return false end 
            return true
          end,
          job = {["police"] = 0, ["ambulance"] = 0},
        },
        { 
          type = "client", 
          event = 'evidence:client:breathalyze',
          icon = 'fa-solid fa-dna',
          label = 'Breathalyze Person',
          item = 'breathalyzer',
          entity = entity,
          canInteract = function(entity)
            if QBCore.Functions.GetPlayerData().metadata['inlaststand'] or QBCore.Functions.GetPlayerData().metadata['isdead'] then return false end
            if GetEntitySpeed(entity) > 0.5 then return false end 
            return true
          end,
          job = {["police"] = 0, ["ambulance"] = 0},
        },
      },
      distance = 2.5, 
    })
end

exports['qb-target']:AddGlobalVehicle({
    options = {
    { 
            type = "client",
            event = 'evidence:client:checkcarevidence',
            icon = "fa-solid fa-gun",
            label = "Conduct Evidence Sweep",
			job = {	["police"] = 0},
			entity = entity,
    }
    },
    distance = 3.0, 
})

---------------------- script loops --------------------------------

CreateThread(function()  -- server callbacks to get current time, these set collection times for evdidence bags, and can be used to clear evidence from tables after a certain time
    while true do
        Wait(1000)
        QBCore.Functions.TriggerCallback('evidence:GetDate', function(result)
            collection = result
        end)
        QBCore.Functions.TriggerCallback('evidence:GetTime', function(result)
            time = result
        end)
    end
end)

CreateThread(function() -- this thread gets our ped offsets for the gsr thread
    while true do
        Wait(200)
        if LocalPlayer.state.isLoggedIn and ped then
            coords1 = GetOffsetFromEntityInWorldCoords(ped, 5.0, 5.0, 5.0)
            coords2 = GetOffsetFromEntityInWorldCoords(ped, -5.0, -5.0, -5.0)    
        end
    end
end)

CreateThread(function() -- this thread checks for peds shooting in an area, if they are, the player will have a gsr status set. currently this include any weapon including non-gsr weapons 
    while true do
        Wait(0)
        if LocalPlayer.state.isLoggedIn and coords1 and coords2 then
            if IsAnyPedShootingInArea(coords1.x, coords1.y, coords1.z, coords2.x, coords2.y, coords2.z, true, true) then
                if gsr then
                    gsr = gsr + 1
                    if gsr > Config.GSR.MinShotsStatus then SetGSR(200) end
                else
                    gsr = 1
                end
            end
        end
    end
end)


 


CreateThread(function() -- Thread applies statuses to players and removes them after a certain amount of time.
    while true do
        Wait(10000)
        if LocalPlayer.state.isLoggedIn then
            gsr = 0
            if CurrentStatusList and next(CurrentStatusList) then
                for k, v in pairs(CurrentStatusList) do
                    if CurrentStatusList[k].time > 10 then
                        CurrentStatusList[k].time = CurrentStatusList[k].time - 10
                    else
                        CurrentStatusList[k] = nil
                    end
                end
                TriggerServerEvent('evidence:server:UpdateStatus', CurrentStatusList)
            end
            if shotAmount > 0 then
                shotAmount = 0
            end
        end
    end
end)



CreateThread(function() -- Thread sets gunpowder status and creates bullet casings and bullet impacts.
    while true do
        Wait(0)
        if IsPedShooting(ped) then
            local weapon = GetSelectedPedWeapon(ped)
            if not Config.NoGSRWeapon[weapon] and GetWeaponDamageType(weapon) == 3 then
                shotAmount = shotAmount + 1
                if shotAmount > Config.GSR.MinShotsPositive then
                    local chance = math.random(0, 100)
                    if not Config.GSR.ShootingChance then
                        TriggerEvent('evidence:client:SetGSR', true)
                    elseif chance <= Config.GSR.ShootingChance then
                        TriggerEvent('evidence:client:SetGSR', true)
                    end
                end
            end
            if not Config.NoCasingWeapon[weapon] then
                if IsPedInAnyVehicle(ped) then
                    local chance = math.random(1, 100)
                    if chance > Config.VehCasingChance then
                        DropBulletCasing(weapon, ped)                            
                    else
                        CreateCarCasing(weapon, QBCore.Functions.GetPlate(GetVehiclePedIsUsing(ped, true)))
                    end
                else
                    DropBulletCasing(weapon, ped)
                end
            end
        end
    end
end)

-------------------------- END REMOVE ------------------------------


CreateThread(function() --- this thread gets our current ped's entity handle, position, and routing bucket
	while true do
        if LocalPlayer.state.isLoggedIn then
            if ped and ped ~= PlayerPedId() then TriggerServerEvent('evidence:server:UpdatePlayerNetId', NetworkGetNetworkIdFromEntity(PlayerPedId())) end

	        ped = PlayerPedId()
            pos = GetEntityCoords(ped)

            lplayer = PlayerId()

            if Config.Debug.Bucket.enabled then print('Current routing bucket:', curbucket) end
            TriggerServerEvent('evidence:server:GetBucket')
        end
        Wait(1000)
	end
end)

CreateThread(function() --- this thread, if enabled, will set GSR if a player is aiming a firearm
    while Config.GSR.WhileAiming do
        if freeaiming then
            local chance = math.random(0, 100)
            if not Config.GSR.AimingChance then
                TriggerEvent('evidence:client:SetGSR', true)
            elseif chance <= Config.GSR.AimingChance then
                TriggerEvent('evidence:client:SetGSR', true)
            end
        end
        if IsPlayerFreeAiming(lplayer) and GetWeaponDamageType(GetSelectedPedWeapon(ped)) == 3 then freeaiming = true end
        Wait(1000 * Config.GSR.AimingTime)
    end
end)

CreateThread(function()  -- networked bullet evidence caching
    while true do
        Wait(2000)
        if LocalPlayer.state.isLoggedIn then
            if PlayerData and PlayerData.job.name == 'police' then
                AreaNetEvidenceCache = {}
                pos = GetEntityCoords(ped, true)
                for k, v in pairs(NetworkedBulletImpacts) do
                    if NetworkDoesEntityExistWithNetworkId(v.netid) and GetEntityModel(NetworkGetEntityFromNetworkId(v.netid)) == v.model then
                        local netentity = NetworkGetEntityFromNetworkId(v.netid)
                        local distance = #(pos - vector3(GetEntityCoords(netentity)))
                        if distance < areanetdist then
                            local impactsize = Config.ImpactLabels[v.ammotype] or 'Unknown'
                            AreaNetEvidenceCache[k] = {
                                bucket = v.bucket,
                                tag = impactsize .. ' Impact',
                                color = {r = imark.r, g = imark.g, b = imark.b},
                                size = isize,
                                entity = netentity,
                                coords = v.offset,
                                norm = v.norm,
                            }
                        end
                    end
                end
                for k, v in pairs(NetworkedPedBulletImpacts) do
                    if NetworkDoesEntityExistWithNetworkId(v.netid) and GetEntityModel(NetworkGetEntityFromNetworkId(v.netid)) == v.model then
                        local netentity = NetworkGetEntityFromNetworkId(v.netid)
                        local distance = #(pos - vector3(GetEntityCoords(netentity)))
                        if distance < areanetdist then
                            local impactsize = Config.ImpactLabels[v.ammotype] or 'Unknown'
                            local key = tostring(netentity)..tostring(v.boneindex)
                            if AreaNetEvidenceCache[key] and not AreaNetEvidenceCache[key].ammotypes[v.ammotype] then                             
                                AreaNetEvidenceCache[key] = {
                                    tag = ('%s, %s'):format(impactsize, AreaNetEvidenceCache[key].tag),
                                    color = {r = bmark.r, g = bmark.g, b = bmark.b},
                                    size = isize,
                                    entity = netentity,
                                    boneindex = v.boneindex,
                                    norm = v.norm,
                                }
                            elseif not AreaNetEvidenceCache[key] then
                                AreaNetEvidenceCache[key] = {
                                    ammotypes = {[v.ammotype] = true},
                                    tag = impactsize .. ' Wound',
                                    color = {r = bmark.r, g = bmark.g, b = bmark.b},
                                    size = isize,
                                    entity = netentity,
                                    boneindex = v.boneindex,
                                    norm = v.norm,
                                }
                            end
                        end
                    end
                end
            end
        end
    end
end)

CreateThread(function() -- this loop tracks our ped impacts
    while true do
        Wait(0)
        local is, impactcoords = GetPedLastWeaponImpactCoord(ped)
        if is then
            impactweap = GetSelectedPedWeapon(ped)

            if not Config.NoImpactWeapon[impactweap] and GetWeaponDamageType(impactweap) == 3 then
                CreateBulletImpact(impactweap, ped, impactcoords)
            end
        end
    end
end)

CreateThread(function() -- this loop brings evidence out of cache to feed to the camera loop
    while true do
        Wait(500)
        if (usingflashlight or policecamera) and next(AreaNetEvidenceCache) then
            pos = GetEntityCoords(ped)
            for k, v in pairs(AreaNetEvidenceCache) do
                local coords = GetEntityCoords(v.entity)
                local dist = #(pos - coords)
                if dist < areadist then
                    AreaNetEvidence[k] = {
                        bucket = v.bucket,
                        tag = v.tag,
                        distance = dist,
                        netev = true,
                        entity = v.entity,
                        color = v.color,
                        size = isize,
                        boneindex = v.boneindex,
                        coords = v.coords,
                        norm = v.norm,
                    }
                else
                    AreaNetEvidence[k] = nil
                end
            end
        end
    end
end)

 -- SUPER OPTIMIZED nearby evidence script!

CreateThread(function()
    while true do
        Wait(500)
        if LocalPlayer.state.isLoggedIn then
            if PlayerData and PlayerData.job.name == 'police' then
                AreaEvidence = {}
                pos = GetEntityCoords(ped)
                if next(Casings) then
                    for k, v in pairs(Casings) do
                        local distance = #(pos - vector3(v.coords.x, v.coords.y, v.coords.z))
                        if distance < areadist then
                            AreaEvidence[k] = {
                                bucket = v.bucket,
                                tag = 'Casing ' .. string.upper(v.serie) .. ' | Tracking ID ' .. k,
                                type = 'casing',
                                distance = distance,
                                color = {r = cmark.r, g = cmark.g, b = cmark.b},
                                size = csize,
                                coords = {
                                    x = v.coords.x,
                                    y = v.coords.y,
                                    z = v.coords.z
                                }
                            }
                        end
                    end
                end
                if next(BulletImpacts) then
                    for k, v in pairs(BulletImpacts) do
                        local distance = #(pos - vector3(v.coords.x, v.coords.y, v.coords.z))
                        if distance < areadist then
                            local impactsize = Config.ImpactLabels[v.ammotype] or 'Unknown'
                            AreaEvidence[k] = {
                                bucket = v.bucket,
                                tag = impactsize .. ' Impact',
                                distance = distance,
                                color = {r = imark.r, g = imark.g, b = imark.b},
                                size = isize,
                                coords = {
                                    x = v.coords.x,
                                    y = v.coords.y,
                                    z = v.coords.z
                                },
                                norm = v.norm,
                            }
                        end
                    end
                end
                if next(Blooddrops) then
                    for k, v in pairs(Blooddrops) do
                        local distance = #(pos - vector3(v.coords.x, v.coords.y, v.coords.z))
                        if distance < areadist then
                            AreaEvidence[k] = {
                                bucket = v.bucket,
                                tag = 'Blood ' .. string.upper(DnaHash(v.citizenid)) .. ' | Tracking ID ' .. k,
                                type = 'blood',
                                distance = distance,
                                color = {r = bmark.r, g = bmark.g, b = bmark.b},
                                size = bsize,
                                coords = {
                                    x = v.coords.x,
                                    y = v.coords.y,
                                    z = v.coords.z
                                }
                            }
                        end
                    end
                end
                if next(Fingerprints) then
                    for k, v in pairs(Fingerprints) do
                        local distance = #(pos - vector3(v.coords.x, v.coords.y, v.coords.z))
                        if distance < areadist then
                            AreaEvidence[k] = {
                                bucket = v.bucket,
                                tag = 'Fingerprint ' .. string.upper(v.fingerprint) .. ' | Tracking ID ' .. k,
                                type = 'fingerprint',
                                distance = distance,
                                color = {r = fmark.r, g = fmark.g, b = fmark.b},
                                size = fsize,
                                coords = {
                                    x = v.coords.x,
                                    y = v.coords.y,
                                    z = v.coords.z
                                }
                            }
                        end
                    end
                end
                if next(LockTamperings) then
                    for k, v in pairs(LockTamperings) do
                        local distance = #(pos - vector3(v.coords.x, v.coords.y, v.coords.z))
                        if distance < areadist then
                            AreaEvidence[k] = {
                                bucket = v.bucket,
                                tag = 'Evidence of Lock Tampering',
                                distance = distance,
                                color = {r = tmark.r, g = tmark.g, b = tmark.b},
                                size = tsize,
                                coords = {
                                    x = v.coords.x,
                                    y = v.coords.y,
                                    z = v.coords.z
                                }
                            }
                        end
                    end
                end
            else
                Wait(2000)                
            end
        else
            Wait(5000)
        end
    end
 end)
 
-- optimized flashlight thread, enables police to use flashlight to reveal and pickup evidence

CreateThread(function()
    while true do
        Wait(0)
        if LocalPlayer.state.isLoggedIn then
            if PlayerData and PlayerData.job.name == 'police' then
                if IsPlayerFreeAiming(lplayer) and GetSelectedPedWeapon(ped) == `WEAPON_FLASHLIGHT` then
                    usingflashlight = true
                    local pos = GetEntityCoords(ped, true)
                    if next(AreaEvidence) then
                        local CurEv = {}
                        CurrentEvidence = nil
                        local evId = 1
                        for k, v in pairs(AreaEvidence) do
                            local dist = #(pos - vector3(v.coords.x, v.coords.y, v.coords.z))
                            if dist < pudist and v.type then
                                CurEv[evId] = {
                                    evidenceId = k,
                                    dist = dist
                                }
                                evId = evId + 1
                            end
                        end
                        table.sort(CurEv, function(a, b)
                            return a.dist < b.dist
                        end)
                        local i = 1
                        for k, v in pairs(CurEv) do
                            if i == 1 then
                                CurrentEvidence = AreaEvidence[v.evidenceId]
                                CurrentEvidence.evid = v.evidenceId
                                i = i + 1
                            end
                        end
                        for k, v in pairs(AreaEvidence) do
                            local dist = #(pos - vector3(v.coords.x, v.coords.y, v.coords.z))
                            if (not v.bucket or curbucket == v.bucket) and dist < flashdist and (CurrentEvidence and k ~= CurrentEvidence.evid) then
                                DrawMarker(28, v.coords.x, v.coords.y, v.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.size, v.size, v.size, v.color.r, v.color.g, v.color.b, camopac, false, false, 2, nil, nil, false)
                                if v.norm then
                                    DrawLine(v.coords.x, v.coords.y, v.coords.z, v.norm.x, v.norm.y, v.norm.z, v.color.r, v.color.g, v.color.b, camopac)
                                end
                            end
                        end 
                        for k, v in pairs(AreaNetEvidence) do
                            local drawcoords = v.coords

                            if v.boneindex then drawcoords = GetWorldPositionOfEntityBone(v.entity, v.boneindex) elseif v.netev then drawcoords = GetOffsetFromEntityInWorldCoords(v.entity, drawcoords.x, drawcoords.y, drawcoords.z) end

                            local dist = #(pos - vector3(drawcoords.x, drawcoords.y, drawcoords.z))
                            if (not v.bucket or curbucket == v.bucket) and dist < flashdist and (CurrentEvidence and k ~= CurrentEvidence.evid) then
                                if not v.boneindex then DrawMarker(28, drawcoords.x, drawcoords.y, drawcoords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.size, v.size, v.size, v.color.r, v.color.g, v.color.b, camopac, false, false, 2, nil, nil, false) end
                                if v.norm then
                                    if not v.netev then
                                        DrawLine(drawcoords.x, drawcoords.y, drawcoords.z, v.norm.x, v.norm.y, v.norm.z, v.color.r, v.color.g, v.color.b, camopac)
                                    else
                                        local normoffset = GetOffsetFromEntityInWorldCoords(v.entity, v.norm.x, v.norm.y, v.norm.z)
                                        DrawLine(drawcoords.x, drawcoords.y, drawcoords.z, normoffset.x, normoffset.y, normoffset.z, v.color.r, v.color.g, v.color.b, camopac)
                                    end
                                end
                            end
                        end  
                    end
                else
                    usingflashlight = false
                    Wait(1000) -- checks once per second if ped is aiming flashlight 
                end
            else
                Wait(5000) -- checks every five seconds if ped has police job
            end
        end
    end
end)

-- Thread allows police to pick up evidence drops revealed with and selected by the flashlight user. It will create the evdience bag item with the metadata from the drop.

CreateThread(function()
    while true do
        Wait(1)      
        if CurrentEvidence then    
            local pos = GetEntityCoords(ped)
            local curev = CurrentEvidence
            local dist = #(pos -vector3(curev.coords.x, curev.coords.y, curev.coords.z))
            if dist < curdist then
                DrawMarker(23, curev.coords.x, curev.coords.y, curev.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, cursize, cursize, cursize, curev.color.r, curev.color.g, curev.color.b, curopac, false, false, 2, nil, nil, false)
                DrawText3D(curev.coords.x, curev.coords.y, curev.coords.z, '~g~G~w~ - ' .. curev.tag)
                if IsControlJustReleased(0, 47) then
                    CurrentEvidence = nil                  
                    AreaEvidence[curev.evid] = nil 
                    local s1, s2 = GetStreetNameAtCoord(curev.coords.x, curev.coords.y, curev.coords.z)
                    if s2 then
                        street = tostring(GetStreetNameFromHashKey(s1)) .. ' | ' .. tostring(GetStreetNameFromHashKey(s2))
                    else
                        street = tostring(GetStreetNameFromHashKey(s1))
                    end
                    if curev.type == 'casing' then
                        local info = {
                            label = 'Spent Casing',
                            tracking = curev.evid,
                            type = 'casing',
                            street = street:gsub("%'", ""),
                            ammolabel = QBCore.Shared.Weapons[Casings[curev.evid].type]['caliber'],
                            serie = Casings[curev.evid].serie,
                            date = collection
                        }
                        TriggerServerEvent('evidence:server:AddCasingToInventory', curev.evid, info)                        
                    elseif curev.type == 'blood' then
                        local info = {
                            label = 'Blood Sample',
                            tracking = curev.evid,
                            type = 'blood',
                            street = street:gsub("%'", ""),
                            dnalabel = DnaHash(Blooddrops[curev.evid].citizenid),
                            bloodtype = Blooddrops[curev.evid].bloodtype,
                            date = collection
                        }
                        TriggerServerEvent('evidence:server:AddBlooddropToInventory', curev.evid, info)
                    elseif curev.type == 'fingerprint' then
                        local info = {
                            label = 'Fingerprint',
                            tracking = curev.evid,
                            type = 'fingerprint',
                            street = street:gsub("%'", ""),
                            fingerprint = Fingerprints[curev.evid].fingerprint,
                            date = collection
                        }
                        TriggerServerEvent('evidence:server:AddFingerprintToInventory', curev.evid, info)                  
                    end
                end
            end          
        end
    end
end)

-- optimized camera script, draws the evidence markers and labels

CreateThread(function()
    while true do
        Wait(0)
        if policecamera then
            local i = 1
            if IsControlJustPressed(0, 177) or IsControlJustPressed(0, 157) or IsControlJustPressed(0, 158) or IsControlJustPressed(0, 160) or IsControlJustPressed(0, 164) or IsControlJustPressed(0, 165) or IsControlJustPressed(0, 159) then
                policecamera = false
            end
            for k, v in pairs(CamEvidence) do
                local drawcoords = v.coords

                if v.boneindex then drawcoords = GetWorldPositionOfEntityBone(v.entity, v.boneindex) elseif v.netev then drawcoords = GetOffsetFromEntityInWorldCoords(v.entity, drawcoords.x, drawcoords.y, drawcoords.z) end

                local isOnScreen, screenX, screenY = GetScreenCoordFromWorldCoord(drawcoords.x, drawcoords.y, drawcoords.z)

                if (not v.bucket or curbucket == v.bucket) and isOnScreen and not (CurrentEvidence and v.evidenceId == CurrentEvidence.evid) then

                    if not v.boneindex then DrawMarker(28, drawcoords.x, drawcoords.y, drawcoords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.size, v.size, v.size, v.color.r, v.color.g, v.color.b, camopac, false, false, 2, nil, nil, false) end

                    if v.norm then
                        if not v.netev then
                            DrawLine(drawcoords.x, drawcoords.y, drawcoords.z, v.norm.x, v.norm.y, v.norm.z, v.color.r, v.color.g, v.color.b, camopac)
                        else
                            local normoffset = GetOffsetFromEntityInWorldCoords(v.entity, v.norm.x, v.norm.y, v.norm.z)
                            DrawLine(drawcoords.x, drawcoords.y, drawcoords.z, normoffset.x, normoffset.y, normoffset.z, v.color.r, v.color.g, v.color.b, camopac)
                        end
                    end
                    if  i ~= camlim + 1 and v.distance > cammin then
                        DrawText3D(drawcoords.x, drawcoords.y, drawcoords.z, v.tag)
                        i = i + 1
                    end
                end
            end
        end
    end
end)

-- optimized camera check, passes evidence into camera evidence table to reduce amount of distance checking being done by the camera

CreateThread(function()
    while true do
        Wait(1000)
        if LocalPlayer.state.isLoggedIn then
            if Config.Debug.ViewEvidence.enabled or PlayerData.job.name == 'police' then
                if (Config.Debug.ViewEvidence.enabled or IsPedUsingScenario(GetPlayerPed(-1),"WORLD_HUMAN_PAPARAZZI")) and not IsPedInAnyVehicle(ped) then
                    policecamera = true
                    CamEvidence = {}
                    local camId = 1
                    for k, v in pairs(AreaEvidence) do
                        if v.distance < camdist then
                            CamEvidence[camId] = {
                                evidenceId = k,
                                distance = v.distance,
                                tag = v.tag,
                                color = v.color,
                                size = v.size,
                                coords = {
                                    x = v.coords.x,
                                    y = v.coords.y,
                                    z = v.coords.z
                                },
                                norm = v.norm,
                            }
                            camId = camId + 1
                        end
                    end
                    for k, v in pairs(AreaNetEvidence) do
                        if v.distance < camdist then
                            CamEvidence[camId] = {
                                evidenceId = k,
                                distance = v.distance,
                                tag = v.tag,
                                color = v.color,
                                netev = v.netev,
                                entity = v.entity,
                                size = v.size,
                                boneindex = v.boneindex,
                                coords = v.coords,
                                norm = v.norm,
                            }
                            camId = camId + 1
                        end
                    end
                    table.sort(CamEvidence, function(a, b)
                        return a.distance < b.distance
                    end)
                else
                    policecamera = false
                end
            else
                Wait(2000)
            end
        else
            Wait(5000)
        end
    end
end)