extends State


func enter() -> void:
	(owner as Attacker).stop()
	(owner as Attacker).apply_animation("idle")
