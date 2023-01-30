extends State


const FADE_OUT_DURATION := 0.25


func enter():
	(owner as Attacker).collision.set_deferred("disabled", true)
	(owner as Attacker).stop()
	(owner as Attacker).apply_animation("die")
	Global.solidus += int((owner as Attacker).hud.healthbar.max_value)


func on_animation_finished() -> void:
	var tween := get_tree().create_tween()
	tween.tween_property((owner as Attacker), "modulate:a", 0.0, FADE_OUT_DURATION)
	tween.finished.connect(_on_tween_finished)


func _on_tween_finished() -> void:
	(owner as Attacker).dead.emit()
	(owner as Attacker).queue_free()
