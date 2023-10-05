local L = LANG.GetLanguageTableReference("en")

-- GENERAL ROLE LANGUAGE STRINGS
L[PRIEST.name] = "Priest"
L["info_popup_" .. PRIEST.name] = [[You are the Priest!
Use your holy deagle to convert players into your brotherhood. But be careful, only innocent players behave well.]]
L["body_found_" .. PRIEST.abbr] = "They were a Priest."
L["search_role_" .. PRIEST.abbr] = "This person was a Priest!"
L["target_" .. PRIEST.name] = "Priest"
L["ttt2_desc_" .. PRIEST.name] = [[The Priest needs to win with the innocents! They can confirm players for themselves with their holy weapon.]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_priest_was_priest"] = "This player appears to be a member of the brotherhood."
L["ttt2_priest_added"] = "It seems like a player was added to the brotherhood."
L["ttt2_priest_brother_died"] = "It seems like a brother died."
L["ttt2_priest_detective"] = "The holy spirit was used to hurt a detective."
L["ttt2_priest_infected"] = "The holy spirit was used to kill an infected."
L["ttt2_priest_necromancer"] = "The holy spirit was used to kill a necromancer."
L["ttt2_priest_sidekick"] = "The holy spirit was used to kill a sidekick."
L["ttt2_priest_died"] = "The holy spirit killed a priest."
L["ttt2_priest_priest"] = "You can't add a priest to the brotherhood."
L["ttt2_priest_marker"] = "It seems like the priest shot a bucket full of color."
L["ttt2_priest_brother_jackal"] = "Shooting the priest converted the whole brotherhood to sidekicks."
L["ttt2_priest_brother_necromancer"] = "Reviving the priest as a zombie converted the whole brotherhood to zombies."
L["ttt2_priest_brother_infected"] = "Killing the priest converted the whole brotherhood to infected."
L["ttt2_priest_player_brother"] = "PLAYER IS IN BROTHERHOOD"

L["title_event_brotherhood"] = "A player became a brother"
L["desc_event_brotherhood"] = "{priest} has added {brother} ({brole} / {bteam}) to their brotherhood."

L["ttt2_weapon_holydeagle_name"] = "Holy Deagle"
L["ttt2_weapon_holydeagle_desc"] = "Shoot a player to make him holy, but be careful to only hit people in the innocent team."

L["ttt2_priest_brotherhood"] = "Brotherhood"
L["ttt2_priest_brotherhood_yes"] = "yes"
L["ttt2_priest_brotherhood_no"] = "-"

L["label_help_priest_messages"] = "The priest receives status messages about their brotherhood in the top right message stack area. These contain info about members of their brotherhood dieing for example."
L["label_pri_show_messages"] = "Show brotherhood status messages to the priest"
L["label_pri_refill_time"] = "Time in seconds to recharge the holy deagle"
L["label_pri_damage_dete"] = "Amount of demage dealt when shooting a detective"
L["label_pri_damage_marker"] = "Amount of demage dealt when shooting a marker"
