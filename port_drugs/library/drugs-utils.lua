--[[

        ╔╗───────╔══╗────────╔╗
        ║║─╔═╗╔═╗╚╗╗║╔═╗╔═╦═╗╠╣
        ║╚╗║╩╣║╬║╔╩╝║║╩╣╚╗║╔╝║║
        ╚═╝╚═╝╚═╝╚══╝╚═╝─╚═╝─╚╝
        ───────────────────────
        Script Desenvolvido Por: leodevilopi - Discord

        Créditos Dos Códigos:

        dxDrawRoundedRectangle Em SVG: LodsDev
        isEventHandlerAdded: wikiMTA

--]]

local screen = Vector2 (guiGetScreenSize ()) -- Retorno da Resolução do Client.

--/ Utils /--
svgsRectangle = {};
function dxDrawRoundedRectangle(x, y, w, h, radius, color, post) -- Lods Dev
    if not svgsRectangle[radius] then
        svgsRectangle[radius] = {}
    end
    if not svgsRectangle[radius][w] then
        svgsRectangle[radius][w] = {}
    end
    if not svgsRectangle[radius][w][h] then
        local Path = string.format([[
        <svg width="%s" height="%s" viewBox="0 0 %s %s" fill="none" xmlns="http://www.w3.org/2000/svg">
        <rect opacity="1" width="%s" height="%s" rx="%s" fill="#FFFFFF"/>
        </svg>
        ]], w, h, w, h, w, h, radius)
        svgsRectangle[radius][w][h] = svgCreate(w, h, Path)
    end
    if svgsRectangle[radius][w][h] then
        dxDrawImage(x, y, w, h, svgsRectangle[radius][w][h], 0, 0, 0, color, post or false)
    end
end

function isEventHandlerAdded( sEventName, pElementAttachedTo, func ) -- WikiMTA
    if type( sEventName ) == 'string' and isElement( pElementAttachedTo ) and type( func ) == 'function' then
        local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
        if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
            for i, v in ipairs( aAttachedFunctions ) do
                if v == func then
                    return true
                end
            end
        end
    end
    return false
end

function isCursorOnElement (x, y, width, height) -- Verificação do cursor do Client. -- Código De ScrollBar Do ThigasDev.
    if not isCursorShowing () then
        return false
    end
    
    local cursor = {getCursorPosition ()}
    local cursorx, cursory = (cursor[1] * screen.x), (cursor[2] * screen.y)
    
    return cursorx >= x and cursorx <= (x + width) and cursory >= y and cursory <= (y + height)
end