L = LANG.GetLanguageTableReference("italiano")

-- GENERAL ROLE LANGUAGE STRINGS
L[PRIEST.name] = "Prete"
L["info_popup_" .. PRIEST.name] = [[Sei il Prete!
Usa la tua Deagle Benedetta per convertire i giocatori alla tua confraternita. Ma fai attenzione, solo i giocatori Innocenti si comporteranno bene.]]
L["body_found_" .. PRIEST.abbr] = "Era un Prete."
L["search_role_" .. PRIEST.abbr] = "Questa persona era un Prete!"
L["target_" .. PRIEST.name] = "Prete"
L["ttt2_desc_" .. PRIEST.name] = [[Il Prete deve vincere con gli innocenti!]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_priest_was_priest"] = "Questo giocatore sembra essere un membro della confraternita."
