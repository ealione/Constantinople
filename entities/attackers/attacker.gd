class_name Attacker
extends CharacterBody2D

signal target_changed(pos: Vector2)
signal dead

@export var rotation_speed: float = 10.0
@export var health: int = 100:
	set = set_health
@export var speed: int = 300

var objective_damage := 10  # default damage dealt to objective

@onready var state_machine := $StateMachine as StateMachine
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var sprite := $Sprite2D as AnimatedSprite2D:
	get: return $Sprite2D as AnimatedSprite2D
@onready var collision := $CollisionShape2D as CollisionShape2D
#@onready var hud := $UI/EntityHUD as EntityHud


func _ready() -> void:
	# initialize HUD
#	hud.state_label.text = state_machine.current_state.name
#	hud.healthbar.max_value = health
#	hud.healthbar.value = health
	# initialize navigation agent
	nav_agent.max_speed = speed


func _physics_process(delta: float) -> void:
	# Rotate based on current velocity
	sprite.global_rotation = _calculate_rot(sprite.global_rotation, velocity.angle(), rotation_speed, delta)
	collision.global_rotation = _calculate_rot(collision.global_rotation, velocity.angle(), rotation_speed, delta)


func move_to(pos: Vector2) -> void:
	nav_agent.set_target_location(pos)
	target_changed.emit(nav_agent.get_target_location())


func stop() -> void:
	if velocity == Vector2.ZERO:
		return
	nav_agent.set_velocity(Vector2.ZERO)


func apply_animation(anim_name: String) -> void:
	if sprite.frames.has_animation(anim_name):
		sprite.play(anim_name)
	else:
		print_debug("Sprite node doesn't have animation %s!" % anim_name)


func set_health(value: int) -> void:
	health = max(0, value)
#	if is_instance_valid(hud):
#		hud.healthbar.value = health


func _calculate_rot(start_rot: float, target_rot: float, _speed: float, delta: float) -> float:
	return lerp_angle(start_rot, target_rot, _speed * delta)


func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity
	move_and_slide()


func _on_state_machine_state_changed(states_stack: Array) -> void:
#	hud.state_label.text = (states_stack[0] as State).name
	pass
