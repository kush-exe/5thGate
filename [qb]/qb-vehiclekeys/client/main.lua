local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}

local QBCore = exports['qb-core']:GetCoreObject()

local HasKey = false
local LastVehicle = nil
local IsHotwiring = false
local IsRobbing = false
local isLoggedIn = false
local NeededAttempts = 0
local SucceededAttempts = 0
local FailedAttemps = 0
local AlertSend = false
local drawnHotWire = false
local ped = nil


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(250) -- this needs to be low to stop car from "jerking" when turning on and off
        local veh = GetVehiclePedIsIn(ped, false)

        if veh ~= nil and GetPedInVehicleSeat(GetVehiclePedIsIn(ped, false), -1) == ped then
            if GetIsVehicleEngineRunning(veh) then
                HasKey = true
            else
                local plate = GetVehicleNumberPlateText(veh)
                QBCore.Functions.TriggerCallback('vehiclekeys:CheckHasKey', function(result)
                    if result then
                        HasKey = true
                    
                    else
                        HasKey = false
                    end
                end, plate)
            end

            if not HasKey then
                local veh = GetVehiclePedIsIn(ped, false)
                SetVehicleEngineOn(veh, false, false, true)
            end
        end
    end
end)


function drawHotWire(x, y, z)
    if drawnHotWire == false then
        QBCore.Functions.DrawText3D(x, y, z, "~g~H~w~ - Hotwire")
    end
end

RegisterCommand('+lockvehicle', function()
    if not IsPedInAnyVehicle(ped) then
        LockVehicle()
    end
end, false)


RegisterKeyMapping('+lockvehicle', 'Lock/Unlock Vehicle with Key', 'keyboard', 'l')

RegisterCommand('+engine', function()
    TriggerEvent('vehiclekeys:client:ToggleEngine')
end)

RegisterKeyMapping('+engine', 'Toggle Engine', 'keyboard', 'G')

Citizen.CreateThread(function()
    while true do
        ped = PlayerPedId()
        Citizen.Wait(500)
        if not IsRobbing then
            if GetVehiclePedIsTryingToEnter(ped) ~= nil and GetVehiclePedIsTryingToEnter(ped) ~= 0 then
                local vehicle = GetVehiclePedIsTryingToEnter(ped)
                --print('grabbign keys')
                local driver = GetPedInVehicleSeat(vehicle, -1)
                if driver ~= 0 and not IsPedAPlayer(driver) then
                    if IsEntityDead(driver) then
                        IsRobbing = true
                        QBCore.Functions.Progressbar("rob_keys", "Grabbing keys..", 3000, false, true, {}, {}, {}, {}, function() -- Done
                            TriggerServerEvent("vehiclekeys:server:SetOwner", GetVehicleNumberPlateText(vehicle), GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)):lower(), 'STOLEN')
                            HasKey = true
                            IsRobbing = false
                        end)
                    end
                end
            end

            if QBCore.Functions.GetPlayerData().job.name ~= "police" then
                local aiming, target = GetEntityPlayerIsFreeAimingAt(PlayerId())
                if aiming and (target ~= nil and target ~= 0) then
                    if DoesEntityExist(target) and not IsPedAPlayer(target) then
                        if IsPedInAnyVehicle(target, false) and not IsPedInAnyVehicle(ped, false ) then
                            if not IsBlacklistedWeapon() then
                                local pos = GetEntityCoords(ped, true)
                                local targetpos = GetEntityCoords(target, true)
                                local vehicle = GetVehiclePedIsIn(target, true)
                                if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, targetpos.x, targetpos.y, targetpos.z, true) < 13.0 then
                                    RobVehicle(target)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

RegisterNetEvent('vehiclekeys:client:SetOwner')
AddEventHandler('vehiclekeys:client:SetOwner', function(plate)
    local VehPlate = plate
    while not IsPedInAnyVehicle(ped) do Wait(500) end
    local vehicle = GetVehiclePedIsIn(ped, false)
    if VehPlate == nil then
        VehPlate = GetVehicleNumberPlateText(vehicle)
    end
    local props = QBCore.Functions.GetVehicleProperties(vehicle)
    local hash = props.model
    TriggerServerEvent('vehiclekeys:server:SetVehicleOwner', VehPlate, hash)
    if IsPedInAnyVehicle(ped) and plate == GetVehicleNumberPlateText(GetVehiclePedIsIn(ped, true)) then
        SetVehicleEngineOn(GetVehiclePedIsIn(ped, true), true, false, true)
    end
    HasKey = true

end)

