local isOpenCretor, Cam = false, nil
local MAX_CAM_DISTANCE = 100
local MinY, MaxY = -80.0, 80.0
local MoveSpeed = 0.1
local polyzonePoints = {}
local currentPolyZone, currentPolyZoneName = nil, nil

function toggleCretor(polyzoneName)
    local playerPed = PlayerPedId()
    if not isOpenCretor then
        currentPolyZoneName = polyzoneName
        local x, y, z = table.unpack(GetGameplayCamCoord())
        local pitch, roll, yaw = table.unpack(GetGameplayCamRot(2))
        local fov = GetGameplayCamFov()
        Cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
        SetCamCoord(Cam, x, y, z + 20.0)
        SetCamRot(Cam, pitch, roll, yaw, 2)
        SetCamFov(Cam, fov)
        RenderScriptCams(true, true, 500, true, true)
        FreezeEntityPosition(playerPed, true)
    else
        currentPolyZoneName = nil
        FreezeEntityPosition(playerPed, false)
        if Cam then
            RenderScriptCams(false, true, 500, true, true)
            SetCamActive(Cam, false)
            DetachCam(Cam)
            DestroyCam(Cam, true)
            Cam = nil
        end
    end
    isOpenCretor = not isOpenCretor
    ToggleInputThread()
end

function ToggleInputThread()
    Citizen.CreateThread(function()
        while isOpenCretor do
            startRaycast()
            CheckInputRotation()
            CheckInputCoords()
            DisabledControls()
            Citizen.Wait(0)
        end
    end)
end

function refreshPolyzone(vec)
    if currentPolyZone then
        currentPolyZone:destroy();
    end

    if #polyzonePoints > 0 then
        currentPolyZone = PolyZone:Create(polyzonePoints, {
            name = currentPolyZoneName,
            maxZ = 60.0,
            debugGrid = true,
            debug = true,
            gridDivisions = 25
        })
    end
end

function startRaycast()
    local position = GetCamCoord(Cam)
    local hit, coords = RayCastGamePlayCamera(80.0)
    if hit then
        DrawLine(coords.x, coords.y, coords.z, coords.x, coords.y, coords.z + 15.0, 250.0, 80.0, 0.0, 250.0)
        if IsControlJustPressed(0, G_Keys[Config.CLICK_ADD_POINT]) then
            local newVector2<const> = vector2(coords.x, coords.y)
            SendReactMessage('pointCount', 1)
            table.insert(polyzonePoints, newVector2)
            refreshPolyzone()
        elseif IsControlJustPressed(0, G_Keys[Config.CLICK_DELETE_POINT]) then
            if #polyzonePoints > 0 then
                SendReactMessage('pointCount', -1)
                table.remove(polyzonePoints, #polyzonePoints)
                refreshPolyzone()
            end
        elseif IsControlJustPressed(0, G_Keys[Config.CLICK_SAVE_POLYZONE]) then
            if #polyzonePoints > 0 then
                -- todo polyzonePoints save
            end
        end
    end
end

function RayCastGamePlayCamera(distance)
    local playerPed = PlayerPedId()
    local cameraRotation = GetCamRot(Cam, 2)
    local cameraCoord = GetCamCoord(Cam)
    local direction = RotationToDirection(cameraRotation)
    local destination = {
        x = cameraCoord.x + direction.x * distance,
        y = cameraCoord.y + direction.y * distance,
        z = cameraCoord.z + direction.z * distance
    }
    local _, hits, coords, _, entity = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z,
        destination.x, destination.y, destination.z, -1, playerPed, 0))
    return hits, coords, entity
end

function RotationToDirection(rotation)
    local adjustedRotation = {
        x = (math.pi / 180) * rotation.x,
        y = (math.pi / 180) * rotation.y,
        z = (math.pi / 180) * rotation.z
    }
    local direction = {
        x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        z = math.sin(adjustedRotation.x)
    }
    return direction
end

function CheckInputRotation()
    local newX
    local rAxisX = GetControlNormal(0, 220)
    local rAxisY = GetControlNormal(0, 221) -- mouse up mowe down mowe
    local rotation = GetCamRot(Cam, 2)
    local yValue = rAxisY * 5
    local newZ = rotation.z + (rAxisX * -10)
    local newXval = rotation.x - yValue
    if (newXval >= MinY) and (newXval <= MaxY) then
        newX = newXval
    end
    if newX and newZ then
        SetCamRot(Cam, vector3(newX, rotation.y, newZ), 2)
    end
end

function checkInput(index, input)
    return IsControlPressed(index, G_Keys[input])
end

function CheckInputCoords() -- mouse yönüne göre ilerleme 
    local x, y, z = table.unpack(GetCamCoord(Cam))
    local pitch, roll, yaw = table.unpack(GetCamRot(Cam, 2))

    local dx = math.sin(-yaw * math.pi / 180) * MoveSpeed
    local dy = math.cos(-yaw * math.pi / 180) * MoveSpeed
    local dz = math.tan(pitch * math.pi / 180) * MoveSpeed

    local dx2 = math.sin(math.floor(yaw + 90.0) % 360 * -1.0 * math.pi / 180) * MoveSpeed
    local dy2 = math.cos(math.floor(yaw + 90.0) % 360 * -1.0 * math.pi / 180) * MoveSpeed

    if checkInput(0, Config.MOVE_FORWARDS) then
        x = x + dx
        y = y + dy
    elseif checkInput(0, Config.MOVE_BACKWARDS) then
        x = x - dx
        y = y - dy
    elseif checkInput(0, Config.MOVE_RIGHT) then
        x = x - dx2
        y = y - dy2
    elseif checkInput(0, Config.MOVE_LEFT) then
        x = x + dx2
        y = y + dy2
    elseif checkInput(0, Config.MOVE_UP) then
        z = z + MoveSpeed
    elseif checkInput(0, Config.MOVE_DOWN) then
        z = z - MoveSpeed
    end
    local playerPed = PlayerPedId()
    local playercoords = GetEntityCoords(playerPed)
    if GetDistanceBetweenCoords(playercoords - vector3(x, y, z), true) <= MAX_CAM_DISTANCE then
        SetCamCoord(Cam, x, y, z)
    end
end

function DisabledControls()
    DisableAllControlActions(2)
    EnableControlAction(0, 32, true)
    EnableControlAction(0, 33, true)
    EnableControlAction(0, 34, true)
    EnableControlAction(0, 35, true)
    EnableControlAction(0, 44, true)
    EnableControlAction(0, 46, true)
    EnableControlAction(0, 172, true)
    EnableControlAction(0, 173, true)
    EnableControlAction(0, 174, true)
    EnableControlAction(0, 175, true)
    EnableControlAction(0, 14, true)
    EnableControlAction(0, 15, true)
    EnableControlAction(0, 348, true)
    EnableControlAction(0, 69, true)
    EnableControlAction(0, 70, true)
    EnableControlAction(0, 21, true)
    EnableControlAction(0, 29, true)
    EnableControlAction(0, 236, true)
    EnableControlAction(0, 253, true)
    EnableControlAction(0, 322, true)
    EnableControlAction(0, 220, true)
    EnableControlAction(0, 221, true)
    EnableControlAction(0, 249, true)
end
