--
-- THREADS
--

ESX                           = nil

local ped = { x= 190.03, y= -905.66, z= 30.8, rotation = 193.45,NetworkSync = true}


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)



-- MENSAJE DEL NPC

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if GetDistanceBetweenCoords(ped.x,ped.y,ped.z,GetEntityCoords(GetPlayerPed(-1), true)) < 3 then
			ESX.ShowFloatingHelpNotification('~r~[E]~w~ ¿Quieres pedir algo?', vector3(190.03, -905.66, 32.6))
			--DrawText3D(ped.x,ped.y,ped.z + 2, "Pulsa E para ver las motos", 255,255,255)
			if IsControlJustPressed(1,38) then --and policia() then
				
			end
		end
	end
end)

------------------------------
------------CREAR NPC---------
------------------------------


Citizen.CreateThread(function()
    wanted_model= "a_f_y_vinewood_02"
    modelHash = GetHashKey(wanted_model)
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
       	Wait(1)
    end
    createNPC() 
end)

function createNPC()
    --PRIMER NPC
	created_ped3 = CreatePed(5, modelHash , ped.x,ped.y,ped.z, ped.rotation, false, ped.NetworkSync)
	FreezeEntityPosition(created_ped3, true)
	SetEntityInvincible(created_ped3, true)
	SetBlockingOfNonTemporaryEvents(created_ped3, true)
	TaskStartScenarioInPlace(created_ped3, "", 0, true)
end


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local _sleep = true
		local _ped = PlayerPedId()
		local _pos = GetEntityCoords(_ped)
		for i = 1, #Config.Zones, 1 do
			local dist = #((Config.Zones[i]) - vector3(_pos))
			if dist < 10 then
				_sleep = false
				-- DrawText3D(Config.Zones[i], "~g~E~s~ - Para pedir")
				if dist < 3 then
					if IsControlJustPressed(0, 38) then
						open(true)
					end
				end
			end
		end
		if _sleep then Citizen.Wait(1000) end
	end
end)

--
-- CALLBACKS
--

RegisterNUICallback("realizarpedido", function(data)
    TriggerServerEvent('BMX-MCDONALDS:realizarpedido', data)
end)

RegisterNUICallback("exit", function(data)
    open(false)
end)

--
-- FUNCS
--

open = function(toggle)
    display = toggle
    SetNuiFocus(toggle, toggle)
    SendNUIMessage({
        type = "ui",
        status = toggle,
    })
end

DrawText3D = function(zone, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(zone, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end
