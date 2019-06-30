if CLIENT then
    
    function DrawPriestInfo()
        --print("A")
        local client = LocalPlayer()

        if not PRIEST_DATA:IsBrother(client) then return end
        --print("B")

        local tracedata = {}
        tracedata.start = client:GetShootPos()
        tracedata.endpos = tracedata.start + (client:GetEyeTrace().HitPos - tracedata.start) *2 -- make sure the trace is long enough
        tracedata.filter = client
        local trace = util.TraceLine(tracedata)
        --print("C")

        if trace.HitNonWorld and IsValid(trace.Entity) and trace.Entity:IsPlayer() then
            --print("D")
            if not PRIEST_DATA:IsBrother(trace.Entity) then return end
            --print("E")
            local x = ScrW() / 2.0
            local y = ScrH() / 1.5            
            draw.SimpleText("(PLAYER IS IN BROTHERHOOD)", "TabLarge", x, y - 50, client:GetRoleColor(), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
        end
    end
    hook.Add('HUDPaint', 'ttt2_role_priest_hud_info', DrawPriestInfo)
end