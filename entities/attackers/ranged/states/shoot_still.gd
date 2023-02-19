extends State


func enter() -> void:
	(owner as RangedAttacker).apply_animation("shoot_still")


func update(_delta: float) -> void:
	if (owner as RangedAttacker).shooter.can_shoot and \
			(owner as RangedAttacker).shooter.lookahead.is_colliding():
		(owner as RangedAttacker).shooter.shoot()
	if (owner as RangedAttacker).shooter.targets.is_empty():
		finished.emit("move")
