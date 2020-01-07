PRIEST_DATA = {}
PRIEST_DATA.brotherhood = {}

if CLIENT then
	PRIEST_DATA.local_priest = {}

	hook.Add('Initialize', 'TTTInitPriestMessageLang', function()
		LANG.AddToLanguage('English', 'ttt2_priest_added', 'It seems like a player was added to the brotherhood.')
		LANG.AddToLanguage('English', 'ttt2_priest_brother_died', 'It seems like a brother died.')
		LANG.AddToLanguage('English', 'ttt2_priest_detective', 'The holy spirit was used to hurt a detective.')
		LANG.AddToLanguage('English', 'ttt2_priest_infected', 'The holy spirit was used to kill an infected.')
		LANG.AddToLanguage('English', 'ttt2_priest_necromancer', 'The holy spirit was used to kill a necromancer.')
		LANG.AddToLanguage('English', 'ttt2_priest_sidekick', 'The holy spirit was used to kill a sidekick.')
		LANG.AddToLanguage('English', 'ttt2_priest_died', 'The holy spirit killed a priest.')
		LANG.AddToLanguage('English', 'ttt2_priest_priest', 'You can\'t add a priest to the brotherhood.')
		LANG.AddToLanguage('English', 'ttt2_priest_marker', 'It seems like the priest shot a bucket full of color.')
		LANG.AddToLanguage('English', 'ttt2_priest_brother_jackal', 'Shooting the priest converted the whole brotherhood to sidekicks.')
		LANG.AddToLanguage('English', 'ttt2_priest_brother_necromancer', 'Reviving the priest as a zombie converted the whole brotherhood to zombies.')
		LANG.AddToLanguage('English', 'ttt2_priest_brother_infected', 'Killing the priest converted the whole brotherhood to infected.')
		LANG.AddToLanguage('English', 'ttt2_priest_player_brother', '(PLAYER IS IN BROTHERHOOD)')

		LANG.AddToLanguage('Deutsch', 'ttt2_priest_added', 'Es scheint so, als wäre ein weiterer Spieler der Bruderschaft beigetreten.')
		LANG.AddToLanguage('Deutsch', 'ttt2_priest_brother_died', 'Es scheint so, als wäre ein Bruder gestorben.')
		LANG.AddToLanguage('Deutsch', 'ttt2_priest_detective', 'Der heilige Geist wurde verwendet um einen Detektiv zu verletzen.')
		LANG.AddToLanguage('Deutsch', 'ttt2_priest_infected', 'Der heilige Geist wurde verwendet um einen Infizierten zu töten.')
		LANG.AddToLanguage('Deutsch', 'ttt2_priest_necromancer', 'Der heilige Geist wurde verwendet um einen Geisterbeschwörer zu töten.')
		LANG.AddToLanguage('Deutsch', 'ttt2_priest_sidekick', 'Der heilige Geist wurde verwendet um einen Sidekick zu töten.')
		LANG.AddToLanguage('Deutsch', 'ttt2_priest_died', 'Der heilige Geist hat einen Priester getötet.')
		LANG.AddToLanguage('Deutsch', 'ttt2_priest_priest', 'Du kannst keinen Priester der Bruderschaft hinzufügen.')
		LANG.AddToLanguage('Deutsch', 'ttt2_priest_marker', 'Es scheint so, als habe der Priester einen Farbeimer angeschossen.')
		LANG.AddToLanguage('Deutsch', 'ttt2_priest_brother_jackal', 'Durch das Anschießen des Priesters wurde die ganze Bruderschaft zu Sidekicks.')
		LANG.AddToLanguage('Deutsch', 'ttt2_priest_brother_necromancer', 'Durch das Wiederbeleben des Priesters wurde die ganze Bruderschaft zu Zombies.')
		LANG.AddToLanguage('Deutsch', 'ttt2_priest_brother_infected', 'Durch das Töten des Priesters wurde die ganze Bruderschaft zu Infizierten.')
		LANG.AddToLanguage('Deutsch', 'ttt2_priest_player_brother', '(SPIELER IST IN BRUDERSCHAFT)')
	end)

	net.Receive('ttt2_role_priest_msg', function()
		local string_identifier = net.ReadString()
		if GetConVar('ttt_pri_show_messages'):GetBool() and PRIEST_DATA:IsBrother(LocalPlayer()) then
			MSTACK:AddMessage(LANG.GetTranslation(string_identifier))
		end
	end)

	net.Receive('ttt2_role_priest_new_brother', function()
		local new_brother = net.ReadEntity()
		if not new_brother or not new_brother:IsPlayer() then return end

		local new_brother_id = tostring(new_brother:SteamID64() or new_brother:EntIndex())
		PRIEST_DATA.brotherhood[new_brother_id] = true

		PRIEST_DATA:UpdateScoreboard()
	end)

	net.Receive('ttt2_role_priest_remove_brother', function()
		local rem_brother = net.ReadEntity()
		if not rem_brother or not rem_brother:IsPlayer() then return end

		local rem_brother_id = tostring(rem_brother:SteamID64() or rem_brother:EntIndex())
		PRIEST_DATA.brotherhood[rem_brother_id] = nil

		PRIEST_DATA:UpdateScoreboard()
	end)

	net.Receive('ttt2_role_priest_clear_brotherhood', function()
		PRIEST_DATA.brotherhood = {}

		PRIEST_DATA:UpdateScoreboard()
	end)

	net.Receive('ttt2_role_priest_recharge_icon', function()
		local time = net.ReadUInt(8)
		PRIEST_DATA.local_priest.time = CurTime() + time

		STATUS:AddTimedStatus('ttt2_role_priest_holy_deagle', time)
	end)

	net.Receive('ttt2_role_priest_corpse_update', function()
		local ply = net.ReadEntity()

		if not ply or not ply:IsPlayer() then return end

		ply.was_brother = net.ReadBool()
	end)

	hook.Add('TTTScoreboardColumns', 'ttt2_priest_brotherhood_column', function(pnl)
		local client = LocalPlayer()

		-- this prevention is needed when a player connects in the moment that a round starts
		if not client or not IsValid(client) or not client:IsPlayer() then return end

		if not PRIEST_DATA:IsBrother(client) then return end
		pnl:AddColumn('Brother', function(ply, label)
			if PRIEST_DATA:IsBrother(ply) then
				return 'yes'
			else
				return '-'
			end
		end, 70)
	end)

	-- the brother column should only be visible when you're in the brotherhood
	function PRIEST_DATA:UpdateScoreboard()
		GAMEMODE:ScoreboardCreate()
		GAMEMODE:ScoreboardHide()
	end
