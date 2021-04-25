if CLIENT then
	EVENT.icon = Material("vgui/ttt/vskin/events/brotherhood")
	EVENT.title = "title_event_brotherhood"

	function EVENT:GetText()
		return {
			{
				string = "desc_event_brotherhood",
				params = {
					priest = self.event.priest.nick,
					brother = self.event.brother.nick,
					brole = roles.GetByIndex(self.event.brother.role).name,
					bteam = self.event.brother.team,
				},
				translateParams = true
			}
		}
	end
end

if SERVER then
	function EVENT:Trigger(priest, brother)
		if not IsValid(priest) then return end

		self:AddAffectedPlayers(
			{priest:SteamID64(), brother:SteamID64()},
			{priest:Nick(), brother:Nick()}
		)

		return self:Add({
			priest = {
				nick = priest:Nick(),
				sid64 = priest:SteamID64()
			},
			brother = {
				nick = brother:Nick(),
				sid64 = brother:SteamID64(),
				role = brother:GetSubRole(),
				team = brother:GetTeam(),
			}
		})
	end
end

function EVENT:Serialize()
	return self.event.priest.nick .. " had added " .. self.event.brother.nick .. " to their brotherhood."
end
