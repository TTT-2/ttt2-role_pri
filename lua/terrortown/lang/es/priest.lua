local L = LANG.GetLanguageTableReference("es")

-- GENERAL ROLE LANGUAGE STRINGS
L[PRIEST.name] = "Sacerdote"
L["info_popup_" .. PRIEST.name] = [[¡Eres el Sacerdote!
Usa tu Deagle Sagrada para santificar a las personas y unirlas a La Hermandad. Ten cuidado, sólo los inocentes se portarán bien.]]
L["body_found_" .. PRIEST.abbr] = "¡Era un Sacerdote!"
L["search_role_" .. PRIEST.abbr] = "Esta persona era un Sacerdote."
L["target_" .. PRIEST.name] = "Sacerdote"
L["ttt2_desc_" .. PRIEST.name] = [[¡El Sacerdote gana con los inocentes! Pueden confirmar la inocencia de los jugadores 
disparándoles con su Deagle Sagrada.]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_priest_was_priest"] = "Este jugador parece ser parte de La Hermandad."
L["ttt2_priest_added"] = "Parece que un jugador fue añadido a La Hermandad."
L["ttt2_priest_brother_died"] = "Parece que un hermano nuestro ha muerto."
L["ttt2_priest_detective"] = "El Espíritu Santo fue usado para dañar a un Detective."
L["ttt2_priest_infected"] = "El Espíritu Santo fue usado para matar a un Infectado."
L["ttt2_priest_necromancer"] = "El Espíritu Santo fue usado para matar a un Nigromante."
L["ttt2_priest_sidekick"] = "El Espíritu Santo fue usado para matar a un Socio."
L["ttt2_priest_died"] = "El Espíritu Santo asesinó a un Sacerdote."
L["ttt2_priest_priest"] = "No puedes añadir a un Sacerdote a La Hermandad."
L["ttt2_priest_marker"] = "Parece que el Sacerdote decidió dispararle a una lata de pintura."
L["ttt2_priest_brother_jackal"] = "La Hermandad se convirtió en Socios del Zorro."
L["ttt2_priest_brother_necromancer"] = "Revivir al Sacerdote como Zombie convierte a toda La Hermandad en Zombie."
L["ttt2_priest_brother_infected"] = "Matar al Sacerdote convirtió a toda La Hermandad en Infectados."
L["ttt2_priest_player_brother"] = "EL JUGADOR ESTÁ EN LA HERMANDAD"

--L["title_event_brotherhood"] = "A player became a brother"
--L["desc_event_brotherhood"] = "{priest} has added {brother} ({brole} / {bteam}) to their brotherhood."
