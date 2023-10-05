local L = LANG.GetLanguageTableReference("ru")

-- GENERAL ROLE LANGUAGE STRINGS
L[PRIEST.name] = "Священник"
L["info_popup_" .. PRIEST.name] = [[Вы священник!
Используйте свой святой deagle, чтобы превратить игроков в своё братство. Но будьте осторожны, хорошо себя ведут только невиновные игроки.]]
L["body_found_" .. PRIEST.abbr] = "Он был священником."
L["search_role_" .. PRIEST.abbr] = "Этот человек был священником!"
L["target_" .. PRIEST.name] = "Священник"
L["ttt2_desc_" .. PRIEST.name] = [[Священнику нужно побеждать с невинными! Они могут подтвердить игроков своим святым оружием.]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_priest_was_priest"] = "Этот игрок, похоже, является членом братства."
L["ttt2_priest_added"] = "Похоже, к братству добавили игрока."
L["ttt2_priest_brother_died"] = "Похоже, брат умер."
L["ttt2_priest_detective"] = "Святой дух был использован, чтобы ранить детектива."
L["ttt2_priest_infected"] = "Святой дух использовался, чтобы убить заражённого."
L["ttt2_priest_necromancer"] = "Святой дух использовался, чтобы убить некроманта."
L["ttt2_priest_sidekick"] = "Святой дух использовался, чтобы убить сообщника."
L["ttt2_priest_died"] = "Святой дух убил священника."
L["ttt2_priest_priest"] = "В братство нельзя добавить священника."
L["ttt2_priest_marker"] = "Кажется, священник выстрелил в ведро, полное краски."
L["ttt2_priest_brother_jackal"] = "Стрельба в священника превратила всё братство в сообщников."
L["ttt2_priest_brother_necromancer"] = "Возрождение священника как зомби превратило всё братство в зомби."
L["ttt2_priest_brother_infected"] = "Убийство священника превратило всё братство в заражённых."
L["ttt2_priest_player_brother"] = "ИГРОК В БРАТСТВЕ"

--L["title_event_brotherhood"] = "A player became a brother"
--L["desc_event_brotherhood"] = "{priest} has added {brother} ({brole} / {bteam}) to their brotherhood."

--L["ttt2_weapon_holydeagle_name"] = "Holy Deagle"
--L["ttt2_weapon_holydeagle_desc"] = "Shoot a player to make him holy, but be careful to only hit people in the innocent team."

--L["ttt2_priest_brotherhood"] = "Brotherhood"
--L["ttt2_priest_brotherhood_yes"] = "yes"
--L["ttt2_priest_brotherhood_no"] = "-"

--L["label_help_priest_messages"] = "The priest receives status messages about their brotherhood in the top right message stack area. These contain info about members of their brotherhood dieing for example."
--L["label_pri_show_messages"] = "Show brotherhood status messages to the priest"
--L["label_pri_refill_time"] = "Time in seconds to recharge the holy deagle"
--L["label_pri_damage_dete"] = "Amount of demage dealt when shooting a detective"
--L["label_pri_damage_marker"] = "Amount of demage dealt when shooting a marker"
