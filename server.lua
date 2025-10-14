local playerViews = {}
local forcedView = nil -- nil = off, number = forced

RegisterNetEvent("zerogravity:saveView", function(mode)
    local src = source
    if not forcedView then
        playerViews[src] = mode
    end
end)

AddEventHandler("playerJoining", function()
    local src = source
    local view = playerViews[src] or Config.DefaultView
    if forcedView then
        TriggerClientEvent("zerogravity:forceView", src, forcedView)
    else
        TriggerClientEvent("zerogravity:loadView", src, view)
    end
end)

AddEventHandler("playerDropped", function()
    local src = source
    playerViews[src] = nil
end)

-- /forceview command
RegisterCommand("forceview", function(src, args)
    if Config.AdminSystem == "ace" and src ~= 0 then
        if not IsPlayerAceAllowed(src, "zerogravity.forceview") then
            TriggerClientEvent("chat:addMessage", src, { args = {"System", "No permission!"} })
            return
        end
    end

    local mode = args[1] and string.lower(args[1]) or "off"
    if mode == "first" then
        forcedView = 4
    elseif mode == "third" then
        forcedView = 0
    elseif mode == "third2" then
        forcedView = 2
    elseif mode == "off" then
        forcedView = nil
    else
        if src > 0 then
            TriggerClientEvent("chat:addMessage", src, { args = {"System", "Usage: /forceview [first|third|third2|off]"} })
        end
        return
    end

    -- Apply to all players
    for _, id in pairs(GetPlayers()) do
        if forcedView then
            TriggerClientEvent("zerogravity:forceView", id, forcedView)
        else
            local view = playerViews[id] or Config.DefaultView
            TriggerClientEvent("zerogravity:forceView", id, "off")
            TriggerClientEvent("zerogravity:loadView", id, view)
        end
    end

    print(("Forceview changed to: %s"):format(mode))
end, false)
