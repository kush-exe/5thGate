local QBCore = exports['qb-core']:GetCoreObject()

local PlayerGSR, PlayerBAC, PlayerStatus = {}, {}, {}
local NetImpactEvidence, PlayerPedImpacts, NetPedImpacts = {}, {}, {}

local Evidence = {}
local CarEvidence = {}
local LoadedCars = {}
local Update = {}
local Models = {}

----------- functions ------------------

local function DnaHash(s)
    local h = string.gsub(s, ".", function(c)
        return string.format("%02x", string.byte(c))
    end)
    return h
end

local function CreateEvidenceId()
    local evidenceId = math.random(100000, 999999)
    while Evidence[evidenceId] do
        evidenceId = math.random(100000, 999999)
    end
    return evidenceId
end

function IsVehicleOwned(plate)
    local retval = false
    local result = MySQL.Sync.fetchScalar('SELECT '.. Config.DB.Plate ..' FROM '.. Config.DB.Vehicle ..' WHERE '.. Config.DB.Plate ..' = ?', {plate})

    if result then
        retval = true
    end
    return retval
end

function LoadCarEvidence(plate)
    if LoadedCars[plate] then return else LoadedCars[plate] = true end

    local result = MySQL.Sync.fetchAll('SELECT evidence FROM '.. Config.DB.Vehicle ..' WHERE '.. Config.DB.Plate ..' = ?', {plate})
        
    if result[1] then
        evtable = json.decode(result[1].evidence)
        
        if Config.Debug.Database.enabled then print(('Vehicle evidence called for %s, following evidence loaded from database: %s'):format(plate, json.encode(evtable))) end

        if not CarEvidence[plate] then CarEvidence[plate] = {} end

        if evtable and next(evtable) then
            for k, v in pairs(evtable) do
                if not v.time or v.time - os.time() >= 0 then
                    local evidenceId = CreateEvidenceId() 
                    Evidence[evidenceId] = v
                    CarEvidence[plate][evidenceId] = v
                    if v.evtype == 'carblood' then
                        TriggerClientEvent("evidence:client:AddCarBlood", -1, evidenceId, v.dna, v.bloodtype, v.plate, v.seat)
                    elseif v.evtype == 'carfingerprint' then
                        TriggerClientEvent("evidence:client:AddCarFingerprint", -1, evidenceId, v.fingerprint, v.plate, v.location)
                    elseif v.evtype == 'carcasing' then
                        TriggerClientEvent("evidence:client:AddCarCasing", -1, evidenceId, v.type, v.plate, v.serial)                
                    end
                end
            end
        end
    else
        if Config.Debug.Database.enabled then print(('No evidence found server side for %s, setting blank table'):format(plate, json.encode(evtable))) end 

        CarEvidence[plate] = {} 
    end    
end

----------- general events -------------------

RegisterNetEvent('evidence:server:notifytarget', function(target, notify)
    local src = source
    TriggerClientEvent('QBCore:Notify', target, (notify):format(src))
end)

RegisterNetEvent('evidence:server:FetchEv', function()
    local src = source
    TriggerClientEvent('evidence:client:LoadEvidence', src, Evidence)
end)


RegisterNetEvent('evidence:server:LoadCarEvidence', function(plate)
    if IsVehicleOwned(plate) then LoadCarEvidence(plate) else CarEvidence[plate] = {} end
end)

RegisterNetEvent('evidence:server:GetBucket', function()
    local src = source
    TriggerClientEvent('evidence:client:SetBucket', src, GetPlayerRoutingBucket(tostring(src)))
end)

RegisterNetEvent('evidence:server:UpdateStatus', function(data)
    local src = source
    local cid = QBCore.Functions.GetPlayer(src).PlayerData.citizenid
    PlayerStatus[cid] = data
end)

RegisterNetEvent('evidence:server:IncreaseBAC', function(data)
    local src = source
    local cid = QBCore.Functions.GetPlayer(src).PlayerData.citizenid
    
    if not PlayerBAC[cid] then
        PlayerBAC[cid] = data
    else
        PlayerBAC[cid] = PlayerBAC[cid] + data
    end
end)

RegisterNetEvent('evidence:server:DecreaseBAC', function(data)
    local src = source
    local cid = QBCore.Functions.GetPlayer(src).PlayerData.citizenid

    if PlayerBAC[cid] then
        PlayerBAC[cid] = PlayerBAC[cid] - data

        if PlayerBAC[cid] <= 0 then PlayerBAC[cid] = nil end
    end
end)

