local polyzones = {}

local function toggleNuiFrame(shouldShow)
    SetNuiFocus(shouldShow, shouldShow)
    SendReactMessage('setVisible', shouldShow)
end

RegisterCommand('show-nui', function()
    toggleNuiFrame(true)
    debugPrint('Show NUI frame')
end)

RegisterNUICallback('hideFrame', function(_, cb)
    toggleNuiFrame(false)
    debugPrint('Hide NUI frame')
    cb({})
end)

RegisterNUICallback('getKeyInfos', function(_, cb)
    local keyInfos = {{
        key = Config.MOVE_FORWARDS,
        type = "forward"
    }, {
        key = Config.MOVE_BACKWARDS,
        type = "back"
    }, {
        key = Config.MOVE_LEFT,
        type = "left"
    }, {
        key = Config.MOVE_RIGHT,
        type = "right"
    }, {
        key = Config.MOVE_DOWN,
        type = "down"
    }, {
        key = Config.MOVE_UP,
        type = "up"
    }, {
        key = Config.CLICK_SAVE_POLYZONE,
        type = "save"
    }}
    cb(keyInfos)
end)

RegisterNUICallback('startPolyzoneCreator', function(name, cb)
    toggleCretor(name)
    SetNuiFocus(false, false)
    cb({})
end)

RegisterNetEvent("start-polyzone-create", function()
    toggleNuiFrame(true)
    SendReactMessage('startCreatePolyzone', polyzones)
end)
