ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local text = true

Citizen.CreateThread(function()
    while true do
        local sleep = 1250
        local ped = PlayerPedId()
        local pCoords = GetEntityCoords(ped)

    for k,v in pairs (KVL.PickLocations) do
        local pickdst = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, KVL.PickLocations[k].x, KVL.PickLocations[k].y, KVL.PickLocations[k].z, false)
    if text then
        if pickdst < 1 then
            DisplayHelpText('[E] - Taş kaz')
        end
          if pickdst < 2 then
            sleep = 3
            DrawMarker(2, KVL.PickLocations[k].x, KVL.PickLocations[k].y, KVL.PickLocations[k].z - 0.2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.2, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
            if IsControlJustPressed(0, 38) then
                text = false
                RequestAnimDict("melee@large_wpn@streamed_core")
                Citizen.Wait(100)
                -- TaskPlayAnim((ped), 'melee@large_wpn@streamed_core', 'ground_attack_on_spot', 8.0, 8.0, -1, 80, 0, 0, 0, 0)
                TaskPlayAnim(PlayerPedId(), "melee@large_wpn@streamed_core", "ground_attack_on_spot", 8.0, -8.0, -1, 1, 0, false, false, false)
                SetEntityHeading(ped, 270.0)
                TriggerServerEvent('InteractSound_SV:PlayOnSource', 'pickaxe', 0.5)
                pickaxe = CreateObject(GetHashKey("prop_tool_pickaxe"), 0, 0, 0, true, true, true) 
                AttachEntityToEntity(pickaxe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.18, -0.02, -0.02, 350.0, 100.00, 140.0, true, true, false, true, 1, true)
                TriggerEvent("mythic_progbar:client:progress", {
                    name = "kvl-maden",
                    duration = 15000,
                    label = "Taş kazıyorsun",
                    useWhileDead = false,
                    canCancel = true,
                    controlDisables = {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    },
                    animation = {
                        animDict = "missheistdockssetup1clipboard",
                        anim = "idle_a",
                    }
                }, function(status)
                    if not status then
                        TriggerServerEvent("kvl-maden:collectstone", false) 
                        ClearPedTasks(ped)
                        text = true
                        DeleteObject(pickaxe)
                end
            end) 
            end
        end
       end
    end
    if text then
     local mixdst = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, KVL.MixingLocation.x, KVL.MixingLocation.y, KVL.MixingLocation.z, false)
        if mixdst < 1 then
            DisplayHelpText('[E] - Taş erit')
        end
        if mixdst < 5 then
        sleep = 3
        DrawMarker(2, KVL.MixingLocation.x, KVL.MixingLocation.y, KVL.MixingLocation.z - 0.2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.2, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
        if IsControlJustPressed(0, 38) then
            ESX.TriggerServerCallback('kvl-maden:checkItem', function(laotabicore)
            if laotabicore then
            text = false
            FreezeEntityPosition(ped, true)
            TriggerEvent("mythic_progbar:client:progress", {
                name = "kvl-maden",
                duration = 5000,
                label = "Taş eritiyorsun",
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = "mp_arresting",
                    anim = "a_uncuff",
                    flags = 49,
                },
            }, function(status)
                if not status then
                    TriggerServerEvent("kvl-maden:mixingstones") 
                    ClearPedTasks(ped)
                    text = true
                    FreezeEntityPosition(ped, false)
            end
        end)
    end
    end, "washedstones", 10)
    end
end
if text then
    local washdst = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, KVL.WashLocation.x, KVL.WashLocation.y, KVL.WashLocation.z, false)
    if washdst < 1 then
        DisplayHelpText('[E] - Taş yıka')
    end
    if washdst < 5 then
        sleep = 3
        DrawMarker(2, KVL.WashLocation.x, KVL.WashLocation.y, KVL.WashLocation.z - 0.2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.2, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
    if IsControlJustPressed(0, 38) then
    ESX.TriggerServerCallback('kvl-maden:checkItem', function(itemkontrol) 
        if itemkontrol then
        text = false
        FreezeEntityPosition(ped, true)
        ExecuteCommand('e mekanik')
        TriggerEvent("mythic_progbar:client:progress", {
            name = "kvl-maden",
            duration = 5000,
            label = 'Taşlar yıkanıyor',
            useWhileDead = false,
            canCancel = true,
             controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            }, function(status)
            if not status then
                TriggerServerEvent("kvl-maden:washstones") 
                ClearPedTasks(ped)
                text = true
                ExecuteCommand('e c')
                FreezeEntityPosition(ped, false)
            end
        end)
    end
    end, "stones", 5)
    end

   end
end
end
    Citizen.Wait(sleep)
 end
end)

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

Citizen.CreateThread(function()
    for k,v in pairs (KVL.Blips) do
    local blip = AddBlipForCoord(KVL.Blips[k].x, KVL.Blips[k].y, KVL.Blips[k].z)
    SetBlipSprite(blip, KVL.Blips[k].sprite)
    SetBlipScale(blip, KVL.Blips[k].scale)
    SetBlipAsShortRange(blip, true)
    SetBlipColour(blip, KVL.Blips[k].color)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(KVL.Blips[k].name)
    EndTextCommandSetBlipName(blip)
    end
end)