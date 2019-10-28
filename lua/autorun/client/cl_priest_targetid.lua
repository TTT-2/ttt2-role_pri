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
end)