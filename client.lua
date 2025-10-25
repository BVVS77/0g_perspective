local lastView = Config.DefaultView
local forcedView = nil -- nil = free mode, number = forced view
local locale = Locales[Config.Locale] or Locales["en"]

-- Notification function
local function notify(msg)
    if Config.Framework == "esx" then
        if ESX then ESX.ShowNotification(msg) end
    elseif Config.Framework == "qb" then
        if QBCore and QBCore.Functions then
            QBCore.Functions.Notify(msg, "primary", 5000)
        end
    elseif Config.Framework == "ox" then
        if lib and lib.notify then
            lib.notify({ title = "Perspective", description = msg, type = "inform" })
        end
    else
        TriggerEvent("chat:addMessage", { args = {"[Perspective]", msg} })
    end
end

-- Camera setter
local function setCameraView(mode, skipSave)
    if not Config.AllowedViews[mode] then
        notify(locale.blocked)
        return
    end
    SetFollowPedCamViewMode(mode)
    lastView = mode
    if not skipSave then
        TriggerServerEvent("zerogravity:saveView", mode)
    end
    if mode == 4 then notify(locale.first_person)
    elseif mode == 0 then notify(locale.third_near)
    elseif mode == 2 then notify(locale.third_far) end
end

-- Handle forced view from server
RegisterNetEvent("zerogravity:forceView", function(mode)
    if mode == "off" then
        forcedView = nil
        notify("Forced perspective disabled. You can switch again.")
    else
        forcedView = mode
        setCameraView(mode, true)
        notify("Forced perspective enabled.")
    end
end)

-- Commands
RegisterCommand("firstperson", function() if not forcedView then setCameraView(4) end end)
RegisterCommand("thirdperson", function() if not forcedView then setCameraView(0) end end)
RegisterCommand("thirdperson2", function() if not forcedView then setCameraView(2) end end)

-- Key toggle
CreateThread(function()
    while true do
        Wait(0)
        if not forcedView and IsControlJustPressed(0, Config.ToggleKey) then
            local nextView
            if lastView == 4 then
                nextView = Config.AllowedViews[0] and 0 or (Config.AllowedViews[2] and 2 or 4)
            elseif lastView == 0 then
                nextView = Config.AllowedViews[2] and 2 or (Config.AllowedViews[4] and 4 or 0)
            elseif lastView == 2 then
                nextView = Config.AllowedViews[4] and 4 or (Config.AllowedViews[0] and 0 or 2)
            else
                nextView = Config.DefaultView
            end
            setCameraView(nextView)
        end
    end
end)

-- Wymuszanie kamery przy celowaniu
CreateThread(function()
    while true do
        Wait(0)
        local ped = PlayerPedId()
        if DoesEntityExist(ped) and not IsEntityDead(ped) then
            if IsPlayerFreeAiming(PlayerId()) or IsControlPressed(0, 25) then -- celowanie PPM
                if forcedView then
                    -- zawsze wymusza widok z serwera
                    SetFollowPedCamViewMode(forcedView)
                else
                    -- jeśli gracz ma własny zapisany widok
                    SetFollowPedCamViewMode(lastView or Config.DefaultView)
                end
            end
        end
    end
end)

-- Load saved or default on join
RegisterNetEvent("zerogravity:loadView", function(mode)
    if forcedView then
        setCameraView(forcedView, true)
        return
    end
    local view = mode or Config.DefaultView
    if not Config.AllowedViews[view] then view = Config.DefaultView end
    Wait(1000)
    setCameraView(view)
end)
