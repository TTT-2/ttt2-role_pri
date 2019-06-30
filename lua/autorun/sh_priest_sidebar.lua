if SERVER then
    resource.AddFile('materials/vgui/ttt/hud_icon_brotherhood.png')
end

if CLIENT then
    hook.Add('Initialize', 'ttt2_role_priest_init', function() 
        STATUS:RegisterStatus('ttt2_role_priest_brotherhood', {
            hud = Material('vgui/ttt/hud_icon_brotherhood.png'),
            type = 'good'
        })
    end)
end