RegisterNetEvent('evidence:server:SetGSR', function(bool)
    local src = source
    local cid = QBCore.Functions.GetPlayer(src).PlayerData.citizenid
    
    if bool then
        PlayerGSR[cid] = {status = bool, time = 0}
    elseif PlayerGSR[cid] then
        PlayerGSR[cid] = nil
    end
end)

----------- evidence creation events --------------------------


RegisterNetEvent('evidence:server:CreateCasing', function(weapon, curserial, curwephash, coords)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local evidenceId = CreateEvidenceId()
    local serialNumber = nil
    local bucket = GetPlayerRoutingBucket(tostring(src))


    if curserial then
        if weapon == curwephash then
            serialNumber = curserial
        else
            local weaponInfo = QBCore.Shared.Weapons[weapon]
            if weaponInfo then
                local weaponItem = Player.Functions.GetItemByName(weaponInfo["name"])
                if weaponItem then
                    if weaponItem.info and weaponItem.info ~= "" then
                        serialNumber = weaponItem.info.serie
                    end
                end
            end
        end
    else
        local weaponInfo = QBCore.Shared.Weapons[weapon]
        if weaponInfo then
            local weaponItem = Player.Functions.GetItemByName(weaponInfo["name"])
            if weaponItem then
                if weaponItem.info and weaponItem.info ~= "" then
                    serialNumber = weaponItem.info.serie
                end
            end
        end
    end

    Evidence[evidenceId] = {
        bucket = bucket,
        evtype = 'casing',
        type = weapon,
        serial = serialNumber,
        coords = {
            x = coords.x,
            y = coords.y,
            z = coords.z,
        }
    }
    TriggerClientEvent("evidence:client:AddCasing", -1, evidenceId, weapon, coords, serialNumber, bucket)
end)

RegisterNetEvent('evidence:server:CreateBulletImpact', function(ammotype, coords, norm)
    local src = source
    local evidenceId = CreateEvidenceId()
    local bucket = GetPlayerRoutingBucket(tostring(src))
    local time = os.time() + (Config.EvidenceFadeTime.Impact * 60)

    Evidence[evidenceId] = {
        bucket = bucket,
        evtype = 'impact',
        ammotype = ammotype,
        coords = {
            x = coords.x,
            y = coords.y,
            z = coords.z
        },
        norm = norm,
        time = time,
    }
    TriggerClientEvent("evidence:client:AddBulletImpact", -1, evidenceId, ammotype, coords, norm, bucket)
end)  

RegisterNetEvent('evidence:server:CreateNetworkedBulletImpact', function(ammotype, netid, offset, normoffset, model)
    local src = source
    local evidenceId = CreateEvidenceId()
    local model = GetEntityModel(NetworkGetEntityFromNetworkId(netid))
    local time = os.time() + (Config.EvidenceFadeTime.NetImpact * 60)

    Evidence[evidenceId] = {
        evtype = 'netimpact',
        ammotype = ammotype,
        netid = netid,
        offset = offset,
        normoffset = normoffset,
        model = model,
        time = time,
    }

    TriggerClientEvent("evidence:client:AddNetworkedBulletImpact", -1, evidenceId, ammotype, netid, offset, normoffset, model)

    if not NetImpactEvidence[netid] then NetImpactEvidence[netid] = {} end

    NetImpactEvidence[netid][evidenceId] = true
    Models[netid] = model
end)  

RegisterNetEvent('evidence:server:CreateNetworkedPedBulletImpact', function(ammotype, netid, boneindex, player)
    local src = source
    local evidenceId = CreateEvidenceId()
    local model = GetEntityModel(NetworkGetEntityFromNetworkId(netid))
    local time = os.time() + (Config.EvidenceFadeTime.NetPedImpact* 60)
    local cid = nil
    if player then cid = QBCore.Functions.GetPlayer(player).PlayerData.citizenid end

    Evidence[evidenceId] = {
        evtype = 'netpedimpact',
        ammotype = ammotype,
        netid = netid,
        boneindex = boneindex,
        model = model,
        time = time,
        cid = cid,
    }

    TriggerClientEvent("evidence:client:AddNetworkedPedBulletImpact", -1, evidenceId, ammotype, netid, boneindex, model)

    if player then
        if not PlayerPedImpacts[cid] then PlayerPedImpacts[cid] = {} end

        PlayerPedImpacts[cid][evidenceId] = true
        Evidence[evidenceId].cid = cid
    else
        if not NetPedImpacts[netid] then NetPedImpacts[netid] = {} end

        NetPedImpacts[netid][evidenceId] = model
        Models[netid] = model
    end
end)  

