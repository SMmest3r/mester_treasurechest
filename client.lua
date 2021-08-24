ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local havekey = false

RegisterNetEvent('mesterkeytrue')
AddEventHandler('mesterkeytrue', function()
	 havekey = true
  TriggerServerEvent('mesterkeyremove')
end)

RegisterNetEvent('mesterkeyfalse')
AddEventHandler('mesterkeyfalse', function()
      havekey = false
  end)

Citizen.CreateThread(function()

  while true do

  Citizen.Wait(1)
    local ped = PlayerPedId()
    local mycords = GetEntityCoords(ped)
   for _, locations in pairs(Config.treasure) do
   if GetDistanceBetweenCoords(mycords, locations, true) < Config.distance then
    DrawText3Ds(locations.x, locations.y, locations.z, Config.text) 
    if IsControlJustReleased(0,38) then
    TriggerServerEvent('mesterkeycheck')
    Citizen.Wait(500)
    if havekey == false then
      ESX.ShowNotification(Config.nokeytext, true, true, false)
    else
     local itemormoney = math.random(1, Config.winchance)
     if itemormoney == 1 then
       TriggerEvent('anim')
       Citizen.Wait(5000)
     TriggerServerEvent('mestertreasureitem')
     Citizen.Wait(50)
     ESX.ShowNotification(Config.item, true, true, false)
     Citizen.Wait(Config.wait)
     elseif itemormoney == 2 then
       TriggerEvent('anim')
       Citizen.Wait(5000)
       TriggerServerEvent('mestertreasuremoneymore')
       Citizen.Wait(50)
       ESX.ShowNotification(Config.money, true, true, false)
   Citizen.Wait(Config.wait)
     else
   TriggerEvent('anim')
   Citizen.Wait(5000)
   TriggerServerEvent('mestertreasuremoney')
   Citizen.Wait(50)
   ESX.ShowNotification(Config.money, true, true, false)
Citizen.Wait(Config.wait)
end
end   
end
end
end
end
end)

Citizen.CreateThread(function()
 for _, locations in pairs(Config.treasure) do
local treasure = CreateObject(Config.object, locations.x, locations.y, locations.z, false, false, false)
     PlaceObjectOnGroundProperly(treasure)
end
end)

RegisterNetEvent('anim')
AddEventHandler('anim', function()
local playerPed = GetPlayerPed(-1)
 TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_TEND_TO_DEAD", -1, true)
 Citizen.Wait(3900)
 TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_TEND_TO_DEAD", -1, false)
 Citizen.Wait(1000)
 ClearPedTasksImmediately(playerPed)
 ClearPedTasks(playerPed)
end)

RegisterNetEvent('mesterkeycheck3')
AddEventHandler('mesterkeycheck3', function()
  TriggerServerEvent('mesterkeycheck2', source)
end)

function DrawText3Ds(x,y,z, text)
  local onScreen,_x,_y=World3dToScreen2d(x,y,z)
  local px,py,pz=table.unpack(GetGameplayCamCoords())
  SetTextScale(0.35, 0.35)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextColour(255, 255, 255, 215)
  SetTextEntry("STRING")
  SetTextCentre(1)
  AddTextComponentString(text)
  DrawText(_x,_y)
  local factor = (string.len(text)) / 370
  DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
 end
