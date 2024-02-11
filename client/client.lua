local polyzoneMode = {}
G_CallBackFuntion = nil;

local function toggleNuiFrame(shouldShow)
    SetNuiFocus(shouldShow, shouldShow)
    SendReactMessage('setVisible', shouldShow)
end

RegisterCommand('show-nui', function()
    toggleNuiFrame(true)
    debugPrint('Show NUI frame')
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

RegisterNUICallback("startPolyzoneCreator", function(name, cb)
    SetNuiFocus(false, false)
    toggleCretor(name)
    cb({})
end)

polyzoneMode.start = function(cbFunc, data)
    G_CallBackFuntion = cbFunc;
    toggleNuiFrame(true)
    SendReactMessage('polyzoneMode', {
        mod = true,
        name = data?.name or nil,
        placeholder = data?.placeholder or "Enter a name for the polyzone...",
        button = data?.buttontext or "Create PolyZone"
    })
end

function PolyZoneMode()
    return polyzoneMode
end

exports("PolyZoneMode", PolyZoneMode)
