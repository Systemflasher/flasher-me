-----<Written by flasher>-----Discord:flasher#0271 >


local color = {r = 44, g = 147, b = 150, alpha = 255} 
local font = 0 
local time = 500 

local PlayerData = {}
ESX = nil

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

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

RegisterCommand('me', function(source, args)
    local text = '*'
    for i = 1,#args do
        text = text .. ' ' .. args[i]
    end
    text = text .. ' *'
    TriggerServerEvent('3dme:shareDisplay', text)
end)

RegisterNetEvent('flasher:adminme')
AddEventHandler('flasher:adminme', function(id, meddelande)
    local source = id
    
    TriggerServerEvent('3dme:shareDisplay', meddelande)
end)

-------------------------------------------------------------------------------------------------------------


RegisterNetEvent('3dme:triggerDisplay')
AddEventHandler('3dme:triggerDisplay', function(text, source)
    Display(GetPlayerFromServerId(source), text)
end)

function Display(mePlayer, text)
    local timer = 0
    while timer < time do
        Wait(0)
        timer = timer + 1
        local coords = GetEntityCoords(GetPlayerPed(mePlayer), false)
        DrawText3D(coords['x'], coords['y'], coords['z']+1, text)
    end
end

RegisterNetEvent('flasher:metext')
AddEventHandler('flasher:metext', function(id, name, message)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)

    if pid == myId then
        local playerPed = GetPlayerPed(-1)
        TriggerEvent('skinchanger:getSkin', function(skin)
            if skin['mask_1'] == 0 or skin['mask_1'] == 11 or skin['mask_1'] == 73 or skin['mask_1'] == 11 or skin['mask_1'] == 107 or skin['mask_1'] == 11 or skin['mask_1'] == 120 or skin['mask_1'] == 121 then
                TriggerEvent('chat:addMessage', {
                    template = '<div style="padding: 0.4vw; margin: 0.7vw; width: 30%; background-color: rgba(44, 147, 150, 0.6); border-radius: 3px;"><i class="fas fa-user-circle"></i>❕ <span style="font-weight: 700">{0}</span><br> {1}</div>',
                    args = { name, message }
                })
            else
                TriggerEvent('chat:addMessage', {
                    template = '<div style="padding: 0.4vw; margin: 0.7vw; width: 30%; background-color: rgba(44, 147, 150, 0.6); border-radius: 3px;"><i class="fas fa-user-circle"></i>❕ <span style="font-weight: 700">Maskerad man</span><br> {1}</div>',
                    args = { name, message }
                })
            end
        end)
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 15.4 then
        local playerPed = GetPlayerPed(-1)
        TriggerEvent('skinchanger:getSkin', function(skin)
            if skin['mask_1'] == 0 or skin['mask_1'] == 11 or skin['mask_1'] == 73 or skin['mask_1'] == 11 or skin['mask_1'] == 107 or skin['mask_1'] == 11 or skin['mask_1'] == 120 or skin['mask_1'] == 121 then
                TriggerEvent('chat:addMessage', {
                    template = '<div style="padding: 0.4vw; margin: 0.7vw; width: 30%; background-color: rgba(44, 147, 150, 0.6); border-radius: 3px;"><i class="fas fa-user-circle"></i>❕ <span style="font-weight: 700">{0}</span><br> {1}</div>',
                    args = { name, message }
                })
            else
                TriggerEvent('chat:addMessage', {
                    template = '<div style="padding: 0.4vw; margin: 0.7vw; width: 30%; background-color: rgba(44, 147, 150, 0.6); border-radius: 3px;"><i class="fas fa-user-circle"></i>❕ <span style="font-weight: 700">Maskerad man</span><br> {1}</div>',
                    args = { name, message }
                })
            end
        end)
    end
end)

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)
    local px,py,pz = table.unpack(GetGameplayCamCoord())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    if onScreen then
        SetTextScale(0.0*scale, 0.35*scale)
        SetTextFont(font)
        SetTextProportional(1)
        SetTextColour(color.r, color.g, color.b, color.alpha)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(true)
        AddTextComponentString(text)
        EndTextCommandDisplayText(_x, _y)
    end
end