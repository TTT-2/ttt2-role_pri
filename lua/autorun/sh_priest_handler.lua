PRIEST_DATA = {}
PRIEST_DATA.brotherhood = {}

if CLIENT then
    hook.Add('Initialize', 'TTTInitPriestMessageLang', function()
        LANG.AddToLanguage('English', 'ttt2_priest_added', 'It seems like a player was added to the brotherhood.')
        LANG.AddToLanguage('English', 'ttt2_priest_brother_died', 'It seems like a brother died.')
        LANG.AddToLanguage('English', 'ttt2_priest_detective', 'The holy spirit was used to hurt a detective.')
        LANG.AddToLanguage('English', 'ttt2_priest_infected', 'The holy spirit was used to kill an infected.')
        LANG.AddToLanguage('English', 'ttt2_priest_died', 'The holy spirit killed a priest.')
        
        LANG.AddToLanguage('Deutsch', 'ttt2_priest_added', 'Es scheint so, als wäre ein weiterer Spieler der Bruderschaft beigetreten.')
        LANG.AddToLanguage('Deutsch', 'ttt2_priest_brother_died', 'Es scheint so, als wäre ein Bruder gestorben.')
        LANG.AddToLanguage('Deutsch', 'ttt2_priest_detective', 'Der heilige Geist wurde verwendet um einen Detektiv zu verletzen.')
        LANG.AddToLanguage('Deutsch', 'ttt2_priest_infected', 'Der heilige Geist wurde verwendet um einen Infizierten zu töten.')
        LANG.AddToLanguage('Deutsch', 'ttt2_priest_died', 'Der heilige Geist hat einen Priester getötet.')
    end)

    net.Receive('ttt2_role_priest_msg', function()
        local string_identifier = net.ReadString()
        if GetConVar('ttt_priest_show_messages'):GetBool() and PRIEST_DATA:IsBrother(LocalPlayer()) then 
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
        GAMEMODE:ScoreboardCreate()
        GAMEMODE:ScoreboardHide()
    end
end

if SERVER then
    util.AddNetworkString('ttt2_role_priest_new_brother')
    util.AddNetworkString('ttt2_role_priest_remove_brother')
    util.AddNetworkString('ttt2_role_priest_msg')

    function PRIEST_DATA:ShootBrotherhood(ply, attacker)
        if ply:GetTeam() == TEAM_INNOCENT then
            -- A DETECTIVE CAN NOT BE CONVERTED AND HE GETS 30 DAMAGE
            if ply:GetSubRole() == ROLE_DETECTIVE then
                local inflictor = ents.Create('weapon_ttt2_holydeagle')
                ply:TakeDamage(GetConVar('ttt_pri_damage_dete'):GetInt(), attacker, inflictor)

                self:SendMessage('ttt2_priest_detective')

            -- INNOCENT PLAYERS ARE THE ONLY ONES TO BE CONVERTED BY THE HOLY DEAGLE
            else
                self:AddToBrotherhood(ply)

                self:SendMessage('ttt2_priest_added')
            end

        -- UNKNOWN PLAYERS ARE CONVERTED AS WELL
        elseif ply:GetSubRole() == ROLE_UNKNOWN then
            self:AddToBrotherhood(ply)

            self:SendMessage('ttt2_priest_added')
        elseif ply:GetTeam() == TEAM_INFECTED then
            local inflictor = ents.Create('weapon_ttt2_holydeagle')
            ply:TakeDamage(10000, attacker, inflictor)

            self:SendMessage('ttt2_priest_infected')
        else
            local inflictor = ents.Create('weapon_ttt2_holydeagle')
            attacker:TakeDamage(10000, attacker, inflictor)

            self:SendMessage('ttt2_priest_died')
        end
    end

    function PRIEST_DATA:BrotherDies(ply)
        -- unknown players keep their status
        if ply:GetSubRole() == ROLE_UNKNOWN then return end
        
        -- only remove if player is in brotherhood
        if not PRIEST_DATA:IsBrother(ply) then return end

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

    -- special case for unknown
    hook.Add('PlayerSpawn', 'ttt2_priest_unknown', function(ply)
        if ply:GetSubRole() == ROLE_UNKNOWN and PRIEST_DATA:IsBrother(ply) then 
            timer.Create('ttt2_priest_unknown_give_brotherhood', 0.05, 1, function() STATUS:AddStatus(ply, 'ttt2_role_priest_brotherhood') end)
        end
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
end

function PRIEST_DATA:IsBrother(ply)
    if not ply or not IsValid(ply) or not ply:IsPlayer() then return false end
    if not ply:SteamID64()or not ply:EntIndex() then return false end

    return self.brotherhood[tostring(ply:SteamID64() or ply:EntIndex())] or false
end
