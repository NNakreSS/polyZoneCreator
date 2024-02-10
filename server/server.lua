RegisterCommand("polyzone-create", function(src)
    -- if IsPlayerAceAllowed(src, "admin") then -- isAdmin
    TriggerClientEvent("start-polyzone-create", src)
    -- end
end)