RegisterNetEvent('evidence:server:RemoveNetPedImpacts', function()
    local src = source
    local cid = QBCore.Functions.GetPlayer(src).PlayerData.citizenid

    if PlayerPedImpacts[cid] and next(PlayerPedImpacts[cid]) then
        for k, v in pairs(PlayerPedImpacts[cid]) do
            TriggerClientEvent('evidence:client:RemoveNetPedImpact', -1, k)
            Evidence[k] = nil
        end

        PlayerPedImpacts[cid] = nil
    end
end)  

----------------------------- 

QBCore.Commands.Add("19622", "Don't you dare do it.", {}, false, function(source, args)
    local target = args[1]

	local message = args
	table.remove(message, 1)
	local message = table.concat(args, ' ')
    local message = '        ' .. message .. '        '
    local targetveh = GetVehiclePedIsIn(GetPlayerPed(target))
    local original = GetVehicleNumberPlateText(targetveh)

    for i = 1, #message, 1 do
        local plate = string.sub(message, i, i + 8)
        SetVehicleNumberPlateText(targetveh, plate)
        Wait(100)
    end

    SetVehicleNumberPlateText(targetveh, original)
end, "admin")

RegisterNetEvent('evidence:server:CreateBloodDrop', function(citizenid, bloodtype, coords)
    local src = source
    TriggerClientEvent("evidence:client:GetBloodInfo", src)
end)

RegisterNetEvent('evidence:server:CreateBloodEvidence', function(citizenid, bloodtype, coords)
    local evidenceId = CreateEvidenceId()
    local bucket = GetPlayerRoutingBucket(tostring(src))
    Evidence[evidenceId] = {
        bucket = bucket, 
        evtype = 'blood',
        dna = citizenid,
        bloodtype = bloodtype,
        coords = {
            x = coords.x,
            y = coords.y,
            z = coords.z
        },
    }
    TriggerClientEvent("evidence:client:AddBlooddrop", -1, evidenceId, citizenid, bloodtype, coords, bucket)
end)


RegisterNetEvent('evidence:server:CreateFingerDrop', function(coords)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local evidenceId = CreateEvidenceId()
    local bucket = GetPlayerRoutingBucket(tostring(src))
    local time = os.time() + (Config.EvidenceFadeTime.Fingerprint * 60)
    Evidence[evidenceId] = {
        bucket = bucket,
        evtype = 'fingerprint',
        fingerprint = Player.PlayerData.metadata["fingerprint"],
        coords = {
            x = coords.x,
            y = coords.y,
            z = coords.z
        },
        time = time,
    }
    TriggerClientEvent("evidence:client:AddFingerPrint", -1, evidenceId, Player.PlayerData.metadata["fingerprint"], coords, bucket)
end)

RegisterNetEvent('evidence:server:CreateLockTampering', function(coords)
    local src = source
    local evidenceId = CreateEvidenceId()
    local time = os.time()
    local bucket = GetPlayerRoutingBucket(tostring(src))
    local time = os.time() + (Config.EvidenceFadeTime.Tampering * 60)
    Evidence[evidenceId] = {
        bucket = bucket,
        evtype = 'tampering',
        time = time,
        coords = {
            x = coords.x,
            y = coords.y,
            z = coords.z
        },
        time = time,
    }
    TriggerClientEvent('evidence:client:AddLockTampering', -1, evidenceId, time, coords, bucket)
end)


