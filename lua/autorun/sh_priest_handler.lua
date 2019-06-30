PRIEST_DATA = {}
PRIEST_DATA.brotherhood = {}

if CLIENT then
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

    hook.Add('TTTScoreboardColumns', 'ttt2_priest_brotherhood_column', function(pnl)
        if not PRIEST_DATA:IsBrother(LocalPlayer()) then return end
        pnl:AddColumn('Brother', function(ply, label)         
            if PRIEST_DATA:IsBrother(ply) then
                return 'yes'
            else
                return '-'
            end
		end, 70)
    end)

    -- a few hooks that reset the brother scoreboard
    hook.Add('TTTPrepareRound', 'ttt2_priest_update_scorboard_prepare', function()
        PRIEST_DATA:UpdateScoreboard()
    end)
    hook.Add('TTTBeginRound', 'ttt2_priest_update_scorboard_begin', function()
        PRIEST_DATA:UpdateScoreboard()
    end)
    hook.Add('TTTEndRound', 'ttt2_priest_update_scorboard_end', function()
        PRIEST_DATA:UpdateScoreboard()
    end)

    -- the brother column should only be visible when you're in the brotherhood
    function PRIEST_DATA:UpdateScoreboard()
        if not self:IsBrother(LocalPlayer()) then return end

        GAMEMODE:ScoreboardCreate()
        GAMEMODE:ScoreboardHide()
    end
end

if SERVER then
    util.AddNetworkString('ttt2_role_priest_new_brother')
    util.AddNetworkString('ttt2_role_priest_remove_brother')

    function PRIEST_DATA:ShootBrotherhood(ply, attacker)
        if ply:GetTeam() == TEAM_INNOCENT then
            -- A DETECTIVE CAN NOT BE CONVERTED AND HE GETS 30 DAMAGE
            if ply:GetSubRole() == ROLE_DETECTIVE then
                local inflictor = ents.Create('weapon_ttt2_holydeagle')
                ply:TakeDamage(GetConVar('ttt_pri_damage_dete'):GetInt(), attacker, inflictor)

            -- INNOCENT PLAYERS ARE THE ONLY ONES TO BE CONVERTED BY THE HOLY DEAGLE
            else
                self:AddToBrotherhood(ply)
            end

        -- UNKNOWN PLAYERS ARE CONVERTED AS WELL
        elseif ply:GetSubRole() == ROLE_UNKNOWN then
            self:AddToBrotherhood(ply)
        elseif ply:GetTeam() == TEAM_INFECTED then
            local inflictor = ents.Create('weapon_ttt2_holydeagle')
            ply:TakeDamage(10000, attacker, inflictor)
        else
            local inflictor = ents.Create('weapon_ttt2_holydeagle')
            attacker:TakeDamage(10000, attacker, inflictor)
        end
    end

    function PRIEST_DATA:BrotherDies(ply)
        -- unknown players keep their status
        if ply:GetSubRole() == ROLE_UNKNOWN then return end

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
    end
end

function PRIEST_DATA:IsBrother(ply)
    return self.brotherhood[tostring(ply:SteamID64() or ply:EntIndex())] or false
end