end

if SERVER then
	util.AddNetworkString('ttt2_role_priest_new_brother')
	util.AddNetworkString('ttt2_role_priest_remove_brother')
	util.AddNetworkString('ttt2_role_priest_clear_brotherhood')
	util.AddNetworkString('ttt2_role_priest_msg')
	util.AddNetworkString('ttt2_role_priest_recharge_icon')
	util.AddNetworkString('ttt2_role_priest_corpse_update')

	local function InstantDamage(ply, damage, attacker, inflictor)
		local dmg = DamageInfo()

		dmg:SetDamage(damage or 2000)
		dmg:SetAttacker(attacker or ply)
		dmg:SetDamageForce(ply:GetAimVector())
		dmg:SetDamagePosition(ply:GetPos())
		dmg:SetDamageType(DMG_SLASH)

		if inflictor then
			dmg:SetInflictor(inflictor)
		end

		ply:TakeDamageInfo(dmg)
	end

	function PRIEST_DATA:ShootBrotherhood(ply, attacker)
		-- player already in brotherhood but no priest
		if self:IsBrother(ply) and ply:GetSubRole() ~= ROLE_PRIEST then return end

		if ply:GetTeam() == TEAM_INNOCENT then
			-- A DETECTIVE/SNIFFER CAN NOT BE CONVERTED AND HE GETS 30 DAMAGE
			if ply:GetSubRole() == ROLE_DETECTIVE or ply:GetSubRole() == ROLE_SNIFFER then
				InstantDamage(ply, GetConVar('ttt_pri_damage_dete'):GetInt(), attacker, ents.Create('weapon_ttt2_holydeagle'))

				self:SendMessage('ttt2_priest_detective')

			-- PRIESTS CAN'T BE ADDED TO THE BROTHERHOOD SINCE THEY ARE ALREADY A PART OF IT
			elseif ply:GetSubRole() == ROLE_PRIEST then
				self:SendMessage('ttt2_priest_priest')

			-- INNOCENT PLAYERS ARE THE ONLY ONES TO BE CONVERTED BY THE HOLY DEAGLE
			else
				self:AddToBrotherhood(ply)

				self:SendMessage('ttt2_priest_added')
			end

		-- UNKNOWN PLAYERS ARE CONVERTED AS WELL
		elseif ply:GetSubRole() == ROLE_UNKNOWN then
			self:AddToBrotherhood(ply)

			self:SendMessage('ttt2_priest_added')

		-- INFECTED PLAYERS GET KILLED BY THE HOLY DEAGLE
		elseif ply:GetTeam() == TEAM_INFECTED then
			InstantDamage(ply, 2000, attacker, ents.Create('weapon_ttt2_holydeagle'))

			self:SendMessage('ttt2_priest_infected')

		-- NECROMANCERS GET KILLED BY THE HOLY DEAGLE
		elseif ply:GetSubRole() == ROLE_NECROMANCER then
			InstantDamage(ply, 2000, attacker, ents.Create('weapon_ttt2_holydeagle'))

			self:SendMessage('ttt2_priest_necromancer')

		-- SIDEKICKS ARE KILLED BY THE HOLY DEAGLE
		elseif ply:GetSubRole() == ROLE_SIDEKICK then
			InstantDamage(ply, 2000, attacker, ents.Create('weapon_ttt2_holydeagle'))

			self:SendMessage('ttt2_priest_sidekick')

		-- SHOOTING A MARKER ADDS THE COMPLETE BROTHERHOOD TO MARKED PLAYERS
		elseif ply:GetSubRole() == ROLE_MARKER then
			InstantDamage(ply, GetConVar('ttt_pri_damage_marker'):GetInt(), attacker, ents.Create('weapon_ttt2_holydeagle'))

			for _,p in ipairs(player.GetAll()) do
				if MARKER_DATA and p:IsPlayer() and p:Alive() and p:IsTerror() and self:IsBrother(p) then
					MARKER_DATA:SetMarkedPlayer(p)
				end
			end

			self:SendMessage('ttt2_priest_marker')

		-- ALL OTHER EVIL ROLES KILL THE PRIEST
		else
			InstantDamage(attacker, 2000, ply, ents.Create('weapon_ttt2_holydeagle'))

			self:SendMessage('ttt2_priest_died')
		end
	end

	function PRIEST_DATA:PrepareCorpseOnDeath(ply)
		if not ply or not ply:IsPlayer() then return end
		if not self:IsBrother(ply) then return end

		net.Start('ttt2_role_priest_corpse_update')
		net.WriteEntity(ply)
		net.WriteBool(true)
		net.Broadcast()
	end

	function PRIEST_DATA:ResetCorpseOnSpawn(ply)
		if not ply or not ply:IsPlayer() then return end

		net.Start('ttt2_role_priest_corpse_update')
		net.WriteEntity(ply)
		net.WriteBool(false)
		net.Broadcast()
	end

	function PRIEST_DATA:BrotherDies(ply)
		-- unknown players keep their status
		if ply:GetSubRole() == ROLE_UNKNOWN then return end

		-- only remove if player is in brotherhood
		if not PRIEST_DATA:IsBrother(ply) then return end

		self:PrepareCorpseOnDeath(ply)
		self:RemoveFromBrotherhood(ply)
	end

	function PRIEST_DATA:AddToBrotherhood(ply)
		-- add status icon with a timer since all effects are removed on player spawn
		timer.Create('ttt2_priest_give_brotherhood', 0.05, 1, function() STATUS:AddStatus(ply, 'ttt2_role_priest_brotherhood') end)

		self.brotherhood[tostring(ply:SteamID64() or ply:EntIndex())] = true

		net.Start('ttt2_role_priest_new_brother')
		net.WriteEntity(ply)
		net.Send(player.GetAll()) -- send to all players
	end

	function PRIEST_DATA:RemoveFromBrotherhood(ply)
		STATUS:RemoveStatus(ply, 'ttt2_role_priest_brotherhood')

		self.brotherhood[tostring(ply:SteamID64() or ply:EntIndex())] = nil

		net.Start('ttt2_role_priest_remove_brother')
		net.WriteEntity(ply)
		net.Send(player.GetAll()) -- send to all players

		self:SendMessage('ttt2_priest_brother_died')
	end

	function PRIEST_DATA:ClearBrotherhood()
		STATUS:RemoveStatus(player.GetAll(), 'ttt2_role_priest_brotherhood')

		self.brotherhood = {}

		net.Start('ttt2_role_priest_clear_brotherhood')
		net.Send(player.GetAll())
	end

	function PRIEST_DATA:SetRechargeIcon(ply, time)
		net.Start('ttt2_role_priest_recharge_icon')
		net.WriteUInt(time, 8)
		net.Send(ply)
	end

	function PRIEST_DATA:ChangeBrotherHoodRole(new_role, new_team)
		for _, p in ipairs(player.GetAll()) do
			if p and IsValid(p) and p:IsPlayer() and p:Alive() and p:IsTerror() and self:IsBrother(p) then
				p:SetRole(new_role, new_team)
			end
		end
		self:ClearBrotherhood()
	end

	function PRIEST_DATA:ChangeBrotherHoodRoleToInfected(infplayers)
		for _, p in ipairs(player.GetAll()) do
			if p:IsPlayer() and p:Alive() and p:IsTerror() and self:IsBrother(p) then
				table.insert(infplayers, p)
			end
		end
		self:ClearBrotherhood()
	end

	function PRIEST_DATA:ChangeBrotherHoodRoleToSidekick(siki_host)
		for _, p in ipairs(player.GetAll()) do
			-- do not convert jackals to sidekicks!
			if p and IsValid(p) and p:IsPlayer() and p:Alive() and p:IsTerror() and self:IsBrother(p) and p:GetSubRole() ~= ROLE_JACKAL then
				AddSidekick(p, siki_host)
				timer.Simple(0.1, function()
					SendFullStateUpdate()
				end)
			end
		end
		self:ClearBrotherhood()
	end

	hook.Add('PlayerSpawn', 'ttt2_priest_unknown', function(ply)
		-- special case for unknown
		if ply:GetSubRole() == ROLE_UNKNOWN and PRIEST_DATA:IsBrother(ply) then
			timer.Create('ttt2_priest_unknown_give_brotherhood', 0.05, 1, function() STATUS:AddStatus(ply, 'ttt2_role_priest_brotherhood') end)
		end

		PRIEST_DATA:ResetCorpseOnSpawn(ply)
	end)

	-- death of player in brotherhood
	hook.Add('PlayerDeath', 'ttt2_priest_player_death', function(ply)
		PRIEST_DATA:BrotherDies(ply)
	end)

	function PRIEST_DATA:SendMessage(identifier)
		net.Start('ttt2_role_priest_msg')
		net.WriteString(identifier)
		net.Send(player.GetAll())
	end

	-- a hook that resets the brothers and the scoreboard
	hook.Add('TTTEndRound', 'ttt2_priest_update_scorboard_end', function()
		PRIEST_DATA:ClearBrotherhood()
	end)

	-- handle special role changes in the combination with the broterhood
	hook.Add('TTT2UpdateBaserole', 'ttt2_priest_change_roles', function(ply, old, new)
		if old ~= ROLE_PRIEST then return end

		-- for some rolechanges, the whole brotherhood gets changed too
		if new == ROLE_SIDEKICK then -- jackal
			PRIEST_DATA:SendMessage('ttt2_priest_brother_jackal')
			PRIEST_DATA:ChangeBrotherHoodRoleToSidekick(ply:GetNWEntity('binded_sidekick', nil))
		end
		if new == ROLE_ZOMBIE then -- necormancer
			PRIEST_DATA:SendMessage('ttt2_priest_brother_necromancer')
			PRIEST_DATA:ChangeBrotherHoodRole(ROLE_ZOMBIE, TEAM_NECROMANCER)
		end
	end)
	-- the infected has to be handled differently
	hook.Add('TTT2InfectedAddGroup', 'ttt2_priest_add_brothers_to_infected', function(brothers)
		PRIEST_DATA:SendMessage('ttt2_priest_brother_infected')
		PRIEST_DATA:ChangeBrotherHoodRoleToInfected(brothers)
	end)
end

function PRIEST_DATA:IsBrother(ply)
	if not IsValid(ply) or not ply:IsPlayer() then return false end
	if not isfunction(ply.SteamID64) and not isfunction(ply.EntIndex) then return false end

	return self.brotherhood[tostring(ply:SteamID64() or ply:EntIndex())] or false
end