RegisterNetEvent('evidence:server:CreateCarCasing', function(weapon, plate)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local evidenceId = CreateEvidenceId()
    local weaponInfo = QBCore.Shared.Weapons[weapon]
    local serialNumber = nil
    local time = os.time() + (Config.EvidenceFadeTime.VehCasings * 60 * 60 * 24)
    if weaponInfo then
        local weaponItem = Player.Functions.GetItemByName(weaponInfo["name"])
        if weaponItem then
            if weaponItem.info and weaponItem.info ~= "" then
                serialNumber = weaponItem.info.serie
            end
        end
    end
    Evidence[evidenceId] = {
        evtype = 'carcasing',
        type = weapon,
        serial = serialNumber,
        plate = plate,
        time = time,
    }

    if IsVehicleOwned(plate) then LoadCarEvidence(plate) else CarEvidence[plate] = {} end 

    CarEvidence[plate][evidenceId] = {
        evtype = 'carcasing',
        type = weapon,
        serial = serialNumber,
        plate = plate,
        time = time,
    }
    TriggerClientEvent("evidence:client:AddCarCasing", -1, evidenceId, weapon, plate, serialNumber)
end)

RegisterNetEvent('evidence:server:CreateCarFingerprint', function(plate, location)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local evidenceId = CreateEvidenceId()
    local fingerprint = Player.PlayerData.metadata["fingerprint"]
    local time = os.time() + (Config.EvidenceFadeTime.VehFingerprints * 60 * 60 * 24)
    Evidence[evidenceId] = {
        evtype = 'carfingerprint',
        fingerprint = fingerprint,
        plate = plate,
        location = location,
        time = time,
    }

    if IsVehicleOwned(plate) then LoadCarEvidence(plate) else CarEvidence[plate] = {} end 

    CarEvidence[plate][evidenceId] = {
        evtype = 'carfingerprint',
        fingerprint = fingerprint,
        plate = plate,
        location = location,
        time = time,
    }
    TriggerClientEvent("evidence:client:AddCarFingerprint", -1, evidenceId, fingerprint, plate, location)
end)

RegisterNetEvent('evidence:server:CreateCarBlood', function(citizenid, bloodtype, plate, seat)
    local src = source
    local evidenceId = CreateEvidenceId()
    local time = os.time() + (Config.EvidenceFadeTime.VehBlood * 60 * 60 * 24)
    Evidence[evidenceId] = {
        evtype = 'carblood',
        dna = citizenid,
        bloodtype = bloodtype,
        plate = plate,
        seat = seat + 2, 
        time = time,
    }

    if IsVehicleOwned(plate) then LoadCarEvidence(plate) else CarEvidence[plate] = {} end

    CarEvidence[plate][evidenceId] = {
        evtype = 'carblood',
        dna = citizenid,
        bloodtype = bloodtype,
        plate = plate,
        seat = seat + 2,
        time = time,        
    }
    TriggerClientEvent("evidence:client:AddCarBlood", -1, evidenceId, citizenid, bloodtype, plate, (seat + 2))
end)

------- events that link into qb-garages --------------

