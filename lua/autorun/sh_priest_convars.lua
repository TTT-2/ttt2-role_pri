CreateConVar('ttt_pri_refill_time', 45, {FCVAR_NOTIFY, FCVAR_ARCHIVE})
CreateConVar('ttt_pri_refill_time_missed', 5, {FCVAR_NOTIFY, FCVAR_ARCHIVE})
CreateConVar('ttt_pri_damage_dete', 30, {FCVAR_NOTIFY, FCVAR_ARCHIVE})
CreateConVar('ttt_pri_damage_marker', 30, {FCVAR_NOTIFY, FCVAR_ARCHIVE})
CreateConVar('ttt_pri_show_messages', 1, {FCVAR_NOTIFY, FCVAR_ARCHIVE})

hook.Add('TTTUlxDynamicRCVars', 'ttt2_ulx_dynamic_priest_convars', function(tbl)
	tbl[ROLE_PRIEST] = tbl[ROLE_PRIEST] or {}

	table.insert(tbl[ROLE_PRIEST], {cvar = 'ttt_pri_show_messages', checkbox = true, desc = 'ttt_pri_show_messages (def. 1)'})
	table.insert(tbl[ROLE_PRIEST], {cvar = 'ttt_pri_refill_time', slider = true, min = 0, max = 100, decimal = 0, desc = 'ttt_pri_refill_time (def. 45)'})
	table.insert(tbl[ROLE_PRIEST], {cvar = 'ttt_pri_refill_time_missed', slider = true, min = 0, max = 100, decimal = 0, desc = 'ttt_pri_refill_time_missed (def. 5)'})
	table.insert(tbl[ROLE_PRIEST], {cvar = 'ttt_pri_damage_dete', slider = true, min = 0, max = 100, decimal = 0, desc = 'ttt_pri_damage_dete (def. 30)'})
	table.insert(tbl[ROLE_PRIEST], {cvar = 'ttt_pri_damage_marker', slider = true, min = 0, max = 100, decimal = 0, desc = 'ttt_pri_damage_marker (def. 30)'})
end)