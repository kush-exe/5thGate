-----------------------------------------------------------------------------------------
---                                        INIT                                       ---
-----------------------------------------------------------------------------------------
local QBCore = exports['qb-core']:GetCoreObject()
local currentVehicle, lockStatus, engineStatus, alarmStatus, lastVehicle, owner, sent
local vehicles = {}

function checkOwner(vehicle)
	local plate = GetVehicleNumberPlateText(vehicle)
	QBCore.Functions.TriggerCallback('vehiclekeys:CheckHasKey', function(result)
		if result then
			return true
		else
			return false
		end
	end, plate)
end

function unlockVehicle(vehicle)
	local ply = GetPlayerPed(-1)
	if(IsPedInAnyVehicle(ply, true))then
		SetVehicleDoorsLocked(vehicle, 1)
		SetVehicleAlarm(vehicle, 0)
		QBCore.Functions.Notify("Vehicle Unlocked")
		TriggerServerEvent("carremote:playSound", 4, "unlock-inside", 0.10)
		lockStatus = 1
	else
		playAnimation()
		SetVehicleDoorsLocked(vehicle, 1)
		SetVehicleAlarm(vehicle, 0)
		QBCore.Functions.Notify("Vehicle Unlocked") 
		local vehicleNetId = VehToNet(vehicle)
		TriggerServerEvent("carremote:playSoundFromVehicle", Config.MaxAlarmDistance, "unlock-inside", Config.MaxFobBeepVolume, vehicleNetId)
		lockStatus = 1
	end
end

function lockVehicle(vehicle)
	local ply = GetPlayerPed(-1)
	if(IsPedInAnyVehicle(ply, true))then
		SetVehicleDoorsLocked(vehicle, 2)
		QBCore.Functions.Notify("Vehicle Locked")
		TriggerServerEvent("carremote:playSound", 4, "lock-inside", 0.10)
		lockStatus = 2
	else
		playAnimation()
		SetVehicleDoorsLocked(vehicle, 2)
		QBCore.Functions.Notify("Vehicle Locked")
		local vehicleNetId = VehToNet(vehicle)
		TriggerServerEvent("carremote:playSoundFromVehicle", Config.MaxAlarmDistance, "lock-outside", Config.MaxFobBeepVolume, vehicleNetId)
		--TriggerServerEvent("carremote:playSoundFromVehicle", Config.MaxAlarmDistance, "choca", Config.MaxFobBeepVolume, vehicleNetId)
		lockStatus = 2
	end
end

function engineOn(vehicle)
	local ply = GetPlayerPed(-1)
	if(IsPedInAnyVehicle(ply, true))then
		QBCore.Functions.Notify("Engine Started")
		SetVehicleEngineOn(vehicle, true, false, false)
	else
		ClearPedTasks(ply)
		playAnimation()
		SetVehicleEngineOn(vehicle, true, true, false)
	end
end

function engineOff(vehicle)
	local ply = GetPlayerPed(-1)
	if(IsPedInAnyVehicle(ply, true))then
		QBCore.Functions.Notify("Engine Stopped")
		SetVehicleEngineOn(vehicle, false, false, true)
	else
		ClearPedTasks(ply)
		playAnimation()
		SetVehicleEngineOn(vehicle, false, false, false)
	end
end

function getVehicleNetId(vehID)
	return NetToVeh(NetworkGetNetworkIdFromEntity(vehID))
end

function getVehicleInDirection(coordFrom, coordTo)
	local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1), 0)
	local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
	return vehicle
end

function playAnimation()
	--loadAnimDict("anim@mp_player_intmenu@key_fob@")
    --TaskPlayAnim(GetPlayerPed(-1), 'anim@mp_player_intmenu@key_fob@', 'fob_click' ,3.0, 3.0, -1, 49, 0, false, false, false)
	loadAnimDict("anim@mp_player_intmenu@key_fob@") 
    TaskPlayAnim(GetPlayerPed(-1), "anim@mp_player_intmenu@key_fob@", "exit", 5.0, 1.0, -1, 16, 0, 0, 0, 0 )
    Citizen.Wait(400)
    ClearPedTasks(GetPlayerPed(-1))
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

RegisterNetEvent('carremote:playSound')
AddEventHandler('carremote:playSound', function(playerNetId, maxDistance, soundFile, soundVolume)
    local lCoords = GetEntityCoords(GetPlayerPed(-1))
    local eCoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(playerNetId)))
    local distIs  = Vdist(lCoords.x, lCoords.y, lCoords.z, eCoords.x, eCoords.y, eCoords.z)
    if(distIs <= maxDistance) then
        SendNUIMessage({
            transactionType   = 'playSound',
            transactionFile   = soundFile,
            transactionVolume = soundVolume
        })
    end