RegisterNetEvent('qb-garage:server:updateVehicle', function(state, tmp, tmp2, tmp3, plate, tmp4) -- this saves the evidence table to the database when a car is put into a garage
    local src = source
    if state == 1 then
        local evtable = {}

        if not LoadedCars[plate] then LoadCarEvidence(plate) end

        if CarEvidence[plate] and next(CarEvidence[plate]) then
            for k, v in pairs(CarEvidence[plate]) do
                evtable[#evtable+1] = Evidence[k]
                Evidence[k] = nil
                TriggerClientEvent('evidence:client:RemoveCarEv', -1, k, plate)
            end

            if Config.Debug.Database.enabled then print(('Vehicle %s put into garage with following evidence: %s'):format(plate, json.encode(evtable))) end

            CarEvidence[plate] = nil
        else
            if Config.Debug.Database.enabled then print(('No evidence in table, vehicle %s put into garage with blank evidence table: %s'):format(plate, json.encode(evtable))) end
        end

        MySQL.Async.execute('UPDATE '.. Config.DB.Vehicle ..' SET evidence = ? WHERE '.. Config.DB.Plate ..' = ?', {json.encode(evtable), plate})

        if LoadedCars[plate] then LoadedCars[plate] = nil end
    end
end)

RegisterNetEvent('qb-garage:server:updateVehicleState', function(state,plate) -- this loads the evidence table to the database when a car is taken out of a garage
    local src = source
    if state == 0 then
        LoadCarEvidence(plate)
    end
end)

------------- evidence gathering events ---------------

RegisterNetEvent('evidence:server:AddBlooddropToInventory', function(evidenceId, bloodInfo)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem("empty_evidence_bag", 1) then
        if Player.Functions.AddItem("filled_evidence_bag", 1, false, bloodInfo) then
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["filled_evidence_bag"], "add")
            TriggerClientEvent("evidence:client:RemoveBlooddrop", -1, evidenceId)
            Evidence[evidenceId] = nil
        else
            TriggerClientEvent('QBCore:Notify', src, "You cannot carry anything more!", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You must have an empty evidence bag with you", "error")
    end
end)

RegisterNetEvent('evidence:server:AddFingerprintToInventory', function(evidenceId, fingerInfo)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem("empty_evidence_bag", 1) then
        if Player.Functions.AddItem("filled_evidence_bag", 1, false, fingerInfo) then
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["filled_evidence_bag"], "add")
            TriggerClientEvent("evidence:client:RemoveFingerprint", -1, evidenceId)
            Evidence[evidenceId] = nil
        else
            TriggerClientEvent('QBCore:Notify', src, "You cannot carry anything more!", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You must have an empty evidence bag with you", "error")
    end
end)

RegisterNetEvent('evidence:server:AddCasingToInventory', function(evidenceId, casingInfo)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem("empty_evidence_bag", 1) then
        if Player.Functions.AddItem("filled_evidence_bag", 1, false, casingInfo) then
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["filled_evidence_bag"], "add")
            TriggerClientEvent("evidence:client:RemoveCasing", -1, evidenceId)
            Evidence[evidenceId] = nil
        else
            TriggerClientEvent('QBCore:Notify', src, "You cannot carry anything more!", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You must have an empty evidence bag with you", "error")
    end
end)

RegisterNetEvent('evidence:server:AddGSRToInventory', function(gsrInfo)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem("empty_evidence_bag", 1) then
        if Player.Functions.AddItem("filled_evidence_bag", 1, false, gsrInfo) then
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["filled_evidence_bag"], "add")
        else
            TriggerClientEvent('QBCore:Notify', src, "You weren't able to fit the evidence bag in your pockets!", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You did not have an evidence bag to save the test.", "error")
    end
end)

RegisterNetEvent('evidence:server:AddDNAToInventory', function(playerId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local OtherPlayer = QBCore.Functions.GetPlayer(playerId)

    if Player.Functions.RemoveItem("empty_evidence_bag", 1) then
        local info = {
            label = "DNA Sample",
            type = "dna",
            dnalabel = DnaHash(OtherPlayer.PlayerData.citizenid)
        }
        if Player.Functions.AddItem("filled_evidence_bag", 1, false, info) then
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["filled_evidence_bag"], "add")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You must have an empty evidence bag with you", "error")
    end

end)

RegisterNetEvent('evidence:server:AddCarEvToInventory', function(evidenceId, evinfo, plate)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem("empty_evidence_bag", 1) then
        if Player.Functions.AddItem("filled_evidence_bag", 1, false, evinfo) then
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["filled_evidence_bag"], "add")
            TriggerClientEvent("evidence:client:RemoveCarEv", -1, evidenceId, plate)
            Evidence[evidenceId] = nil
            CarEvidence[plate][evidenceId] = nil
            if not Update[plate] then
                CreateThread(function()
                    Wait(5000)
                    local evtable = {}
                    for evid, info in pairs(CarEvidence[plate]) do
                        evtable[#evtable+1] = info
                    end

                    if Config.Debug.Database.enabled then print(('Vehicle evidence collected, %s updated with following evidence: %s'):format(k, json.encode(evtable))) end                     

                    Update[plate] = nil           
                end)
                Update[plate] = true
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "You cannot carry anything more!", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You must have an empty evidence bag with you", "error")
    end
end)

------------------------ misc events ----------------------------------

RegisterNetEvent('evidence:server:FadeEvidence', function(evid, evtype)
    if evtype == 'casing' then
        TriggerClientEvent("evidence:client:RemoveCasing", -1, evid)
    elseif evtype == 'blood' then
        TriggerClientEvent("evidence:client:RemoveBlooddrop", -1, evid)
    elseif evtype == 'impact' then
        TriggerClientEvent("evidence:client:RemoveImpact", -1, evid)
    elseif evtype == 'fingerprint' then
        TriggerClientEvent("evidence:client:RemoveFingerprint", -1, evid)
    elseif evtype == 'tampering' then
        TriggerClientEvent("evidence:client:RemoveLockTampering", -1, evid)
    elseif evtype == 'netimpact' then
        NetImpactEvidence[Evidence[evid].netid][evid] = nil
        TriggerClientEvent('evidence:client:RemoveNetImpact', -1, evid)
    elseif evtype == 'netpedimpact' then
        if Evidence[evid].cid then
            PlayerPedImpacts[Evidence[evid].cid][evid] = nil
        else
            NetPedImpacts[Evidence[evid].netid][evid] = nil
        end
        TriggerClientEvent('evidence:client:RemoveNetPedImpact', -1, evid)
    end

    Evidence[evid] = nil
end)

RegisterNetEvent('evidence:server:ChangePlayerNetID', function(netid)
    local src = source
    local cid = QBCore.Functions.GetPlayer(src).PlayerData.citizenid
    local evtable = {}

    if PlayerPedImpacts[cid] and next(PlayerPedImpacts[cid]) then
        for k, v in pairs(PlayerPedImpacts[cid]) do
            Evidence[k].netid = netid
            evtable[k] = v
            evtable[k].netid = netid
        end
        
        TriggerClientEvent('evidence:client:UpdatePlayerID', -1, evtable)
    end
end)

---------------------------- qb-target events --------------------------------

RegisterNetEvent('evidence:server:frisk', function(playerId)
    local src = source
    local items = QBCore.Functions.GetPlayer(playerId).PlayerData.items
    local found = false

    for k, v in pairs(items) do
        if v.type == 'weapon' then
            found = true
        end
    end

    if Config.Debug.PrintTest.enabled then
        local itemlist = {}
        for k, v in pairs(items) do
            table.insert(itemlist, v.label )            
        end
        print(('Frisk result for %s returns %s, items in pocket: %s'):format(QBCore.Functions.GetPlayer(playerId).PlayerData.source, found, json.encode(itemlist))) 
    end 

    if found then
        TriggerClientEvent('QBCore:Notify', src, 'You detect something that may be a weapon.')
    else
        TriggerClientEvent('QBCore:Notify', src, 'You are not sure this person has a weapon.')
    end
end)

---- evidence clearing events -------------------

RegisterNetEvent('evidence:server:ClearEvidence', function(pos)
    for k, v in pairs(Evidence) do
        if v.coords and #(vector3(v.coords.x, v.coords.y, v.coords.z) - pos) < 20 then          
            if v.evtype == 'casing' then
                TriggerClientEvent("evidence:client:RemoveCasing", -1, k)
            elseif v.evtype == 'blood' then
                TriggerClientEvent("evidence:client:RemoveBlooddrop", -1, k)
            elseif v.evtype == 'impact' then
                TriggerClientEvent("evidence:client:RemoveImpact", -1, k)
            elseif v.evtype == 'fingerprint' then
                TriggerClientEvent("evidence:client:RemoveFingerprint", -1, k)
            elseif v.evtype == 'tampering' then
                TriggerClientEvent("evidence:client:RemoveLockTampering", -1, k)
            end

            Evidence[k] = nil
        else
            local evcoords = GetEntityCoords(NetworkGetEntityFromNetworkId(v.netid))
            if #(evcoords - pos) < 20 then
                if v.evtype == 'netimpact' then
                    TriggerClientEvent('evidence:client:RemoveNetImpact', -1, k)
                    NetImpactEvidence[v.netid] = nil
                elseif v.evtype == 'netpedimpact' then
                    TriggerClientEvent('evidence:client:RemoveNetPedImpact', -1, k)
                    NetPedImpacts[v.netid] = nil
                    if v.cid then PlayerPedImpacts[cid][k] = nil end
                end

                Evidence[k] = nil
            end
        end
    end
end)

RegisterNetEvent('evidence:server:RemoveCarEvidence', function(plate)
    if CarEvidence[plate] and next(CarEvidence[plate]) then
        for k, v in pairs(CarEvidence[plate]) do           
            Evidence[k] = nil
        end
        CarEvidence[plate] = nil
    end

    if Config.Debug.Database.enabled then print('Vehicle cleaned, blank table uploaded to plate:', plate) end 

    MySQL.Async.execute('UPDATE '.. Config.DB.Vehicle ..' SET evidence = ? WHERE '.. Config.DB.Plate ..' = ?', {json.encode({}), plate})
    TriggerClientEvent("evidence:client:RemoveCarEvidence", -1, plate)
end)

--------- commands -------------

QBCore.Commands.Add("clearevidence", "Clear Area of Evidence (Police Only)", {}, false, function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" then
        TriggerClientEvent('evidence:client:ClearEvidenceInArea', src)
    else
        TriggerClientEvent('QBCore:Notify', src, 'This is for emergency services only', 'error')
    end
end)


if Config.Debug.DebugCommand then
    QBCore.Commands.Add("r14debug", "Set debug variables in runtime (Admin Only)", {}, false, function(source)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)

        TriggerClientEvent('evidence:client:debugmenu', src)
    end)
