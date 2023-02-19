class_name BulgarianArcher
extends RangedAttacker


func _ready() -> void:
	super()
	# make sure all animated sprites are synchronized
	_sync_animations()


func _physics_process(delta: float) -> void:
	super(delta)
	# handle all sprites' rotation
	if shooter.targets.is_empty():
		sprite.global_rotation = _calculate_rot(sprite.global_rotation,
			velocity.angle(), rot_speed, delta)
		shooter.rotation = sprite.global_rotation
	else:
		sprite.global_rotation = shooter.rotation


func apply_animation(anim_name: String) -> void:
	super(anim_name)


func _sync_animations() -> void:
	for animated_sprite in [sprite, shooter.gun]:
		(animated_sprite as AnimatedSprite2D).frame = 0
		(animated_sprite as AnimatedSprite2D).playing = true


func _on_shooter_anim_restarted(anim_name: String) -> void:
	if anim_name in ["move", "shoot_a", "shoot_b"]:
		_sync_animations()