RegisterNetEvent('vehiclekeys:client:GiveKeys')
AddEventHandler('vehiclekeys:client:GiveKeys', function(target)
    local plate = GetVehicleNumberPlateText(GetVehiclePedIsIn(ped, true))
    TriggerServerEvent('vehiclekeys:server:GiveVehicleKeys', plate, target)
end)

RegisterNetEvent('vehiclekeys:client:ToggleEngine')
AddEventHandler('vehiclekeys:client:ToggleEngine', function()
    local EngineOn = IsVehicleEngineOn(GetVehiclePedIsIn(ped))
    local veh = GetVehiclePedIsIn(ped, true)
    if HasKey then
        if EngineOn then
            SetVehicleEngineOn(veh, false, false, true)
        else
            SetVehicleEngineOn(veh, true, false, true)
        end
    end
end)

RegisterNetEvent('lockpicks:UseLockpick')
AddEventHandler('lockpicks:UseLockpick', function(isAdvanced)
    if (not IsPedInAnyVehicle(ped)) then
        --LockpickIgnition(isAdvanced)
        LockpickDoor(isAdvanced)
    else
        LockpickIgnition()
    end
end)
local function EnumerateEntitiesWithinDistance(entities, isPlayerEntities, coords, maxDistance)
	local nearbyEntities = {}
	if coords then
		coords = vector3(coords.x, coords.y, coords.z)
	else
		local playerPed = PlayerPedId()
		coords = GetEntityCoords(playerPed)
	end
	for k, entity in pairs(entities) do
		local distance = #(coords - GetEntityCoords(entity))
		if distance <= maxDistance then
			nearbyEntities[#nearbyEntities+1] = isPlayerEntities and k or entity
		end
	end
	return nearbyEntities
end

local function GetVehiclesInArea(coords, maxDistance) -- Vehicle inspection in designated area
	return EnumerateEntitiesWithinDistance(GetGamePool('CVehicle'), false, coords, maxDistance)
end

local function lockUsingKey(veh)
    local vehLockStatus = GetVehicleDoorLockStatus(veh)
    loadAnimDict("anim@mp_player_intmenu@key_fob@")
    TaskPlayAnim(ped, 'anim@mp_player_intmenu@key_fob@', 'fob_click', 3.0, 3.0, -1, 49, 0, false, false, false)

    if vehLockStatus == 1 then
        --QBCore.Functions.Notify("Locking Vehicle")
        Citizen.Wait(250)
        ClearPedTasks(ped)
        TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "lock", 0.3)
        SetVehicleDoorsLocked(veh, 2)
        if(GetVehicleDoorLockStatus(veh) == 2)then
            QBCore.Functions.Notify("Vehicle Locked")
        else
            QBCore.Functions.Notify("Something went wrong with the locking system!")
        end
    else
        --QBCore.Functions.Notify("Unlocking Vehicle")
        Citizen.Wait(250)
        ClearPedTasks(ped)
        TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "unlock", 0.3)
        SetVehicleDoorsLocked(veh, 1)
        if(GetVehicleDoorLockStatus(veh) == 1)then
            QBCore.Functions.Notify("Vehicle Unlocked")
        else
            QBCore.Functions.Notify("Something went wrong with the locking system!")
        end
    end

    if not IsPedInAnyVehicle(ped) then
        SetVehicleInteriorlight(veh, true)
        SetVehicleIndicatorLights(veh, 0, true)
        SetVehicleIndicatorLights(veh, 1, true)
        Citizen.Wait(450)
        SetVehicleIndicatorLights(veh, 0, false)
        SetVehicleIndicatorLights(veh, 1, false)
        Citizen.Wait(450)
        SetVehicleInteriorlight(veh, true)
        SetVehicleIndicatorLights(veh, 0, true)
        SetVehicleIndicatorLights(veh, 1, true)
        Citizen.Wait(450)
        SetVehicleInteriorlight(veh, false)
        SetVehicleIndicatorLights(veh, 0, false)
        SetVehicleIndicatorLights(veh, 1, false)
    end
end

RegisterNetEvent('vehiclekeys:client:UseKey', function(plate)
    local x = GetVehiclesInArea(GetEntityCoords(ped), 50) -- get vehicles in 50 meter radius
    for _,v in pairs(x) do
        if GetVehicleNumberPlateText(v) == plate then
            lockUsingKey(v)
        end
    end
end)



