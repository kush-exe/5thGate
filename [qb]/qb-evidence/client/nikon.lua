QBCore = exports['qb-core']:GetCoreObject()
local ped, vehicle, isdead, usingscenario, inveh = nil, nil, nil, nil, nil
local nikon_cam = nil
local nikon_fov_max = 70.0
local nikon_fov_min = 1.0 -- max zoom level (smaller fov is more zoom)
local nikon_zoomspeed = 5.0 -- camera zoom speed
local nikon_speed_lr = 8.0 -- speed by which the camera pans left-right
local nikon_speed_ud = 8.0 -- speed by which the camera pans up-down
local nikon = false
local nikon_fov = (nikon_fov_max+nikon_fov_min)*0.5
local nikon_keybindEnabled = false -- When enabled, nikons are available by keybind
local nikon_nikonKey = 73
local storeNikonKey = 177
local camdate = ''
local camsecond = ''

local function TakePhoto()
    print(QBCore.Functions.GetPlayerData().job.name)

    if QBCore.Functions.GetPlayerData().job.name == 'police' and QBCore.Functions.GetPlayerData().job.onduty then
        exports['screenshot-basic']:requestScreenshotUpload(Config.LEOWebhook, 'files[]', {encoding = 'jpg'}, function(data) end)-- police evidence webhook
    else
       exports['screenshot-basic']:requestScreenshotUpload(Config.CivWebhook, 'files[]', {encoding = 'jpg'}, function(data) end) -- civilian webhook
    end
end

--THREADS--

CreateThread(function()
	while true do
        if LocalPlayer.state.isLoggedIn then
	        ped = PlayerPedId()   
            vehicle = IsPedSittingInAnyVehicle(ped)
            isdead = IsEntityDead(ped)
            usingscenario = IsPedUsingScenario(ped, "WORLD_HUMAN_PAPARAZZI")
            QBCore.Functions.TriggerCallback('evidence:GetCamDate', function(result)
                camdate = result
                camsecond = string.sub(camdate, 27, 27)
            end)
        end
        Wait(1000)
	end
end)

CreateThread(function() -- this thread checks every 1.5 seconds if we are using the camera or in a vehicle
    while true do
        Wait(1500)

        if nikon then
            nikon = true
            if not vehicle then
                TaskStartScenarioInPlace(ped, "WORLD_HUMAN_PAPARAZZI", 0, 1)
            else
                TriggerEvent('animations:client:EmoteCommandStart', {"camera"})
            end
            RequestStreamedTextureDict('cameraoverlay')
            RequestStreamedTextureDict('mpinventory')

            Wait(1500)
            SetTimecycleModifier("default")
            SetTimecycleModifierStrength(0.3)
                        
            
            if not vehicle then
                nikon_cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)
                AttachCamToEntity(nikon_cam, ped, 0.0,1.00,1.0, true)
                SetCamRot(nikon_cam, 0.0,0.0,GetEntityHeading(ped))
                SetCamFov(nikon_cam, nikon_fov)
                RenderScriptCams(true, false, 0, 1, 0)
                inveh = false
            else
                inveh = true
                CreateMobilePhone(0)
                CellCamActivate(true, true)
             end




            while nikon and (usingscenario or inveh) and not isdead do
                DisableControlAction(0, 200)
                DisableControlAction(0, 241)
                DisableControlAction(0, 242)
                DisableControlAction(0, 83)
                DisableControlAction(0, 84)
                DisableControlAction(1, 83)
                DisableControlAction(1, 84)
                DisableControlAction(2, 83)
                DisableControlAction(2, 84)


                if IsControlJustPressed(0, storeNikonKey) or IsDisabledControlJustReleased(0, 200) then -- Toggle nikon
                    PlaySoundFrontend(-1, "Zoom_In", "MUGSHOT_CHARACTER_CREATION_SOUNDS", false)
                    ClearPedTasks(ped)
                    nikon = false
                end
                if IsControlJustReleased(0, 24) then
                    TakePhoto()
                    PlaySoundFrontend(-1, "Camera_Shoot", "Phone_Soundset_Franklin", false)
                end
                HUD()
                Date()
                if not inveh then
                    local nikon_zoomvalue = (1.0/(nikon_fov_max-nikon_fov_min))*(nikon_fov-nikon_fov_min)
                    CheckInputRotation(nikon_cam, nikon_zoomvalue)
                    HandleZoom(nikon_cam)
                end
                HideHUDThisFrame()
                Wait(0)
            end

            nikon = false
            ClearTimecycleModifier()
            nikon_fov = (nikon_fov_max+nikon_fov_min)*0.5
            if not inveh then
                RenderScriptCams(false, false, 0, 1, 0)
                DestroyCam(nikon_cam, false)
            else
                CellCamActivate(false, false)
                DestroyMobilePhone()
                inveh = false
            end
            SetNightvision(false)
            SetSeethrough(false)
        end
    end