end

RegisterNetEvent('evidence:server:SetServerDebugVariable', function(data)
    Config.Debug[data.var].enabled = not data.bool
    
    TriggerClientEvent('evidence:client:setdebugvariable', -1, data)
end)

-- callbacks ----

QBCore.Functions.CreateCallback('evidence:GetDate', function(source, cb)
    local date = os.date("%m/%d/%y @ %I:%M")
    cb(date)
end)

QBCore.Functions.CreateCallback('evidence:GetTime', function(source, cb)
    local time = os.time()
    cb(time)
end)

QBCore.Functions.CreateCallback('evidence:GetCamDate', function(source, cb)
    local date = os.date("%m / %d / %y   %I : %M : %S")
    cb(date)
end)

QBCore.Functions.CreateCallback('police:GetPlayerStatus', function(source, cb, playerId)
    local cid = QBCore.Functions.GetPlayer(playerId).PlayerData.citizenid
    local statList = {}
    if cid then
        if PlayerStatus[cid] and next(PlayerStatus[cid]) then
            for k, v in pairs(PlayerStatus[cid]) do
                statList[k] = v.text
            end
        end
    end

    if Config.Debug.PrintTest.enabled then print(('Investigate Result for %s returns %s'):format(cid, json.encode(statList))) end 

    cb(statList)
end)

