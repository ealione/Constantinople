class_name Motion
extends State


func _move() -> void:
	var next_attacker_pos: Vector2 = (owner as Attacker).nav_agent.get_next_location()
	var cur_attacker_pos: Vector2 = (owner as Attacker).global_position
	var new_velocity: Vector2 = cur_attacker_pos.direction_to(next_attacker_pos) * (owner as Attacker).speed
	if (owner as Attacker).nav_agent.avoidance_enabled:
		(owner as Attacker).nav_agent.set_velocity(new_velocity)
	else:
		(owner as Attacker).nav_agent.velocity_computed.emit(new_velocity)
