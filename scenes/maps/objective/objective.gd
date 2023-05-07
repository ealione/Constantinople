class_name Objective
extends Area2D

signal initialized(max_health: int)
signal health_changed(current_health: int)
signal destroyed

@export_range(0, 1000) var health: int = 500:
	set = set_health

@onready var collision := $CollisionShape2D as CollisionShape2D
@onready var animation_sprite := $AnimatedSprite2D as AnimatedSprite2D

func _ready():
	initialized.emit(health)

func set_health(value: int) -> void:
	health = max(0, value)
	if health == 0:
		collision.set_deferred("disabled", true)
		animation_sprite.play("die")
	else:
		health_changed.emit(health)

func _on_objective_body_entered(body: Node2D) -> void:
	if body is Attacker:
		health -= (body as Attacker).objective_damage

func _on_animated_sprite_animation_finished() -> void:
	destroyed.emit()