function RobVehicle(target)
    IsRobbing = true
    Citizen.CreateThread(function()
        while IsRobbing do
            print('robbing car')
            local RandWait = math.random(10000, 15000)
            loadAnimDict("random@mugging3")
            local vehicle = GetVehiclePedIsIn(target, false)
            TaskLeaveVehicle(target, GetVehiclePedIsIn(target, true), 256)
            Citizen.Wait(1000)
            ClearPedTasksImmediately(target)

            TaskStandStill(target, RandWait)
            TaskHandsUp(target, RandWait, ped, 0, false)

            Citizen.Wait(RandWait)

            TaskReactAndFleePed(target, ped)
            IsRobbing = false
            
            TriggerServerEvent("vehiclekeys:server:SetOwner", GetVehicleNumberPlateText(vehicle), GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)):lower(), 'STOLEN')

        end
    end)
end

function LockVehicle()
    local veh = QBCore.Functions.GetClosestVehicle()
    local coordA = GetEntityCoords(ped, true)
    local coordB = GetOffsetFromEntityInWorldCoords(ped, 0.0, 255.0, 0.0)
    local veh = GetClosestVehicleInDirection(coordA, coordB)
    local pos = GetEntityCoords(ped, true)
    if IsPedInAnyVehicle(ped) then
        veh = GetVehiclePedIsIn(ped)
    end
    local plate = GetVehicleNumberPlateText(veh)
    local vehpos = GetEntityCoords(veh, false)
    if veh ~= nil and GetDistanceBetweenCoords(pos.x, pos.y, pos.z, vehpos.x, vehpos.y, vehpos.z, true) < 15 then
        QBCore.Functions.TriggerCallback('vehiclekeys:CheckHasKey', function(result)
            if result then
                if HasKey then
                    local vehLockStatus = GetVehicleDoorLockStatus(veh)
                    loadAnimDict("anim@mp_player_intmenu@key_fob@")
                    TaskPlayAnim(ped, 'anim@mp_player_intmenu@key_fob@', 'fob_click', 3.0, 3.0, -1, 49, 0, false, false, false)
        
                    if vehLockStatus == 1 then
						--QBCore.Functions.Notify("Locking Vehicle")
                        Citizen.Wait(250)
                        ClearPedTasks(ped)
                        TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "lock", 0.3)
                        SetVehicleDoorsLocked(veh, 2)
                        if(GetVehicleDoorLockStatus(veh) == 2)then
                            QBCore.Functions.Notify("Vehicle Locked")
                        else
                            QBCore.Functions.Notify("Something went wrong with the locking system!")
                        end
                    else
						--QBCore.Functions.Notify("Unlocking Vehicle")
                        Citizen.Wait(250)
                        ClearPedTasks(ped)
                        TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "unlock", 0.3)
                        SetVehicleDoorsLocked(veh, 1)
                        if(GetVehicleDoorLockStatus(veh) == 1)then
                            QBCore.Functions.Notify("Vehicle Unlocked")
                        else
                            QBCore.Functions.Notify("Something went wrong with the locking system!")
                        end
                    end
        
                    if not IsPedInAnyVehicle(ped) then
                        SetVehicleInteriorlight(veh, true)
                        SetVehicleIndicatorLights(veh, 0, true)
                        SetVehicleIndicatorLights(veh, 1, true)
                        Citizen.Wait(450)
                        SetVehicleIndicatorLights(veh, 0, false)
                        SetVehicleIndicatorLights(veh, 1, false)
                        Citizen.Wait(450)
                        SetVehicleInteriorlight(veh, true)
                        SetVehicleIndicatorLights(veh, 0, true)
                        SetVehicleIndicatorLights(veh, 1, true)
                        Citizen.Wait(450)
                        SetVehicleInteriorlight(veh, false)
                        SetVehicleIndicatorLights(veh, 0, false)
                        SetVehicleIndicatorLights(veh, 1, false)
                    end
                end
            else
                QBCore.Functions.Notify('You dont have the keys of the vehicle..', 'error')
            end
        end, plate)
    end
end

