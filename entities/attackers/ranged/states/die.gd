extends "res://entities/attackers/states/die.gd"


# Plays the "explode" animation for the shooter module.
# Note that it MUST have the same FPS and number of frames of the
# ShootingEnemy basement's "explode" animation.
func enter() -> void:
	super()
	(owner as RangedAttacker).shooter.explode()
