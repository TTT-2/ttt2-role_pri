if SERVER then
	AddCSLuaFile()

	resource.AddFile('materials/vgui/ttt/dynamic/roles/icon_pri.vmt')
end

ROLE.Base = 'ttt_role_base'

roles.InitCustomTeam(ROLE.name, {
    icon = 'vgui/ttt/dynamic/roles/icon_pri',
    color = Color(185, 210, 95, 255)
})

function ROLE:PreInitialize()
	self.color = Color(185, 210, 95, 255)
	self.dkcolor = Color(150, 175, 65, 255)
	self.bgcolor = Color(215, 240, 130, 255)

	self.abbr = 'pri'
	self.surviveBonus = 0
	self.scoreKillsMultiplier = 1
	self.scoreTeamKillsMultiplier = -16
	self.preventFindCredits = true
	self.preventKillCredits = true
	self.preventTraitorAloneCredits = true
	self.preventWin = false
	self.unknownTeam = true

	self.defaultTeam = TEAM_INNOCENT

	self.conVarData = {
		pct = 0.15, -- necessary: percentage of getting this role selected (per player)
		maximum = 1, -- maximum amount of roles in a round
		minPlayers = 7, -- minimum amount of players until this role is able to get selected
		credits = 0, -- the starting credits of a specific role
		shopFallback = SHOP_DISABLED,
		togglable = true, -- option to toggle a role for a client if possible (F1 menu)
		random = 33
	}
end

function ROLE:Initialize()
	roles.SetBaseRole(self, ROLE_INNOCENT)

	if CLIENT then
		-- Role specific language elements
		LANG.AddToLanguage('English', PRIEST.name, 'Priest')
		LANG.AddToLanguage('English', 'info_popup_' .. PRIEST.name,
			[[You are the Priest!
			Use your holy deagle to convert players into your brotherhood. But be careful, only innocent players behave well.]])
		LANG.AddToLanguage('English', 'body_found_' .. PRIEST.abbr, 'They were a Priest.')
        LANG.AddToLanguage('English', 'search_role_' .. PRIEST.abbr, 'This person was a Priest!')
		LANG.AddToLanguage('English', 'target_' .. PRIEST.name, 'Priest')
		LANG.AddToLanguage('English', 'ttt2_desc_' .. PRIEST.name, [[The Priest needs to win with the innocents!]])
		LANG.AddToLanguage('English', 'credit_' .. PRIEST.abbr .. '_all', 'Priests, you have been awarded {num} equipment credit(s) for your performance.')

		LANG.AddToLanguage('Deutsch', PRIEST.name, 'Priester')
		LANG.AddToLanguage('Deutsch', 'info_popup_' .. PRIEST.name,
			[[Du bist ein Priester!
			Benutze deine Heilige Deagle um andere Spieler in deine Bruderschaft aufzunehmen. Aber sei vorsichtig, nur Unschuldige verhalten sich gut.]])
		LANG.AddToLanguage('Deutsch', 'body_found_' .. PRIEST.abbr, 'Er war ein Priester!')
		LANG.AddToLanguage('Deutsch', 'search_role_' .. PRIEST.abbr, 'Diese Person war ein Priester!')
		LANG.AddToLanguage('Deutsch', 'target_' .. PRIEST.name, 'Priester')
		LANG.AddToLanguage('Deutsch', 'ttt2_desc_' .. PRIEST.name, [[Der Priester gewinnt zusammen mit den Unschuldigen!]])
		LANG.AddToLanguage('Deutsch', 'credit_' .. PRIEST.abbr .. '_all', 'Priester, dir wurde(n) {num} Ausrüstungs-Credit(s) für deine Leistung gegeben.')

		-- other role language elements
		LANG.AddToLanguage("English", "ttt2_priest_was_priest", "This player appears to be a member of the brotherhood.")
		LANG.AddToLanguage("Deutsch", "ttt2_priest_was_priest", "Dieser Spieler scheint ein Mitglied der Bruderschaft zu sein.")
	end
end

if CLIENT then
	hook.Add("TTTBodySearchPopulate", "ttt2_role_priest_add_brotherhood_indicator", function(search, raw)
		if not raw.owner.was_brother then return end

		local highest_id = 0
		for _, v in pairs(search) do
			highest_id = math.max(highest_id, v.p)
		end

		search.is_brother = {img = "vgui/ttt/player_brother.png", text = LANG.GetTranslation("ttt2_priest_was_priest"), p = highest_id + 1}
	end)
end

if SERVER then 
	-- Give Loadout on respawn and rolechange	
	function ROLE:GiveRoleLoadout(ply, isRoleChange)
		ply:GiveEquipmentWeapon('weapon_ttt2_holydeagle')
		ply:GiveArmor(10)
		PRIEST_DATA:AddToBrotherhood(ply)
	end

	-- Remove Loadout on death and rolechange
	function ROLE:RemoveRoleLoadout(ply, isRoleChange)
		ply:StripWeapon('weapon_ttt2_holydeagle')
		ply:RemoveArmor(10)
	end
end