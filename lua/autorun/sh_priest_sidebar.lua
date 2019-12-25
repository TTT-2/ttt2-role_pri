if SERVER then
	resource.AddFile('materials/vgui/ttt/hud_icon_brotherhood.png')
	resource.AddFile('materials/vgui/ttt/hud_icon_holy_deagle.png')

	resource.AddFile('materials/vgui/ttt/player_brother.png')
end

if CLIENT then
	hook.Add('Initialize', 'ttt2_role_priest_init', function()
		STATUS:RegisterStatus('ttt2_role_priest_brotherhood', {
			hud = Material('vgui/ttt/hud_icon_brotherhood.png'),
			type = 'good'
		})
		STATUS:RegisterStatus('ttt2_role_priest_holy_deagle', {
			hud = Material('vgui/ttt/hud_icon_holy_deagle.png'),
			type = 'bad',
			DrawInfo = function(self)
				if not PRIEST_DATA.local_priest.time then return '-' end
				return tostring(math.Round(math.max(PRIEST_DATA.local_priest.time - CurTime(), 0),0))
			end
		})
	end)
end