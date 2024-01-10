CONFIG = {
    ACL_PERMISSION = "Console",
    COMMAND_PED_CREATE = "drugped", -- /drugped Nome, PosX, PosY e PosZ
    DRUGS_VALUE = math.random(9595, 13545), -- Valor Que o Player Receberá Ao Vender As Drogas
    CLOSE_PANEL = "backspace", -- Tecla Para Fechar o Painel

    PANEL = {
        COLOR_BUTTON = {134, 171, 135}, -- Cor Do Botão
        COLOR_HOVER_BUTTON = {89, 139, 91}, -- Cor Do Botão Após Passar o Cursor Por Cima.
    },
}

--/ UTILS /--
function createEvent(event, ...)
    addEvent(event, true)
    addEventHandler(event, ...)
end

function notifyS(player, message, type)
    exports["sua_infobox"]:addNotification(player, message, type)
end

function notifyC(message, type)
    exports["sua_infobox"]:addNotification(message, type)
end