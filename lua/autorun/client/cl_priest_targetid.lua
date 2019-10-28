local material_in_brotherhood = Material('vgui/ttt/dynamic/roles/is_in_brotherhood')
local color_player_in_brotherhood = Color(PRIEST.bgcolor.r, PRIEST.bgcolor.g, PRIEST.bgcolor.b, 75)

-- handle looking at sodas
hook.Add('TTTRenderEntityInfo', 'ttt2_priest_highlight_players', function(data, params)
    local client = LocalPlayer()
    local obsTgt = client:GetObserverTarget()

    -- has to be a player
    if not data.ent:IsPlayer() then return end

    -- only add text to brotherhood players
    if not PRIEST_DATA:IsBrother(data.ent) then return end

    params.displayInfo.desc[#params.displayInfo.desc + 1] = {
        text = LANG.GetTranslation('ttt2_priest_player_brother'),
        color = PRIEST.bgcolor
    }

    params.displayInfo.icon[#params.displayInfo.icon + 1] = {
        material = material_in_brotherhood,
        color = color_player_in_brotherhood
    }
end)