end)


--EVENTS--

-- this thread toggles the variable we use to check if we are using the camera, when untoggled it clears our tasks so we end our scenario
RegisterNetEvent('nikon:Toggle', function()
    nikon = not nikon
    if not nikon then
        ClearPedTasks(ped)
    end
end)

--FUNCTIONS--

function HideHUDThisFrame()
    HideHelpTextThisFrame()
    HideHudAndRadarThisFrame()
    HideHudComponentThisFrame(1) -- Wanted Stars
    HideHudComponentThisFrame(2) -- Weapon icon
    HideHudComponentThisFrame(3) -- Cash
    HideHudComponentThisFrame(4) -- MP CASH
    HideHudComponentThisFrame(6)
    HideHudComponentThisFrame(7)
    HideHudComponentThisFrame(8)
    HideHudComponentThisFrame(9)
    HideHudComponentThisFrame(13) -- Cash Change
    HideHudComponentThisFrame(11) -- Floating Help Text
    HideHudComponentThisFrame(12) -- more floating help text
    HideHudComponentThisFrame(15) -- Subtitle Text
    HideHudComponentThisFrame(18) -- Game Stream
    HideHudComponentThisFrame(19) -- weapon wheel
end

function HUD()
    SetTextScale(.9, .9)
    SetTextFont(2)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 190)
    SetTextEntry('STRING')
    SetTextCentre(true)
    AddTextComponentString('REC')
    EndTextCommandDisplayText(0.91,.08)
    DrawSprite('cameraoverlay', 'corner', 0.1, 0.15, .1, .2, 0, 255, 255, 255, 190)
    DrawSprite('cameraoverlay', 'corner', 0.9, 0.15, -.1, .2, 0, 255, 255, 255, 190)
    DrawSprite('cameraoverlay', 'corner', 0.1, 0.85, .1, -.2, 0, 255, 255, 255, 190)
    DrawSprite('cameraoverlay', 'corner', 0.9, 0.85, -.1, -.2, 0, 255, 255, 255, 190)
    DrawSprite('cameraoverlay', 'battery', 0.095, 0.11, .04, .04, 0, 255, 255, 255, 190)
end     
            
function Date()
    SetTextScale(.7, .7)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 190)
    SetTextEntry('STRING')
    SetTextCentre(false)
    AddTextComponentString(camdate)
    EndTextCommandDisplayText(0.08, 0.87)
    if camsecond == '1' or camsecond == '3' or camsecond == '5' or camsecond == '7' or camsecond == '9' then
        DrawSprite('mpinventory', 'in_world_circle', 0.88, 0.108, .025, .045, 0, 210, 0, 0, 190)
    end
end


function CheckInputRotation(nikon_cam, nikon_zoomvalue)
    local rightAxisX = GetDisabledControlNormal(0, 220)
    local rightAxisY = GetDisabledControlNormal(0, 221)
    local rotation = GetCamRot(nikon_cam, 2)
    if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
        new_z = rotation.z + rightAxisX*-1.0*(nikon_speed_ud)*(nikon_zoomvalue+0.1)
        new_x = math.max(math.min(20.0, rotation.x + rightAxisY*-1.0*(nikon_speed_lr)*(nikon_zoomvalue+0.1)), -89.5)
        SetCamRot(nikon_cam, new_x, 0.0, new_z, 2)
        SetEntityHeading(ped,new_z)
    end
end


function HandleZoom(nikon_cam)
    if IsDisabledControlJustPressed(0,241) then -- Scrollup
        nikon_fov = math.max(nikon_fov - nikon_zoomspeed, nikon_fov_min)
    end
    if IsDisabledControlJustPressed(0,242) then
        nikon_fov = math.min(nikon_fov + nikon_zoomspeed, nikon_fov_max) -- ScrollDown
    end
    local nikon_current_fov = GetCamFov(nikon_cam)
    if math.abs(nikon_fov-nikon_current_fov) < 0.1 then
        nikon_fov = nikon_current_fov
    end
    SetCamFov(nikon_cam, nikon_current_fov + (nikon_fov - nikon_current_fov)*0.05)
end
