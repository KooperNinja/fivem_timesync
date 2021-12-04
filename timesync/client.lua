
--Detect when player spawns and Requests time sync
AddEventHandler('playerSpawned', function()
    TriggerServerEvent('timesync:requestSync')
end)

local hours
local min
RegisterNetEvent('timesync:updateTime')
AddEventHandler('timesync:updateTime', function(h, m)
    SetMillisecondsPerGameMinute(60000)
    hours = h
    min = m
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        AddToClockTime(hours, min, 0)
        NetworkOverrideClockTime(hours, min, 0)
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