end)

RegisterNetEvent('carremote:playSoundFromVehicle')
AddEventHandler('carremote:playSoundFromVehicle', function(playerNetId, maxDistance, soundFile, maxVolume, sourceEntity)
	local distPerc = nil
	local volume = maxVolume
	local lCoords = GetEntityCoords(GetPlayerPed(-1))
	local eCoords = GetEntityCoords(NetToVeh(sourceEntity), true)
	local distIs  = tonumber(string.format("%.1f", GetDistanceBetweenCoords(lCoords.x, lCoords.y, lCoords.z, eCoords.x, eCoords.y, eCoords.z, true)))
	if (distIs <= maxDistance) then
		distPerc = distIs / maxDistance
		volume = (1-distPerc) * maxVolume
		SendNUIMessage({
			transactionType   = 'playSound',
			transactionFile   = soundFile,
			transactionVolume = volume
		})
	end
end)

-- NUICallback for Turning The Menu Off
RegisterNUICallback('NUIFocusOff', function()
	SetNuiFocus(false, false)
end)

-- NUICallback For Locking Vehicle
RegisterNUICallback('NUILock', function()
	SendNUIMessage({type = 'disableButtons'})

	if lastVehicle then
		local ply = GetPlayerPed(-1)
		local vehicleDistance = GetDistanceBetweenCoords(GetEntityCoords(ply), GetEntityCoords(lastVehicle, false), true)
		if Config.MaxRemoteRange >= vehicleDistance then
			lockStatus = GetVehicleDoorLockStatus(lastVehicle)
			if lockStatus < 2 then
				lockVehicle(lastVehicle)
				SendNUIMessage({type = 'locked'})
				Citizen.Wait(200)
				SetVehicleLights(lastVehicle, 2)
				Citizen.Wait(100)
				SetVehicleLights(lastVehicle, 0)
				Citizen.Wait(200)
				SetVehicleLights(lastVehicle, 2)
				Citizen.Wait(100)
				SetVehicleLights(lastVehicle, 0)		
			else
				QBCore.Functions.Notify("Already Locked")
			end
		else
			QBCore.Functions.Notify("Out of Range")
		end
	else
		QBCore.Functions.Notify("Not Connected")
	end

	SendNUIMessage({type = 'enableButtons'})
end)

-- NUICallback for Unlocking Vehicle
RegisterNUICallback('NUIUnlock', function()
	SendNUIMessage({type = 'disableButtons'})

	if lastVehicle then
		local ply = GetPlayerPed(-1)
		local vehicleDistance = GetDistanceBetweenCoords(GetEntityCoords(ply), GetEntityCoords(lastVehicle, false), true)
		if Config.MaxRemoteRange >= vehicleDistance then
			lockStatus = GetVehicleDoorLockStatus(lastVehicle)
			if lockStatus >= 2 then
				unlockVehicle(lastVehicle)
				SendNUIMessage({type = 'unlocked'})
				Citizen.Wait(200)
				SetVehicleLights(lastVehicle, 2)
				Citizen.Wait(100)
				SetVehicleLights(lastVehicle, 0)
				Citizen.Wait(200)
				SetVehicleLights(lastVehicle, 2)
				Citizen.Wait(100)
				SetVehicleLights(lastVehicle, 0)
			else
				QBCore.Functions.Notify("Already Unlocked")
			end
		else
			QBCore.Functions.Notify("Out of Range")
		end
	else
		QBCore.Functions.Notify("Not Connected")
	end

	SendNUIMessage({type = 'enableButtons'})
end)

-- NUICallback for Toggling Engine
RegisterNUICallback('NUIToggleEngine', function()
	SendNUIMessage({type = 'disableButtons'})

	if lastVehicle then
		local ply = GetPlayerPed(-1)
		local vehicleDistance = GetDistanceBetweenCoords(GetEntityCoords(ply), GetEntityCoords(lastVehicle, false), true)
		if Config.MaxRemoteRange >= vehicleDistance then
			engineStatus   = GetIsVehicleEngineRunning(lastVehicle)
			if engineStatus == 1 then
				engineOff(lastVehicle)
				SendNUIMessage({type = 'engineOff'})
			else
				engineOn(lastVehicle)
				SendNUIMessage({type = 'engineOn'})
			end
		else
			QBCore.Functions.Notify("Out of Range")
		end
	else
		QBCore.Functions.Notify("Not Connected")
	end

	Citizen.Wait(500)
	SendNUIMessage({type = 'enableButtons'})
end)

