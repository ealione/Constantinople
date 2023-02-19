extends "res://entities/attackers/states/hit.gd"


func enter() -> void:
	super()
	# freeze the reload time for the duration of this state
	(owner as RangedAttacker).shooter.set_firerate_timer_paused(true)


func exit() -> void:
	super()
	(owner as RangedAttacker).shooter.set_firerate_timer_paused(false)