local openingDoor = false
function LockpickDoor(isAdvanced)
    local vehicle = QBCore.Functions.GetClosestVehicle()
    if vehicle ~= nil and vehicle ~= 0 then
        local vehpos = GetEntityCoords(vehicle)
        local pos = GetEntityCoords(ped)
        if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, vehpos.x, vehpos.y, vehpos.z, true) < 1.5 then
            local vehLockStatus = GetVehicleDoorLockStatus(vehicle)
            if (vehLockStatus > 1) then
                local lockpickTime = math.random(15000, 30000)
                if isAdvanced then
                    lockpickTime = math.ceil(lockpickTime*0.5)
                end
                LockpickDoorAnim(lockpickTime)
                PoliceCall()
                IsHotwiring = true
                SetVehicleAlarm(vehicle, true)
                SetVehicleAlarmTimeLeft(vehicle, lockpickTime)
                QBCore.Functions.Progressbar("lockpick_vehicledoor", "breaking the door open..", lockpickTime, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function() -- Done
                    openingDoor = false
                    StopAnimTask(ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
                    IsHotwiring = false
                    if math.random(1, 100) <= 90 then
                        QBCore.Functions.Notify("Door open!")
                        TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "unlock", 0.3)
                        SetVehicleDoorsLocked(vehicle, 0)
                        SetVehicleDoorsLockedForAllPlayers(vehicle, false)
                    else
                        QBCore.Functions.Notify("Failed!", "error")
                    end
                end, function() -- Cancel
                    openingDoor = false
                    StopAnimTask(ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
                    QBCore.Functions.Notify("Failed!", "error")
                    IsHotwiring = false
                end)
            end
        end
    end
end

function LockpickDoorAnim(time)
    time = time / 1000
    loadAnimDict("veh@break_in@0h@p_m_one@")
    TaskPlayAnim(ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds" ,3.0, 3.0, -1, 16, 0, false, false, false)
    openingDoor = true
    Citizen.CreateThread(function()
        while openingDoor do
            TaskPlayAnim(ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 3.0, 3.0, -1, 16, 0, 0, 0, 0)
            Citizen.Wait(1000)
            time = time - 1
            if time <= 0 then
                openingDoor = false
                StopAnimTask(ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
            end
        end
    end)
end

function LockpickIgnition()
    if not HasKey then 
        local vehicle = GetVehiclePedIsIn(ped, true)
        if vehicle ~= nil and vehicle ~= 0 then
            if GetPedInVehicleSeat(vehicle, -1) == ped then
                --hacking vehicle
                --call the police since the vehicle is being stolen
                PoliceCall()
                
                local dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
                local anim = "machinic_loop_mechandplayer"

                --play animation
                RequestAnimDict(dict)
                while not HasAnimDictLoaded(dict) do
                    RequestAnimDict(dict)
                    Citizen.Wait(100)
                end
                TaskPlayAnim(ped, dict, anim, 8.0, 8.0, -1, 16, -1, false, false, false)

                --show hacking minigame
                TriggerEvent("mhacking:show")
				TriggerEvent("mhacking:start", math.random(4, 6), 12, HackingSuccess)
            end
        end
    end
end


function HackingSuccess(success, timeremaining)
    StopAnimTask(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
    --ClearPedTasksImmediately(ped)
    local vehicle = GetVehiclePedIsIn(ped, true)
    local luck = math.random(1,10)
    if luck < 6 then
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items['electronickit'], "remove")
		TriggerServerEvent('vehiclekeys:server:removeek')
    end
    if success then
        TriggerEvent('mhacking:hide')
        QBCore.Functions.Notify("Hacking successful!")
        HasKey = true
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
        SetVehicleEngineOn(vehicle, false, false, true)
        TriggerServerEvent('qb-hud:Server:GainStress', math.random(2, 4))
    else
		TriggerEvent('mhacking:hide')
        --QBCore.Functions.Notify("Hacking Failed!")
        HasKey = false
        SetVehicleEngineOn(vehicle, false, false, true)
        QBCore.Functions.Notify("Hacking failed!", "error")
	end
end

function Hotwire()
    drawnHotWire = false
    if not HasKey then 
        local vehicle = GetVehiclePedIsIn(ped, true)
        IsHotwiring = true
        local hotwireTime = math.random(20000, 40000)
        SetVehicleAlarm(vehicle, true)
        SetVehicleAlarmTimeLeft(vehicle, hotwireTime)
        PoliceCall()
        QBCore.Functions.Progressbar("hotwire_vehicle", "Engaging the ignition switch", hotwireTime, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
            anim = "machinic_loop_mechandplayer",
            flags = 16,
        }, {}, {}, function() -- Done
            StopAnimTask(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
            local succ = math.random(0, 100)
            print (succ)
            if (succ > 70) then
                HasKey = true
                QBCore.Functions.Notify("Hotwire succeeded!")
            else
                HasKey = false
                SetVehicleEngineOn(veh, false, false, true)
                QBCore.Functions.Notify("Hotwire failed!", "error")
            end
            IsHotwiring = false
        end, function() -- Cancel
            StopAnimTask(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
            HasKey = false
            SetVehicleEngineOn(veh, false, false, true)
            QBCore.Functions.Notify("Hotwire failed!", "error")
            IsHotwiring = false
        end)
    end
end

function PoliceCall()
    if not AlertSend then
        local pos = GetEntityCoords(ped)
        local chance = 20
        if GetClockHours() >= 1 and GetClockHours() <= 6 then
            chance = 10
        end
        if math.random(1, 100) <= chance then
            local closestPed = GetNearbyPed()
            if closestPed ~= nil then
                local msg = ""
                local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, pos.x, pos.y, pos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
                local streetLabel = GetStreetNameFromHashKey(s1)
                local street2 = GetStreetNameFromHashKey(s2)
                if street2 ~= nil and street2 ~= "" then 
                    streetLabel = streetLabel .. " " .. street2
                end
                local alertTitle = ""
                if IsPedInAnyVehicle(ped) then
                    local vehicle = GetVehiclePedIsIn(ped, false)
                    local modelName = GetEntityModel(vehicle)
                    if QBCore.Shared.VehicleModels[modelName] ~= nil then
                        Name = QBCore.Shared.Vehicles[QBCore.Shared.VehicleModels[modelName]["model"]]["brand"] .. ' ' .. QBCore.Shared.Vehicles[QBCore.Shared.VehicleModels[modelName]["model"]]["name"]
                    else
                        Name = "Unknown"
                    end
                    local modelPlate = GetVehicleNumberPlateText(vehicle)
                    local msg = "Vehicle theft attempt at " ..streetLabel.. ". Vehicle: " .. Name .. ", Licensplate: " .. modelPlate
                    local alertTitle = "Vehicle theft attempt at"
                    TriggerServerEvent("police:server:VehicleCall", pos, msg, alertTitle, streetLabel, modelPlate, Name)
                else
                    local vehicle = QBCore.Functions.GetClosestVehicle()
                    local modelName = GetEntityModel(vehicle)
                    local modelPlate = GetVehicleNumberPlateText(vehicle)
                    if QBCore.Shared.VehicleModels[modelName] ~= nil then
                        Name = QBCore.Shared.Vehicles[QBCore.Shared.VehicleModels[modelName]["model"]]["brand"] .. ' ' .. QBCore.Shared.Vehicles[QBCore.Shared.VehicleModels[modelName]["model"]]["name"]
                    else
                        Name = "Unknown"
                    end
                    local msg = "Vehicle theft attempt at " ..streetLabel.. ". Vehicle: " .. Name .. ", Licenceplate: " .. modelPlate
                    local alertTitle = "Vehicle theft attempt at"
                    TriggerServerEvent("police:server:VehicleCall", pos, msg, alertTitle, streetLabel, modelPlate, Name)
                end
            end
        end
        AlertSend = true
        SetTimeout(2 * (60 * 1000), function()
            AlertSend = false
        end)
    end
end

function GetClosestVehicleInDirection(coordFrom, coordTo)
	local offset = 0
	local rayHandle
	local vehicle

	for i = 0, 100 do
		rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, ped, 0)	
		a, b, c, d, vehicle = GetRaycastResult(rayHandle)
		
		offset = offset - 1

		if vehicle ~= 0 then break end
	end
	
	local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
	
	if distance > 250 then vehicle = nil end

    return vehicle ~= nil and vehicle or 0
end

function GetNearbyPed()
	local retval = nil
	local PlayerPeds = {}
    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        table.insert(PlayerPeds, ped)
    end
    local player = ped
    local coords = GetEntityCoords(player)
	local closestPed, closestDistance = QBCore.Functions.GetClosestPed(coords, PlayerPeds)
	if not IsEntityDead(closestPed) and closestDistance < 30.0 then
		retval = closestPed
	end
	return retval
end

function IsBlacklistedWeapon()
    local weapon = GetSelectedPedWeapon(ped)
    if weapon ~= nil then
        for _, v in pairs(Config.NoRobWeapons) do
            if weapon == GetHashKey(v) then
                return true
            end
        end
    end
    return false
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 0 )
    end
end