-- NUICallback for Toggling Alarm
RegisterNUICallback('NUIPanic', function()
	SendNUIMessage({type = 'disableButtons'})

	if lastVehicle then
		local ply = GetPlayerPed(-1)
		local vehicleDistance = GetDistanceBetweenCoords(GetEntityCoords(ply), GetEntityCoords(lastVehicle, false), true)
		if Config.MaxRemoteRange >= vehicleDistance then
			playAnimation()
			Citizen.Wait(250)
			if not alarmStatus then
				SetVehicleAlarm(lastVehicle, 1)
				StartVehicleAlarm(lastVehicle)
				SetVehicleAlarmTimeLeft(lastVehicle, 180000)
				alarmStatus = true
			else
				SetVehicleAlarm(lastVehicle, 0)
				alarmStatus = false
			end
		else
			QBCore.Functions.Notify("Out of Range")
		end
	else
		QBCore.Functions.Notify("Not Connected")
	end

	Citizen.Wait(250)
	SendNUIMessage({type = 'enableButtons'})
end)

--[[
Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(10)
        if QBCore == nil then
            TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)    
            Citizen.Wait(200)
        end
    end
end)
--]]

Citizen.CreateThread(function()
	RegisterCommand("+carremote", carrem, false)
	RegisterCommand("+enginehotkey", enginehotkey, false)
	RegisterKeyMapping("+carremote", "Open Car Remote", "keyboard", "U")
	RegisterKeyMapping("+enginehotkey", "Toggle Engine", "keyboard", "G")
end)



