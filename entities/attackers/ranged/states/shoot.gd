extends Motion


func enter() -> void:
	(owner as RangedAttacker).apply_animation("shoot")


func update(_delta: float) -> void:
	_move()
	if (owner as RangedAttacker).shooter.can_shoot and \
			(owner as RangedAttacker).shooter.lookahead.is_colliding():
		(owner as RangedAttacker).shooter.shoot()
	# check if we need to exit the state
	if (owner as RangedAttacker).shooter.targets.is_empty():
		finished.emit("move")
	else:
		for target in (owner as RangedAttacker).shooter.targets:
			if target is Objective:
				finished.emit("shoot_still")
				break
