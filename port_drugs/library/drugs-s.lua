--/ Connection DB /--
local dbMysql = dbConnect("mysql", "dbname=drugas;host=SEUHOST;charshet=utf-8", "SEUUSER", "SUASENHA")

function loadPeds()
    local query = dbQuery(dbMysql, "SELECT * FROM peds")
    local result = dbPoll(query, -1)

    if result and #result > 0 then
        for _, row in ipairs(result) do
            local ped = createPed(73, row.posX, row.posY, row.posZ, 0)
        end
        outputDebugString("[Leo Developer - Portfólio] Peds do Banco Criados Com Sucesso!")
    else
        outputDebugString("[Leo Developer - Portfólio] Nenhum ped encontrado no banco de dados.")
    end
end

addEventHandler("onResourceStart", resourceRoot, function()
    if (dbMysql) then
        loadPeds()
        outputDebugString("[Leo Developer - Portfólio] O Resource "..getResourceName(resource).." Foi Iniciado Com Sucesso!")
    else
        outputDebugString("[Leo Developer - Portfólio] Erro Ao Conectar No Banco De Dados!")
    end
end)

--/ Commands Admin /--
local peds_drugs = {}

addCommandHandler(CONFIG.COMMAND_PED_CREATE, function(player, commandName, namePed, posX, posY, posZ)
    if (namePed and posX and posY and posZ) then
        local accName = getAccountName(getPlayerAccount(player))
        if (isObjectInACLGroup("user." .. accName, aclGetGroup(CONFIG.ACL_PERMISSION))) then
            local resultCheck = dbPoll(dbQuery(dbMysql, "SELECT COUNT(*) AS total FROM peds WHERE name_ped = ?", namePed), -1)
            if (resultCheck[1].total > 0) then
                notifyS(player, "Já existe um ped com esse nome.", "error")
                return
            end

            -- Inserir novo ped no banco de dados
            local insertQuery = dbQuery(dbMysql, "INSERT INTO peds (name_ped, posX, posY, posZ) VALUES (?, ?, ?, ?)", namePed, posX, posY, posZ)
            local _, num_affected_rows, _, last_insert_id = dbPoll(insertQuery, -1)

            if num_affected_rows and num_affected_rows > 0 then
                local ped = createPed(73, posX, posY, posZ, 0)
                setElementData(ped, "SAVE:PED_DRUGS:LEO", true)
                peds_drugs["ped_save"] = ped
                notifyS(player, "Ped Drugs Criado Com Sucesso!", "success")
            else
                notifyS(player, "Houve Algum Problema Ao Criar o Ped.", "error")
            end
        else
            notifyS(player, "Você Não Possui Permissão Para Executar Este Comando!", "error")
        end
    end
end)

--/ Painel Drugs /--
addEventHandler("onElementClicked", root, function(button, state, player)
    if (button == "left" and state == "down" and getElementType(source) == "ped") then
        local pedModel = getElementModel(source)
        
        -- Verificar se o ped pertence ao sistema de drogas (use o modelo específico que você está usando para os peds de drogas)
        if pedModel == 73 then
            triggerClientEvent(player, "leo >> openPainelDrugs", player)
        end
    end
end)
