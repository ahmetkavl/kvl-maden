ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('kvl-maden:washstones')
AddEventHandler('kvl-maden:washstones', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getInventoryItem('stones').count >= 5 then
        if xPlayer.canCarryItem('washed_stones', 1) then
            xPlayer.addInventoryItem('washed_stones', 1)
            Citizen.Wait(5)
            xPlayer.removeInventoryItem('stones', 5)
        end
    end
end)

RegisterServerEvent('kvl-maden:collectstone')
AddEventHandler('kvl-maden:collectstone', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local count = KVL.GiveStoneCount
    if xPlayer.canCarryItem('stones', count) then
        xPlayer.addInventoryItem('stones', count)
        TriggerClientEvent('esx:showNotification', src, ' '..count..' adet taş topladın')
    else
        TriggerClientEvent('esx:showNotification', src, 'Üzerinde yeterli alan yok!')
    end
end)

RegisterNetEvent("kvl-maden:mixingstones")
AddEventHandler("kvl-maden:mixingstones", function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local removecount = KVL.RemoveWashedStoneCount
    local myluck = math.random(1, 100)

    if xPlayer.getInventoryItem('washedstones').count > 9 then
        -- Elmas
        if myluck > 1 and myluck < 5 then
            xPlayer.addInventoryItem('diamond', math.random(KVL.GiveMinDiamondCount, KVL.GiveMaxDiamondCount))
            xPlayer.removeInventoryItem('washedstones', removecount)
        -- Altın
        elseif myluck > 6 and myluck < 30 then
            xPlayer.addInventoryItem('gold', math.random(KVL.GiveMinGoldCount, KVL.GiveMaxGoldCount))
            xPlayer.removeInventoryItem('washedstones', removecount)
        -- Demir
        elseif myluck > 31 and myluck < 50 then
            xPlayer.addInventoryItem('iron', math.random(KVL.GiveMinIronCount, KVL.GiveMaxIronCount))
            xPlayer.removeInventoryItem('washedstones', removecount)
        -- Bakır
        elseif myluck > 51 and myluck < 80 then
            xPlayer.addInventoryItem('copper', math.random(KVL.GiveMinCopperCount, KVL.GiveMaxCopperCount))
            xPlayer.removeInventoryItem('washedstones', removecount)
        -- Kömür
        elseif myluck > 81 and myluck < 100 then
            xPlayer.addInventoryItem('coal', math.random(KVL.GiveMinCoalCount, KVL.GiveMaxCoalCount))
            xPlayer.removeInventoryItem('washedstones', removecount)
        end
    end
end)