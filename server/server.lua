local smallTimeInterval = 100

local syncedHours
local syncedMinutes
local syncDelay = 10000

local realTime = true

--Realtime
Citizen.CreateThread(function ()
    while true do

        Citizen.Wait(10000)
        if realTime == true then 
            syncedHours = tonumber(os.date("%H"))
            syncedMinutes = tonumber(os.date("%M"))
            TriggerClientEvent('timesync:updateTime', -1, syncedHours, syncedMinutes)
        end
    end
end)

RegisterNetEvent('timesync:requestSync')
AddEventHandler('timesync:requestSync', function()
    realTime = true
    syncedHours = tonumber(os.date("%H"))
    syncedMinutes = tonumber(os.date("%M"))
    TriggerClientEvent('timesync:updateTime', -1, syncedHours, syncedMinutes)
end)

RegisterNetEvent('timesync:setTimePan')
AddEventHandler('timesync:setTimePan', function(active, args)
    if not active then 
        TriggerClientEvent('timesync:updateTime', -1)
        return
    end
    realTime = false
    TriggerClientEvent('timesync:updateTime', -1, args[1], args[2], false, args[3])
end)


RegisterCommand('setRealTime', function (source, args)
    print("Set real")
    TriggerEvent('timesync:requestSync')
end, true)

RegisterCommand('startTimePan', function (source, args)
    TriggerEvent('timesync:setTimePan', true, args)
end, true)

RegisterCommand('stopTimePan', function (source, args)
    TriggerEvent('timesync:setTimePan', false)
end, true)

local function getTimeFromDate(hours, minutes)
    return tonumber(os.time({year=1970, month=1, day=1, hour=hours, min=minutes}))
end

local function getDateFromTime(time)
    local h = os.date("%H", time)
    local m = os.date("%M", time)
    return h, m
end

local function performTimePan(startHours, startMinutes, endHours, endMinutes, time)
    Citizen.CreateThread(function ()
        local intervals = tonumber(time / smallTimeInterval)
        local totalTimeDistance = getTimeFromDate(startHours, startMinutes) - getTimeFromDate(endHours, endMinutes)
        local timePerInterval = totalTimeDistance / intervals
        syncDelay = 100
        for i=1, intervals, 1 do
            
        end
    end)
end