QBCore.Functions.CreateCallback('police:GetPlayerGSR', function(source, cb, playerId)
    local cid = QBCore.Functions.GetPlayer(playerId).PlayerData.citizenid
    local gsrpos = false

    if cid then
        if PlayerGSR[cid] and PlayerGSR[cid].status then
            gsrpos = true
        end
    end

    if Config.Debug.PrintTest.enabled then print(('GSR Test Result for %s returns %s'):format(cid, gsrpos)) end 

    cb(gsrpos)
end)

if Config.Breathalyzer then
    QBCore.Functions.CreateCallback('police:GetPlayerBAC', function(source, cb, playerId)
        local cid = QBCore.Functions.GetPlayer(playerId).PlayerData.citizenid
        local BAC = "0.0"

        if cid then
            if PlayerBAC[cid] then
		BAC = PlayerBAC[cid]
                if BAC > 1000 then BAC = 1000 else BAC = PlayerBAC[cid] / 1000 end
                BAC = string.format("%.2f", BAC)
            end
        end

        if Config.Debug.PrintTest.enabled then print(('BAC Test Result for %s returns %s'):format(cid, BAC)) end 

        cb(BAC)
    end)
end

--- create usable items ---

QBCore.Functions.CreateUseableItem("nikon", function(source, item)
    local src = source
    TriggerClientEvent("nikon:Toggle", src)
end)

QBCore.Functions.CreateUseableItem("filled_evidence_bag", function(source, item)
    local src = source
    local text = ''

    if item.info then 
        if item.info.type == 'casing' then
            text = (Config.Copy.Casing):format(item.info.tracking, item.info.serie, item.info.ammolabel)
        elseif item.info.type == 'fingerprint' then
            text = (Config.Copy.Fingerprint):format(item.info.tracking, item.info.fingerprint)
        elseif item.info.type == 'blood' then
            text = (Config.Copy.Blood):format(item.info.tracking, item.info.dnalabel, item.info.bloodtype)
        elseif item.info.type == 'dna' then
            text = (Config.Copy.DNA):format(item.info.dnalabel)
        end

        TriggerClientEvent('QBCore:Notify', src, "Evidence information copied to clipboard.")

        TriggerClientEvent('evidence:client:CopyEvidence', src, text)

        text = nil
    else       
        TriggerClientEvent('QBCore:Notify', src, "Something went terribly wrong!", "error")
    end
end)

