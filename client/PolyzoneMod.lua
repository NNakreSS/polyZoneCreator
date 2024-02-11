local isOpenCretor, Cam = false, nil
local MAX_CAM_DISTANCE = 100
local MinY, MaxY = -90.0, 90.0
local MoveSpeed = 0.15
local polyzonePoints = {}
local currentPolyZone, currentPolyZoneName, currnetZ = nil, nil, nil

function toggleCretor(polyzoneName)
    local playerPed = PlayerPedId()
    if not isOpenCretor then
        currentPolyZoneName, currentPolyZone, currnetZ, polyzonePoints = polyzoneName, nil, nil, {}
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
        SendReactMessage('polyzoneMode', {
            mod = false
        })
        currentPolyZone:destroy();
        G_CallBackFuntion = nil;
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
            camControls()
            DisabledControls()
            Citizen.Wait(0)
        end
    end)
end

-- #region Raycasting Functions
function startRaycast()
    local position = GetCamCoord(Cam)
    local hit, coords = RayCastGamePlayCamera(80.0)
    if hit then
        DrawLine(coords.x, coords.y, coords.z, coords.x, coords.y, coords.z + 15.0, 250.0, 80.0, 0.0, 250.0)
        keyControls(coords)
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
-- #endregion 

-- #region Manage Polygon Functions
function keyControls(coords)
    if IsControlJustPressed(0, Keys[Config.CLICK_ADD_POINT]) then
        SendReactMessage('pointCount', 1)
        table.insert(polyzonePoints, coords)
        refreshPolyzone()
    elseif IsControlJustPressed(0, Keys[Config.CLICK_DELETE_POINT]) then
        if #polyzonePoints > 0 then
            SendReactMessage('pointCount', -1)
            table.remove(polyzonePoints, #polyzonePoints)
            refreshPolyzone()
        end
    elseif IsControlPressed(0, Keys[Config.CLICK_SAVE_POLYZONE]) then
        if #polyzonePoints > 0 then
            SavePolygon(currentPolyZoneName, polyzonePoints, currnetZ, currentPolyZone)
        else
            cancelPolygonCreator()
        end
    end
end

function refreshPolyzone()
    if currentPolyZone then
        currentPolyZone:destroy();
    end
    if #polyzonePoints > 0 then
        if #polyzonePoints == 1 then
            currnetZ = polyzonePoints[1].z
            print("first : " .. currnetZ)
        else
            currnetZ = currnetZ > polyzonePoints[#polyzonePoints].z and polyzonePoints[#polyzonePoints].z or currnetZ
        end

        currentPolyZone = PolyZone:Create(polyzonePoints, {
            name = currentPolyZoneName,
            minZ = currnetZ,
            maxZ = currnetZ + 30.0,
            debugGrid = true,
            gridDivisions = 25,
            debugPoly = true
        })
    end
end

function SavePolygon(name, points, minZ, polyzone)
    local success, result = pcall(function()
        G_CallBackFuntion({
            succes = true,
            name = name,
            points = points,
            minZ = minZ,
            polyzone = polyzone
        })
    end)
    if not success then
        G_CallBackFuntion({
            succes = false,
            error = result
        })
    end
    toggleCretor()
end

function cancelPolygonCreator()
    G_CallBackFuntion({
        succes = false,
        error = "Cancel"
    })
    toggleCretor()
end
-- #endregion 

-- #region Cam Controls Functions
function camControls()
    rotateCamInputs()
    moveCamInputs()
end

function rotateCamInputs()
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
    return IsControlPressed(index, Keys[input])
end

function moveCamInputs() -- mouse yönüne göre ilerleme 
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
-- #endregion 

function DisabledControls()
    EnableControlAction(0, 32, true)
    EnableControlAction(0, 33, true)
    EnableControlAction(0, 34, true)
    EnableControlAction(0, 35, true)
    EnableControlAction(0, 44, true)
    EnableControlAction(0, 46, true)
    EnableControlAction(0, 69, true)
    EnableControlAction(0, 70, true)
    EnableControlAction(0, 322, true)
    EnableControlAction(0, 220, true)
    EnableControlAction(0, 221, true)
    DisableControlAction(0, 24, true) -- Attack
    DisableControlAction(0, 257, true) -- Attack 2
    DisableControlAction(0, 25, true) -- Aim
    DisableControlAction(0, 263, true) -- Melee Attack 1
    DisableControlAction(0, 45, true) -- Reload
    DisableControlAction(0, 73, true) -- Disable clearing animation
    DisableControlAction(2, 199, true) -- Disable pause screen
    DisableControlAction(0, 59, true) -- Disable steering in vehicle
    DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
    DisableControlAction(0, 72, true) -- Disable reversing in vehicle
    DisableControlAction(2, 36, true) -- Disable going stealth
    DisableControlAction(0, 47, true) -- Disable weapon
    DisableControlAction(0, 264, true) -- Disable melee
    DisableControlAction(0, 140, true) -- Disable melee
    DisableControlAction(0, 141, true) -- Disable melee
    DisableControlAction(0, 142, true) -- Disable melee
    DisableControlAction(0, 143, true) -- Disable melee
end
