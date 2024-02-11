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
