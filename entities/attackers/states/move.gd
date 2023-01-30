class_name Attacker
extends CharacterBody2D


signal target_changed(pos: Vector2)
signal dead

func enter() -> void:
	(owner as Attacker).apply_animation("move")


func update(_delta: float) -> void:
	_move()


func _on_navigation_agent_2d_target_reached() -> void:
	# for debug purposes, switch to "idle" state only when running in the editor
	if OS.has_feature("editor"):
		finished.emit("idle")
