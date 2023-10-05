local L = LANG.GetLanguageTableReference("de")

-- GENERAL ROLE LANGUAGE STRINGS
L[PRIEST.name] = "Priester"
L["info_popup_" .. PRIEST.name] = [[Du bist ein Priester!
Benutze deine Heilige Deagle um andere Spieler in deine Bruderschaft aufzunehmen. Aber sei vorsichtig, nur Unschuldige verhalten sich gut.]]
L["body_found_" .. PRIEST.abbr] = "Er war ein Priester!"
L["search_role_" .. PRIEST.abbr] = "Diese Person war ein Priester!"
L["target_" .. PRIEST.name] = "Priester"
L["ttt2_desc_" .. PRIEST.name] = [[Der Priester gewinnt zusammen mit den Unschuldigen! Mit seiner heiligen Waffe kann er Leute verbünden.]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_priest_was_priest"] = "Dieser Spieler scheint ein Mitglied der Bruderschaft zu sein."
L["ttt2_priest_added"] = "Es scheint so, als wäre ein weiterer Spieler der Bruderschaft beigetreten."
L["ttt2_priest_brother_died"] = "Es scheint so, als wäre ein Bruder gestorben."
L["ttt2_priest_detective"] = "Der heilige Geist wurde verwendet um einen Detektiv zu verletzen."
L["ttt2_priest_infected"] = "Der heilige Geist wurde verwendet um einen Infizierten zu töten."
L["ttt2_priest_necromancer"] = "Der heilige Geist wurde verwendet um einen Geisterbeschwörer zu töten."
L["ttt2_priest_sidekick"] = "Der heilige Geist wurde verwendet um einen Sidekick zu töten."
L["ttt2_priest_died"] = "Der heilige Geist hat einen Priester getötet."
L["ttt2_priest_priest"] = "Du kannst keinen Priester der Bruderschaft hinzufügen."
L["ttt2_priest_marker"] = "Es scheint so, als habe der Priester einen Farbeimer angeschossen."
L["ttt2_priest_brother_jackal"] = "Durch das Anschießen des Priesters wurde die ganze Bruderschaft zu Sidekicks."
L["ttt2_priest_brother_necromancer"] = "Durch das Wiederbeleben des Priesters wurde die ganze Bruderschaft zu Zombies."
L["ttt2_priest_brother_infected"] = "Durch das Töten des Priesters wurde die ganze Bruderschaft zu Infizierten."
L["ttt2_priest_player_brother"] = "SPIELER IST IN BRUDERSCHAFT"

L["title_event_brotherhood"] = "Ein Spieler wurde ein Bruder"
L["desc_event_brotherhood"] = "{priest} hat {brother} ({brole} / {bteam}) zur Bruderschaft hinzugefügt."

L["ttt2_weapon_holydeagle_name"] = "Heilige Deagle"
L["ttt2_weapon_holydeagle_desc"] = "Schieße auf einen Spieler, um ihn heilig zu machen. Aber pass auf nur auf Unschuldige zu schießen."

L["ttt2_priest_brotherhood"] = "Bruderschaft"
L["ttt2_priest_brotherhood_yes"] = "ja"
L["ttt2_priest_brotherhood_no"] = "-"

L["label_help_priest_messages"] = "Der Priester bekommt Statusnachrichten seiner Bruderschaft im Nachrichtenbereich oben rechts angezeigt. Diese beinhalten unter anderem Informationen über Mitglieder der Bruderschaft, die gestorben sind."
L["label_pri_show_messages"] = "Zeige dem Priester Bruderschaftstatusnachrichten"
L["label_pri_refill_time"] = "Zeit in Sekunden zum Wiederaufladen der heiligen Deagle"
L["label_pri_damage_dete"] = "Amount of demage dealt when shooting a detective"
L["label_pri_damage_marker"] = "Amount of demage dealt when shooting a marker"
