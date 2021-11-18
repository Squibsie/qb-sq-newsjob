local QBCore = exports['qb-core']:GetCoreObject()
local PlayerJob = {}
local garageCoords = vector3(Config.locations["garage"].coords.x, Config.locations["garage"].coords.y, Config.locations["garage"].coords.z)
local veh

local function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerJob = QBCore.Functions.GetPlayerData().job

    if PlayerJob.name == "reporter" then
        local newsBlip = AddBlipForCoord(garageCoords)
        SetBlipSprite(newsBlip, 225)
        SetBlipDisplay(newsBlip, 4)
        SetBlipScale(newsBlip, 0.6)
        SetBlipAsShortRange(newsBlip, true)
        SetBlipColour(newsBlip, 1)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(Config.locations["garage"].label)        
        EndTextCommandSetBlipName(newsBlip)
    end
end)

Citizen.CreateThread(function()
   while true do
     local sleep = 500
     if PlayerJob.name == "reporter" then
       sleep = 1
       local ped = PlayerPedId()
       local pos = GetEntityCoords(ped)
       local dist = #(pos - garageCoords)
       
       if dist < 10.0 then
         DrawText3D(Config.locations["garage"].coords.x, Config.locations["garage"].coords.y, Config.locations["garage"].coords.z, "~g~E~w~ - Spawn/Store News Van")
         if (IsControlJustReleased(0, 38)) then
           if IsPedInAnyVehicle(PlayerPedId(), false) then
             if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), true), GetHashKey("rumpo")) then
               DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
             else
               BeginTextCommandDisplayHelp("THREESTRINGS")
               -- Add 3 strings, because we used "THREESTRINGS" above.
               AddTextComponentSubstringPlayerName("Park and exit your vehicle first.")               
               -- End the command and display the help message.
               EndTextCommandDisplayHelp(0, false, true, 6000)
             end
           else
             QBCore.Functions.SpawnVehicle("rumpo", function(veh)
                 SetVehicleNumberPlateText(veh, "WZNW"..tostring(math.random(1000, 9999)))
                 SetEntityHeading(veh, garageCoords.w)
                 exports['LegacyFuel']:SetFuel(veh, 100.0)
                 TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                 --TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
                 SetVehicleEngineOn(veh, true, true)
                 SetVehicleLivery(veh, 2)
                 CurrentPlate = QBCore.Functions.GetPlate(veh)
               end, garageCoords, true)
           end
         end
       end
     end
     Citizen.Wait(sleep)
   end
   
 end)

