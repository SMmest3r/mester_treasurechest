ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function sendToDiscord(name, message)
	if message == nil or message == '' then return FALSE end
	PerformHttpRequest(Config.discord, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
  end

RegisterServerEvent('mestertreasuremoneymore')
AddEventHandler('mestertreasuremoneymore', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(source)
    sendToDiscord('Mester treasure chest system', GetPlayerName(source) .. Config.dcmessagemoney)
    if Config.cash == true then
        xPlayer.addMoney(Config.winbig)
    else
        xPlayer.addAccountMoney('bank', Config.winbig)
    end
    end)

    RegisterServerEvent('mestertreasuremoney')
AddEventHandler('mestertreasuremoney', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(source)
    sendToDiscord('Mester treasure chest system', GetPlayerName(source) .. Config.dcmessagelessitem)
    if Config.cash == true then
        xPlayer.addMoney(Config.win)
    else
        xPlayer.addAccountMoney('bank', Config.win)
    end
    end)

RegisterServerEvent('mestertreasureitem')
AddEventHandler('mestertreasureitem', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    sendToDiscord('Mester treasure chest system', GetPlayerName(source) .. Config.dcmessageitem)
    xPlayer.addInventoryItem(Config.winitem, Config.winitemamount)
    end)

RegisterServerEvent('mesterkeycheck')
AddEventHandler('mesterkeycheck', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local oneQuantity = xPlayer.getInventoryItem(Config.keyitem).count
	
	if oneQuantity > 0 then
		TriggerClientEvent('mesterkeytrue', source) -- true
        xPlayer.removeInventoryItem(Config.keyitem, 1)
	else
		TriggerClientEvent('mesterkeyfalse', source) -- false
	end
end)
