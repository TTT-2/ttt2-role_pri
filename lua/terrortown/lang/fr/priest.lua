local L = LANG.GetLanguageTableReference("fr")

-- GENERAL ROLE LANGUAGE STRINGS
L[PRIEST.name] = "Prêtre"
L["info_popup_" .. PRIEST.name] = [[Vous êtes le Prêtre!
Utilisez votre Saint Deagle pour convertir les joueurs et les unir à votre Fraternité. Mais attention, seuls les joueurs innocents se comporteront bien.]]
L["body_found_" .. PRIEST.abbr] = "C'était un Prêtre."
L["search_role_" .. PRIEST.abbr] = "Cette personne était un Prêtre!"
L["target_" .. PRIEST.name] = "Prêtre"
L["ttt2_desc_" .. PRIEST.name] = [[Le prêtre doit gagné avec les innocents ! Vous pouvez confirmer l'innocence des joueurs en leur tirant dessus avec votre Saint Deagle.]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_priest_was_priest"] = "Ce joueur semble être un membre de la Fraternité."
L["ttt2_priest_added"] = "Il semble qu'un joueur ait été ajouté à la Fraternité."
L["ttt2_priest_brother_died"] = "On dirait qu'un frère de la Fraternité est mort."
L["ttt2_priest_detective"] = "Le Saint-Esprit a été utilisé pour blesser un Détective."
L["ttt2_priest_infected"] = "Le Saint-Esprit a été utilisé pour tuer un Infectée."
L["ttt2_priest_necromancer"] = "Le Saint-Esprit a été utilisé pour tuer un Nécromancien."
L["ttt2_priest_sidekick"] = "Le Saint-Esprit a été utilisé pour tuer un Acolyte."
L["ttt2_priest_died"] = "Le Saint-Esprit a tué un Prêtre."
L["ttt2_priest_priest"] = "On ne peut pas ajouter un Prêtre à la Fraternité."
L["ttt2_priest_marker"] = "Il semble que le Prêtre ait tiré sur un seau plein de couleurs."
L["ttt2_priest_brother_jackal"] = "Le fait de tirer sur le Prêtre a converti toute la Fraternité en Acolyte."
L["ttt2_priest_brother_necromancer"] = "La réanimation du Prêtre en tant que zombie a converti toute la Fraternité en Zombies."
L["ttt2_priest_brother_infected"] = "Le meurtre du Prêtre a converti toute la Fraternité en Infecté."
L["ttt2_priest_player_brother"] = "LE JOUEUR EST DANS LA FRATERNITÉ"

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