function carrem()
	local ply = GetPlayerPed(-1)

			if (IsPedInAnyVehicle(ply, true)) then
				currentVehicle = GetVehiclePedIsIn(ply, false)
				lockStatus     = GetVehicleDoorLockStatus(currentVehicle)
				if lockStatus == 2 then
					unlockVehicle(currentVehicle)
				else
					lockVehicle(currentVehicle)
				end

				Citizen.Wait(1000)
			else
				local coordA = GetEntityCoords(ply, 1)
				local coordB = GetOffsetFromEntityInWorldCoords(ply, 0.0, 5.0, 0.0)
				local vehicle = getVehicleInDirection(coordA, coordB)
				local vehicleDistance = GetDistanceBetweenCoords(GetEntityCoords(ply), GetEntityCoords(vehicle, false), true)
				local plate = GetVehicleNumberPlateText(vehicle)
				if vehicleDistance < Config.SwitchDistance then
					QBCore.Functions.TriggerCallback('vehiclekeys:CheckHasKey', function(result)
						--print(result)
						if result then
							lastVehicle = vehicle
							QBCore.Functions.Notify("Pairing to "..plate)
							local vehicleDistance = GetDistanceBetweenCoords(GetEntityCoords(ply), GetEntityCoords(vehicle, false), true)

							if Config.MaxRemoteRange >= vehicleDistance then
								local range = vehicleDistance / Config.MaxRemoteRange 
								range = 100 - (math.floor((range * 10) + 0.5) * 10)
								battery = 'battery-' .. tostring(range)
								SendNUIMessage({type = tostring(battery)})
							else
								SendNUIMessage({type = 'battery-0'})
							end

							engineStatus = GetIsVehicleEngineRunning(vehicle)

							if engineStatus then
								SendNUIMessage({type = 'engineOn'})
							else
								SendNUIMessage({type = 'engineOff'})
							end

							lockStatus = GetVehicleDoorLockStatus(vehicle)

							if lockStatus then
								if lockStatus == 2 then
									SendNUIMessage({type = 'locked'})
								else
									SendNUIMessage({type = 'unlocked'})
								end
							else
								SendNUIMessage({type = 'unlocked'})
							end

							SendNUIMessage({type = 'carConnected'})
							SetNuiFocus(true, true)
							SendNUIMessage({type = 'setHotKey', value = Config.HotkeyUI})
							SendNUIMessage({type = 'enableButtons'})
							SendNUIMessage({type = 'openKeyFob'})
						else
							if lastVehicle then
								if DoesEntityExist(lastVehicle) then
									vehicleDistance = GetDistanceBetweenCoords(GetEntityCoords(ply), GetEntityCoords(lastVehicle, false), true)
		
									if Config.MaxRemoteRange >= vehicleDistance then
										local range = vehicleDistance / Config.MaxRemoteRange 
										range = 100 - (math.floor((range * 10) + 0.5) * 10)
										battery = 'battery-' .. tostring(range)
										SendNUIMessage({type = tostring(battery)})
									else
										SendNUIMessage({type = 'battery-0'})
									end
		
									engineStatus = GetIsVehicleEngineRunning(lastVehicle)
		
									if engineStatus then
										SendNUIMessage({type = 'engineOn'})
									else
										SendNUIMessage({type = 'engineOff'})
									end
		
									lockStatus = GetVehicleDoorLockStatus(lastVehicle)
		
									if lockStatus then
										if lockStatus == 2 then
											SendNUIMessage({type = 'locked'})
										else
											SendNUIMessage({type = 'unlocked'})
										end
									else
										SendNUIMessage({type = 'unlocked'})
									end
		
									SendNUIMessage({type = 'carConnected'})
									SetNuiFocus(true, true)
									SendNUIMessage({type = 'setHotKey', value = Config.HotkeyUI})
									SendNUIMessage({type = 'enableButtons'})
									SendNUIMessage({type = 'openKeyFob'})
								else
									SendNUIMessage({type = 'carDisconnected'})
									SendNUIMessage({type = 'unlocked'})
									SendNUIMessage({type = 'engineOff'})
									SendNUIMessage({type = 'battery-0'})
									SetNuiFocus(true, true)
									SendNUIMessage({type = 'setHotKey', value = Config.HotkeyUI})
									SendNUIMessage({type = 'enableButtons'})
									SendNUIMessage({type = 'openKeyFob'})
								end
							else
								SendNUIMessage({type = 'carDisconnected'})
								SendNUIMessage({type = 'unlocked'})
								SendNUIMessage({type = 'engineOff'})
								SendNUIMessage({type = 'battery-0'})
								SetNuiFocus(true, true)
								SendNUIMessage({type = 'setHotKey', value = Config.HotkeyUI})
								SendNUIMessage({type = 'enableButtons'})
								SendNUIMessage({type = 'openKeyFob'})
							end
						end
					end, plate)
				else
					if lastVehicle then
						if DoesEntityExist(lastVehicle) then
							vehicleDistance = GetDistanceBetweenCoords(GetEntityCoords(ply), GetEntityCoords(lastVehicle, false), true)

							if Config.MaxRemoteRange >= vehicleDistance then
								local range = vehicleDistance / Config.MaxRemoteRange 
								range = 100 - (math.floor((range * 10) + 0.5) * 10)
								battery = 'battery-' .. tostring(range)
								SendNUIMessage({type = tostring(battery)})
							else
								SendNUIMessage({type = 'battery-0'})
							end

							engineStatus = GetIsVehicleEngineRunning(lastVehicle)

							if engineStatus then
								SendNUIMessage({type = 'engineOn'})
							else
								SendNUIMessage({type = 'engineOff'})
							end

							lockStatus = GetVehicleDoorLockStatus(lastVehicle)

							if lockStatus then
								if lockStatus == 2 then
									SendNUIMessage({type = 'locked'})
								else
									SendNUIMessage({type = 'unlocked'})
								end
							else
								SendNUIMessage({type = 'unlocked'})
							end

							SendNUIMessage({type = 'carConnected'})
							SetNuiFocus(true, true)
							SendNUIMessage({type = 'setHotKey', value = Config.HotkeyUI})
							SendNUIMessage({type = 'enableButtons'})
							SendNUIMessage({type = 'openKeyFob'})
						else
							SendNUIMessage({type = 'carDisconnected'})
							SendNUIMessage({type = 'unlocked'})
							SendNUIMessage({type = 'engineOff'})
							SendNUIMessage({type = 'battery-0'})
							SetNuiFocus(true, true)
							SendNUIMessage({type = 'setHotKey', value = Config.HotkeyUI})
							SendNUIMessage({type = 'enableButtons'})
							SendNUIMessage({type = 'openKeyFob'})
						end
					else
						SendNUIMessage({type = 'carDisconnected'})
						SendNUIMessage({type = 'unlocked'})
						SendNUIMessage({type = 'engineOff'})
						SendNUIMessage({type = 'battery-0'})
						SetNuiFocus(true, true)
						SendNUIMessage({type = 'setHotKey', value = Config.HotkeyUI})
						SendNUIMessage({type = 'enableButtons'})
						SendNUIMessage({type = 'openKeyFob'})
					end
				end
			end
end



function enginehotkey()
	TriggerEvent('qb-vehiclekeys:client:ToggleEngine')
end