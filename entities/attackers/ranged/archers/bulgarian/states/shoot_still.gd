extends "res://entities/attackers/ranged/states/shoot_still.gd"


# Override parent function 
func enter() -> void:
	(owner as RangedAttacker).apply_animation("move")


func update(_delta: float) -> void:
	if (owner as RangedAttacker).shooter.can_shoot and \
			(owner as RangedAttacker).shooter.lookahead.is_colliding():
		(owner as RangedAttacker).shooter.shoot()
		var shooting_anim := (owner as RangedAttacker).shooter.gun.animation
		(owner as RangedAttacker).apply_animation(shooting_anim)
	if (owner as RangedAttacker).shooter.targets.is_empty():
		finished.emit("move")


func on_animation_finished() -> void:
	# restore the move animation when shoot_a/b are finished
	var cur_anim := String((owner as RangedAttacker).sprite.animation)
	if cur_anim in ["shoot_a", "shoot_b"]:
		(owner as RangedAttacker).apply_animation("move")
