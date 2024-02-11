# Polyzone Creator

> **A script tool that facilitates easier creation of polyzones using the PolyZone script.**

> **Dependencies** : https://github.com/mkafrin/PolyZone

### starter

> **cd web**

> **yarn** > **yarn build**

> **yarn build:dev** for development

> "The script supports 2 different zone scripts. After specifying the zone script you want to use in Config.lua, import the file related to the zone script you want to use in fxmanifest.lua and remove or comment out the import related to the other script."

## example Polyzone

```lua
local PolyZoneMode = exports['polyZoneCreator']:PolyZoneMode();

RegisterCommand("startCreate", function()
    local options = {
        name = string, -- (optional) the name of the zone. If not provided, a form will be opened;
        placeholder = string, -- (optional)
        buttontext = string, -- (optional)
    }

    PolyZoneMode.start(function(data)
        --  data = {
        --     succes = boolean,
        --     name = string,
        --     points = vector3[],
        --     minZ = double,
        --     maxZ = double,
        --     polyzone = polyzone,
        --     error = string
        --   }
    poly = PolyZone:Create(data.points, {
                name = data.name,
                minZ = data.minZ,
                maxZ = data.maxZ,
                debugGrid = false,
                debugPoly = false
            })
    end , options -- (optional) )
end)
```

## example lib.zone

```lua
local PolyZoneMode = exports['polyZoneCreator']:PolyZoneMode();

RegisterCommand("startCreate", function()
    local options = {
        name = string, -- (optional) the name of the zone. If not provided, a form will be opened;
        placeholder = string, -- (optional)
        buttontext = string, -- (optional)
    }

    PolyZoneMode.start(function(data)
        --  data = {
        --     succes = boolean,
        --     name = string,
        --     points = vector3[],
        --     thickness = number,
        --     minZ = double,
        --     polyzone = polyzone,
        --     error = string
        --   }
        poly = lib.zones.poly({
                name = data.name,
                points = data.points,
                thickness = data.thickness,
                debug = false,
                inside = inside,
                onEnter = onEnter,
                onExit = onExit
                })
    end , options -- (optional) )
end)
```

![Ekran görüntüsü 2024-02-11 183008](https://github.com/NNakreSS/polyZoneCreator/assets/87872407/5cddda80-fb4c-4522-aa0d-7f1e4da66081)

![image](https://github.com/NNakreSS/polyZoneCreator/assets/87872407/f105b617-91f2-47fa-9fb5-749ce935d5bb)
