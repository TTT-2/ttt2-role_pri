local material_in_brotherhood = Material('vgui/ttt/dynamic/roles/is_in_brotherhood')

-- handle looking at sodas
hook.Add('TTTRenderEntityInfo', 'ttt2_priest_highlight_players', function(tData)
	-- while client is setting up, ignore missing PRIEST
	if not PRIEST then return end

	local ent = tData:GetEntity()

	-- has to be a player
	if not ent:IsPlayer() then return end

	-- only add text to brotherhood players
	if not PRIEST_DATA:IsBrother(ent) or not PRIEST_DATA:IsBrother(LocalPlayer()) then return end

	tData:AddDescriptionLine(
		LANG.GetTranslation('ttt2_priest_player_brother'),
		PRIEST.dkcolor
	)

	tData:AddIcon(
		material_in_brotherhood,
		PRIEST.dkcolor
	)
end)
