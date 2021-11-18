local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Commands.Add("broadcast", "Broadcast to the server", {{name = "message", help = "The message to broadcast"}}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
     if Player.PlayerData.job.name == "reporter" and Player.PlayerData.job.grade.level >= 1 then
       local msg = table.concat(args, ' ')
       if msg == '' then return end
       TriggerClientEvent('chat:addMessage', -1, {
        color = { 66, 245, 123},
        multiline = true,
        args = {"Weazel News Broadcast", msg}
       })
     end
end)