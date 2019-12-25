hook.Add('TTT2AddChange', 'TTT2_role_priest_changelog', function()
	AddChange('TTT2 Role Priest - v1.0', [[
		<ul>
			<li>Initial Release</li>
		</ul>
		<br>
		<h2>How to Play:</h2>
		<p>The priest plays in the innocent team and his role is hidden like most other roles too. He has one very powerful tool: the holy deagle. With the use of said tool, he can create a powerful brotherhood of innocent players. Players inside the brotherhood see each other in the scoreboard. But he has to be careful, there are a few things to keep in mind:</p>
		<ul>
			<li>most innocent players are added to the brotherhood, except detectives and sniffers since it is too easy to confirm them</li>
			<li>shooting a detective or sniffer with the holy deagle deals 30 damage to them</li>
			<li>shooting an infected host or necromancer kills the infected host or necromancer, the same goes for sidekicks</li>
			<li>shooting other evil roles kills the priest</li>
			<li>shooting a marker will mark the whole brotherhood</li>
			<li>if the priest is converted to an infected, zombie (necromancer) or sidekick, all other members of the brotherhood are converted too</li>
			<li>while only innocent players can join the brotherhood, players stay in the brotherhood even if they are converted (e.g. jackal, unknown, ...)</li>
		</ul>
		<p>Additionally the holy deagle has a cooldown after being used. The cooldown is short by default if you missed the target but a higher cooldown is used if you added a player to the brotherhood.</p>
	]], os.time({year = 2019, month = 07, day = 02}))

	AddChange('TTT2 Role Priest - v1.1', [[
		<ul>
			<li>Fixed priest - sidekick/jackal interaction</li>
		</ul>
	]], os.time({year = 2019, month = 08, day = 01}))

	AddChange('TTT2 Role Priest - v1.2', [[
		<ul>
			<li>Fixed scoreboard sometimes causing erros</li>
			<li>Improved loadout by using other hooks, prevents wrong loadout when a player was a marker in the previous round</li>
		</ul>
	]], os.time({year = 2019, month = 09, day = 11}))

	AddChange('TTT2 Role Priest - v1.3', [[
		<ul>
			<li>Using new loadout functions that allow item giving without raceconditions</li>
			<li>Giving 10 armor points to the priest</li>
			<li>Added 'was brother' to the body search window</li>
		</ul>
	]], os.time({year = 2019, month = 10, day = 07}))

	AddChange('TTT2 Role Priest - v1.4', [[
		<ul>
			<li>Fixing a bug with the inspection of dead bodies when the player has respawned</li>
			<li>Adding role specific convars to ulx</li>
		</ul>
	]], os.time({year = 2019, month = 10, day = 09}))
end)