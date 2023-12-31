
--Detect when player spawns and Requests time sync
AddEventHandler('playerSpawned', function()
    TriggerServerEvent('timesync:requestSync')
end)

local hours
local min

local realTime = true

RegisterNetEvent('timesync:updateTime')
AddEventHandler('timesync:updateTime', function(h, m, setRealTime, msecPerGM)
    if setRealTime == nil then
        setRealTime = true
    end
    if msecPerGM == nil then
        msecPerGM = 60000
    end
    if (h ~= nil) and (m ~= nil) then 
        hours = tonumber(h)
        min = tonumber(m)
    end
    Citizen.Wait(10)
    realTime = setRealTime
    Citizen.Wait(10)
    SetMillisecondsPerGameMinute((tonumber(msecPerGM)))
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if (hours ~= nil and min ~= nil) then
            AddToClockTime(hours, min, 0)
            NetworkOverrideClockTime(hours, min, 0) 
        end
    end
end)

--[[
RegisterCommand('getNetworkTime', function()
    local gms = GetMillisecondsPerGameMinute()
    local h = GetClockHours()
    local m = GetClockMinutes()
    print(h..':'..m)
    print('GameMS: '..gms)
end)

RegisterCommand('requestTS', function()
    TriggerServerEvent('timesync:requestSync')
end)
]]--