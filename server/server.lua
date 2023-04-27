local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('SY_Notify:setMeta')
AddEventHandler('SY_Notify:setMeta', function(positiondata)
    local Player = QBCore.Functions.GetPlayer(source)
    MySQL.query('SELECT * FROM sy_notify WHERE identifier = ?', {Player.PlayerData.citizenid}, function(result)
        if result[1] ~= nil then
            MySQL.update('UPDATE sy_notify SET  position = ? WHERE identifier = ?', {positiondata, Player.PlayerData.citizenid},
                function()
                end)
        else
            MySQL.insert('INSERT INTO sy_notify (identifier, position) VALUES (?, ?)',
                {Player.PlayerData.citizenid, positiondata}, function()
                end)
        end
    end)
end)

QBCore.Functions.CreateCallback('SY_Notify:getMeta', function(src, cb)
    local Player = QBCore.Functions.GetPlayer(src)
    local result = MySQL.query.await('SELECT * FROM sy_notify WHERE identifier = ?', {Player.PlayerData.citizenid})
    if result[1] ~= nil then
        for i = 1, #result do
            local row = result[i]
            position = row.position
        end
    else
        position = Config.Defaultposition
    end
    cb(position)
end)
