ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('kvl-maden:washstones')
AddEventHandler('kvl-maden:washstones', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getInventoryItem('stones').count >= 5 then
        if xPlayer.canCarryItem('washedstones', 1) then
            xPlayer.addInventoryItem('washedstones', 1)
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
    local diacount = math.random(KVL.GiveMinDiamondCount, KVL.GiveMaxDiamondCount)
    local goldcount = math.random(KVL.GiveMinGoldCount, KVL.GiveMaxGoldCount)
    local ironcount = math.random(KVL.GiveMinIronCount, KVL.GiveMaxIronCount)
    local coppercount = math.random(KVL.GiveMinCopperCount, KVL.GiveMaxCopperCount)
    local coalcount = math.random(KVL.GiveMinCoalCount, KVL.GiveMaxCoalCount)
    local myluck = math.random(1, 100)

    if xPlayer.getInventoryItem('washedstones').count > 9 then
        -- Elmas
        if myluck > 1 and myluck < 5 then
            if xPlayer.canCarryItem('diamond', diacount) then 
             xPlayer.addInventoryItem('diamond', diacount)
             xPlayer.removeInventoryItem('washedstones', removecount)
            else
                TriggerClientEvent('esx:showNotification', src, 'Envanterinde yeterli alan yok!')
            end
        -- Altın
        elseif myluck > 6 and myluck < 30 then
            if xPlayer.canCarryItem('diamond', goldcount) then 
            xPlayer.addInventoryItem('gold', goldcount)
            xPlayer.removeInventoryItem('washedstones', removecount)
            else
            TriggerClientEvent('esx:showNotification', src, 'Envanterinde yeterli alan yok!')
            end
        -- Demir
        elseif myluck > 31 and myluck < 50 then
            if xPlayer.canCarryItem('iron', ironcount) then
            xPlayer.addInventoryItem('iron', ironcount)
            xPlayer.removeInventoryItem('washedstones', removecount)
            else
            TriggerClientEvent('esx:showNotification', src, 'Envanterinde yeterli alan yok!')
        end
        -- Bakır
        elseif myluck > 51 and myluck < 80 then
            if xPlayer.canCarryItem('copper', coppercount) then
            xPlayer.addInventoryItem('copper', coppercount)
            xPlayer.removeInventoryItem('washedstones', removecount)
            else
            TriggerClientEvent('esx:showNotification', src, 'Envanterinde yeterli alan yok!')
            end
        -- Kömür
        elseif myluck > 81 and myluck < 100 then
            if xPlayer.canCarryItem('coal', coalcount) then
            xPlayer.addInventoryItem('coal', coalcount)
            xPlayer.removeInventoryItem('washedstones', removecount)
            else
                TriggerClientEvent('esx:showNotification', src, 'Envanterinde yeterli alan yok!')
            end
        end
    end
end)

ESX.RegisterServerCallback('kvl-maden:checkItem', function(source, cb, item, gereklisayi)
	local xPlayer = ESX.GetPlayerFromId(source)
    local itemcount = xPlayer.getInventoryItem(item).count
    local itemname = xPlayer.getInventoryItem(item).label
	if itemcount >= gereklisayi then
		cb(true)
	else
        activity = 0
        TriggerClientEvent('esx:showNotification', source, 'Üzerinde yeterli '..itemname..' yok!')
	end
end)
