# Priest - A new Role for TTT2

The priest plays in the innocent team and his role is hidden like most other roles too. He has one very powerful tool: the holy deagle. With the use of said tool, he can create a powerful brotherhood of innocent players. Players inside the brotherhood see each other in the scoreboard. But he has to be careful, there are a few things to keep in mind:

- most innocent players are added to the brotherhood, except detectives and sniffers since it is to easy to confirm them
- shooting a detective or sniffer with the holy deagle deals 30 damage to them
- shooting an infected host or necromancer kills the infected host or necromancer, the same goes for sidekicks
- shooting other evil roles kills the priest while still damaging them like detectives
- shooting a marker will mark the whole brotherhood
- if the priest is converted to an infected, zombie (necromancer) or sidekick, all other members of the brotherhood are converted too
- while only innocent players can join the brotherhood, players stay in the brotherhood even if they are converted (e.g. jackal, unknown, ...)

Additionally the holy deagle has a cooldown after being used. The cooldown is short by default if you missed the target but a higher cooldown is used if you added a player to the brotherhood.

## Convars

Besides the normal role convars found in ULX, there are these special convars:

```
# the time in seconds for the holy deagle to recharge after a player was hit
  ttt_pri_refill_time [0..n] (def: 45)
# the time in seconds for the holy deagle to recharge after a player missed a shot
  ttt_pri_refill_time_missed [0..n] (def: 5)
# the amount of damage delt to detectives
  ttt_pri_damage_dete [0..n] (def: 30)
# the amount of damage delt to marers
  ttt_pri_damage_marker [0..n] (def: 30)
# defines if players in the brotherhood should be notified with messages about players in their team
  ttt_pri_show_messages [0/1] (def: 1)
```