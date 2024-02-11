# Polyzone Creator

> **A script tool that facilitates easier creation of polyzones using the PolyZone script.**

> **Dependencies** : https://github.com/mkafrin/PolyZone

## example

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
        --     polyzone = polyzone,
        --     error = string
        --   }
        print(json.encode(data))
    end , options -- (optional) )
end)
```

![Ekran görüntüsü 2024-02-11 183008](https://github.com/NNakreSS/polyZoneCreator/assets/87872407/5cddda80-fb4c-4522-aa0d-7f1e4da66081)

![image](https://github.com/NNakreSS/polyZoneCreator/assets/87872407/f105b617-91f2-47fa-9fb5-749ce935d5bb)

