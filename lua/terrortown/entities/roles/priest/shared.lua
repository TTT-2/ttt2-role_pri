if SERVER then
	AddCSLuaFile()

	resource.AddFile("materials/vgui/ttt/dynamic/roles/icon_pri")
	resource.AddFile("materials/vgui/ttt/dynamic/roles/is_in_brotherhood")
end

ROLE.Base = "ttt_role_base"

function ROLE:PreInitialize()
	self.color = Color(185, 210, 95, 255)

	self.abbr = "pri"
	self.score.killsMultiplier = 2
	self.score.teamKillsMultiplier = -8
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
end

if CLIENT then
	hook.Add("TTTBodySearchPopulate", "ttt2_role_priest_add_brotherhood_indicator", function(search, raw)
		if not raw.owner then return end
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
		ply:GiveEquipmentWeapon("weapon_ttt2_holydeagle")
		ply:GiveArmor(10)
		PRIEST_DATA:AddToBrotherhood(ply)
	end

	-- Remove Loadout on death and rolechange
	function ROLE:RemoveRoleLoadout(ply, isRoleChange)
		ply:StripWeapon("weapon_ttt2_holydeagle")
		ply:RemoveArmor(10)
	end
end
