ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()

  while true do

  Citizen.Wait(1)
    local ped = PlayerPedId()
    local mycords = GetEntityCoords(ped)
   for _, locations in pairs(Config.kincs) do
   if GetDistanceBetweenCoords(mycords, locations, true) < Config.tavolsag then
    DrawText3Ds(locations.x, locations.y, locations.z, Config.szoveg) 
    if IsControlJustReleased(0,38) then
     local gyemantvagypenz = math.random(1, Config.nyeremenyesely)
     if gyemantvagypenz == 1 then
       TriggerEvent('anim')
       Citizen.Wait(5000)
     TriggerServerEvent('mesterkincstargy')
     Citizen.Wait(50)
     ESX.ShowNotification(Config.gyemant, true, true, false)
     Citizen.Wait(Config.varakozas)
     elseif gyemantvagypenz == 2 then
       TriggerEvent('anim')
       Citizen.Wait(5000)
       TriggerServerEvent('mesterkincspenzsok')
       Citizen.Wait(50)
       ESX.ShowNotification(Config.penz, true, true, false)
   Citizen.Wait(Config.varakozas)
     else
   TriggerEvent('anim')
   Citizen.Wait(5000)
   TriggerServerEvent('mesterkincspenz')
   Citizen.Wait(50)
   ESX.ShowNotification(Config.penz, true, true, false)
Citizen.Wait(Config.varakozas)

end   
end
end
end
end
end)

Citizen.CreateThread(function()
local nbObjetsCrees = 0
while nbObjetsCrees < 1 do
 for _, locations in pairs(Config.kincs) do
local kincs = CreateObject(Config.object, locations.x, locations.y, locations.z, false, false, false)
     PlaceObjectOnGroundProperly(kincs)
 nbObjetsCrees = nbObjetsCrees + 1
 
end
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
