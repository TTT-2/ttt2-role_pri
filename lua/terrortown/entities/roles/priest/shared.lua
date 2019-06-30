if SERVER then
	AddCSLuaFile()

	resource.AddFile('materials/vgui/ttt/dynamic/roles/icon_pri.vmt')
end

ROLE.Base = 'ttt_role_base'

ROLE.color = Color(185, 210, 95, 255)
ROLE.dkcolor = Color(150, 175, 65, 255)
ROLE.bgcolor = Color(215, 240, 130, 255)
ROLE.abbr = 'pri'
ROLE.surviveBonus = 0 -- bonus multiplier for every survive while another player was killed
ROLE.scoreKillsMultiplier = 1 -- multiplier for kill of player of another team
ROLE.scoreTeamKillsMultiplier = -16 -- multiplier for teamkill
ROLE.preventFindCredits = true
ROLE.preventKillCredits = true
ROLE.preventTraitorAloneCredits = true
ROLE.preventWin = false

roles.InitCustomTeam(ROLE.name, {
    icon = 'vgui/ttt/dynamic/roles/icon_pri',
    color = ROLE.color
})
ROLE.defaultTeam = TEAM_INNOCENT

ROLE.conVarData = {
	pct = 0.15, -- necessary: percentage of getting this role selected (per player)
	maximum = 1, -- maximum amount of roles in a round
	minPlayers = 7, -- minimum amount of players until this role is able to get selected
	credits = 0, -- the starting credits of a specific role
	shopFallback = SHOP_DISABLED,
	togglable = true, -- option to toggle a role for a client if possible (F1 menu)
	random = 33
}

hook.Add('TTT2FinishedLoading', 'PriestInitT', function()

	if CLIENT then
		LANG.AddToLanguage('English', PRIEST.name, 'Priest')
		LANG.AddToLanguage('English', 'info_popup_' .. PRIEST.name,
			[[You are the Priest!
			Use your holy deagle to convert players into your brotherhood. But be careful, only innocent players behave well.]])
		LANG.AddToLanguage('English', 'body_found_' .. PRIEST.abbr, 'They were a Priest.')
        LANG.AddToLanguage('English', 'search_role_' .. PRIEST.abbr, 'This person was a Priest!')
		LANG.AddToLanguage('English', 'target_' .. PRIEST.name, 'Priest')
		LANG.AddToLanguage('English', 'ttt2_desc_' .. PRIEST.name, [[The Priest needs to win with the innocents!]])
		LANG.AddToLanguage('English', 'credit_' .. PRIEST.abbr .. '_all', 'Priests, you have been awarded {num} equipment credit(s) for your performance.')

		---------------------------------

		-- maybe this language as well...
		LANG.AddToLanguage('Deutsch', PRIEST.name, 'Priester')
		LANG.AddToLanguage('Deutsch', 'info_popup_' .. PRIEST.name,
			[[Du bist ein Priester!
			Benutze deine Heilige Deagle um andere Spieler in deine Bruderschaft aufzunehmen. Aber sei vorsichtig, nur Unschuldige verhalten sich gut.]])
		LANG.AddToLanguage('Deutsch', 'body_found_' .. PRIEST.abbr, 'Er war ein Priester!')
		LANG.AddToLanguage('Deutsch', 'search_role_' .. PRIEST.abbr, 'Diese Person war ein Priester!')
		LANG.AddToLanguage('Deutsch', 'target_' .. PRIEST.name, 'Priester')
		LANG.AddToLanguage('Deutsch', 'ttt2_desc_' .. PRIEST.name, [[Der Priester gewinnt zusammen mit den Unschuldigen!]])
		LANG.AddToLanguage('Deutsch', 'credit_' .. PRIEST.abbr .. '_all', 'Priester, dir wurde(n) {num} Ausrüstungs-Credit(s) für deine Leistung gegeben.')
	end
end) 

if SERVER then
	local function InitRolePriest(ply)
		ply:GiveEquipmentWeapon('weapon_ttt2_holydeagle')
		PRIEST_DATA:AddToBrotherhood(ply)
    end
 
    hook.Add('TTT2UpdateSubrole', 'TTT2PriestGiveHolyDeagle_UpdateSubtole', function(ply, old, new) -- called on normal role set
        if new == ROLE_PRIEST then
            InitRolePriest(ply)
        elseif old == ROLE_PRIEST then
            ply:StripWeapon('weapon_ttt2_holydeagle')
        end
    end)
   
    hook.Add('PlayerSpawn', 'TTT2PriestGiveHolyDeagle_PlayerSpawn', function(ply) -- called on player respawn
        if ply:GetSubRole() ~= ROLE_PRIEST then return end
        InitRolePriest(ply)
    end)
end