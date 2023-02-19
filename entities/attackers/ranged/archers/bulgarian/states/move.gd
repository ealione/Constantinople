extends "res://entities/attackers/states/move.gd"


func update(delta: float) -> void:
	super(delta)
	# check if we need to exit the state
	if (owner as RangedAttacker).shooter.targets.size() > 0:
		finished.emit("shoot_still")
