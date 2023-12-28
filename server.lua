
RegisterServerEvent('timesync:requestSync')
AddEventHandler('timesync:requestSync', function()
    TriggerClientEvent('timesync:updateTime', -1, tonumber(os.date("%H")), tonumber(os.date("%M")) )
end)



Citizen.CreateThread(function()
    while true do
        
        TriggerClientEvent('timesync:updateTime', -1, tonumber(os.date("%H")), tonumber(os.date("%M")) )
        Citizen.Wait(10000)
    end
end)