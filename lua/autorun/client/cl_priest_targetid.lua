local material_in_brotherhood = Material('vgui/ttt/dynamic/roles/is_in_brotherhood')

-- handle looking at sodas
hook.Add('TTTRenderEntityInfo', 'ttt2_priest_highlight_players', function(data, params)
	-- while client is setting up, ignore missing PRIEST
	if not PRIEST then return end

	-- has to be a player
	if not data.ent:IsPlayer() then return end

	-- only add text to brotherhood players
	if not PRIEST_DATA:IsBrother(data.ent) then return end

	params.displayInfo.desc[#params.displayInfo.desc + 1] = {
		text = LANG.GetTranslation('ttt2_priest_player_brother'),
		color = PRIEST.dkcolor
	}

	params.displayInfo.icon[#params.displayInfo.icon + 1] = {
		material = material_in_brotherhood,
		color = PRIEST.dkcolor
	}
end)