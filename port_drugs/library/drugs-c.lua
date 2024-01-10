--/ RESOLUTION /--
local w, h = guiGetScreenSize()
local x, y = (w/1920), (h/1080)

--/ FONT'S /--
local fonts = {
    bold = dxCreateFont("assets/fonts/Inter-Bold.ttf", 15)
}

--/ CURSOR SYSTEM /--
bindKey("m", "down", function()
    if (isCursorShowing(localPlayer)) then
        showCursor(false)
    else
        showCursor(true)
    end
end)

--/ INTERFACE /--
function renderDrugs()
    dxDrawRoundedRectangle(x*578, y*424, x*763, y*246, 5, tocolor(255, 255, 255, 255)) -- Background
    dxDrawText("Deseja Vender Drogas Para Esse Ped?", x*664, y*482, x*592, y*39, tocolor(0, 0, 0), 1.0, fonts.bold, "left", "top")

    dxDrawRoundedRectangle(x*827, y*562, x*265, y*74, 5, tocolor(CONFIG.PANEL.COLOR_BUTTON[1], CONFIG.PANEL.COLOR_BUTTON[2], CONFIG.PANEL.COLOR_BUTTON[3])) -- Button Comprar
    dxDrawText("Confirmar", x*900, y*584, x*119, y*29, tocolor(255, 255, 255, 255), 0.8, fonts.bold, "left", "top")

    --/ Hover Button /--
    if (isCursorOnElement(x*827, y*562, x*265, y*74)) then
        dxDrawRoundedRectangle(x*827, y*562, x*265, y*74, 5, tocolor(CONFIG.PANEL.COLOR_HOVER_BUTTON[1], CONFIG.PANEL.COLOR_HOVER_BUTTON[2], CONFIG.PANEL.COLOR_HOVER_BUTTON[3])) -- Button Comprar
        dxDrawText("Confirmar", x*900, y*584, x*119, y*29, tocolor(255, 255, 255, 255), 0.8, fonts.bold, "left", "top")
    end
end

--/ OPEN PANEL /--
createEvent("leo >> openPainelDrugs", root, function()
    if (not isEventHandlerAdded("onClientRender", root, renderDrugs)) then
        addEventHandler("onClientRender", root, renderDrugs)
        showCursor(true)
    end
end)

--/ CLOSE PANEL /--
bindKey(CONFIG.CLOSE_PANEL, "down", function()
    if (isEventHandlerAdded("onClientRender", root, renderDrugs)) then
        removeEventHandler("onClientRender", root, renderDrugs)
        showCursor(false)
    end
end)