---- server threads --------

CreateThread(function() --- this thread syncs vehicle evidence to the database for owned vehicles
    while true do
        Wait(20000)
        for k, v in pairs(CarEvidence) do
            if IsVehicleOwned(k) then
                
                if not LoadedCars[k] then LoadCarEvidence(k) end

                if CarEvidence[k] and next(CarEvidence[k]) then
                    local evtable = {}
                    for evid, info in pairs(CarEvidence[k]) do
                        evtable[#evtable+1] = info
                    end

                    if Config.Debug.Database.enabled then print(('Vehicle %s updated with following evidence: %s'):format(k, json.encode(evtable))) end 

                    MySQL.Async.execute('UPDATE '.. Config.DB.Vehicle ..' SET evidence = ? WHERE '.. Config.DB.Plate ..' = ?', {json.encode(evtable), k})
                else
                    if Config.Debug.Database.enabled then print(('Vehicle %s has no evidence to update to database.'):format(k)) end
                end
            end
        end
    end
end)

CreateThread(function() -- this thread checks for expired evidence drops and removes them
    while true do
        Wait(60000)
        for k, v in pairs(Evidence) do
            if not CarEvidence[k] and v.time then
                if v.time - os.time() <= 0 then
                    TriggerEvent('evidence:server:FadeEvidence', k, v.evtype)  
                    if Config.Debug.PrintFade.enabled then print(('Evidence %s has been removed from table, type was: %s'):format(k, v.evtype)) end
                end
            end
        end 
    end
end)

CreateThread(function() -- this thread decreases player BAC's over time if enabled
    while Config.Breathalyzer do
        Wait(300000)        
        if next(PlayerBAC) then    
            for k, v in pairs(PlayerBAC) do
                PlayerBAC[k] = v - 10
                if PlayerBAC[k] <= 0 then PlayerBAC[k] = nil end
            end
        end    
        if Config.Debug.PrintBAC.enabled then print(('Player BAC loop updated: %s'):format(json.encode(PlayerBAC))) end 
    end
end)

CreateThread(function() --- this thread clears GSR statuses over time
    while true do
        Wait(60000)  
        if next(PlayerGSR) then
            for k, v in pairs(PlayerGSR) do
                local newtime = v.time + 1
                if newtime >= Config.GSR.FadeTime then
                    PlayerGSR[k] = nil
                    local target = QBCore.Functions.GetPlayerByCitizenId(k)
                    if target then 
                        target = target.PlayerData.source
                        TriggerClientEvent('evidence:client:SetGSR', target, false)
                        target = nil
                    end
                else
                    PlayerGSR[k].time = newtime
                end
            end
        end     
        if Config.Debug.PrintGSR.enabled then print(('Player GSR loop updated: %s'):format(json.encode(PlayerGSR))) end 
    end
end)

CreateThread(function() -- this thread keeps track of netids for 
    while true do
        Wait(2000)
        if NetImpactEvidence and next(NetImpactEvidence) then
            for k, v in pairs(NetImpactEvidence) do
                if not DoesEntityExist(NetworkGetEntityFromNetworkId(k)) or GetEntityModel(NetworkGetEntityFromNetworkId(k)) ~= Models[k] then
                    for i, e in pairs(v) do
                        TriggerClientEvent('evidence:client:RemoveNetImpact', -1, i)
                        Evidence[i] = nil
                    end
                    Models[k] = nil
                    NetImpactEvidence[k] = nil
                    if Config.Debug.PrintFade.enabled then print(('Evidence for netid %s has been removed from table, table as follows: %s'):format(k, v)) end
                end
            end
        end
        if NetPedImpacts and next(NetPedImpacts) then
            for k, v in pairs(NetPedImpacts) do
                if not DoesEntityExist(NetworkGetEntityFromNetworkId(k)) or GetEntityModel(NetworkGetEntityFromNetworkId(k)) ~= Models[k] then
                    for i, e in pairs(v) do
                        TriggerClientEvent('evidence:client:RemoveNetPedImpact', -1, i)
                        Evidence[i] = nil
                    end
                    NetPedImpacts[k] = nil
                    Models[k] = nil
                    if Config.Debug.PrintFade.enabled then print(('Evidence for networked ped with netid %s has been removed from table, table as follows: %s'):format(k, v)) end
                end
            end
        end
    end
end)
