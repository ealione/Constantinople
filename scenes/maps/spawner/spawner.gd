@tool
class_name Spawner
extends Node2D


signal countdown_started(seconds: float)
signal wave_started(current_wave: int)
signal enemies_defeated  # emitted in case of victory

const INITIAL_WAIT := 5.0  # amount of seconds to wait before starting a wave

@export_range(0.5, 5.0, 0.5) var spawn_rate: float = 2.0
@export var wave_count: int = 3
@export var enemy_count: int = 10
@export_range(1, 100) var spawn_count: int = 3:  # number of spawn locations (Marker2Ds)
	set = set_spawn_count
@export var enemies: Dictionary = {
	"archer": 45,  # higher probability of spawn
	"infantry": 40,
}

var objective_pos: Vector2
var map_limits: Rect2
var cell_size: Vector2i
var current_wave := 1
var are_waves_finished := false
var are_enemies_finished := false

@onready var wave_timer := $WaveTimer as Timer
@onready var spawns_container := $SpawnsContainer as Node2D
@onready var enemy_container := $EnemyContainer as Node2D
@onready var projectile_container := $ProjectileContainer as Node
@onready var infantry_spawns := []
@onready var ranged_spawns := []

func _ready() -> void:
	for marker in spawns_container.get_children():
		if (marker as SpawnLocation).spawn_type == 0:  # melee
			infantry_spawns.append(marker)
		elif (marker as SpawnLocation).spawn_type == 1:  # ranged
			ranged_spawns.append(marker)

# Called once by parent scene when ready
func initialize(_objective_pos: Vector2, _map_limits: Rect2, _cell_size: Vector2i) -> void:
	objective_pos = _objective_pos
	map_limits = _map_limits
	cell_size = _cell_size
	_start_wave_countdown()

# Called when changing the spawn count through the inspector
func set_spawn_count(value: int) -> void:
	spawn_count = value
	var _spawns_container := get_node("SpawnsContainer")
	var diff := value - _spawns_container.get_child_count()
	match signi(diff):
		1:
			for i in diff:
				var dup = _spawns_container.get_node("SpawnLocation1").duplicate() as Marker2D
				_spawns_container.add_child(dup, true)
				dup.owner = self
		-1:
			for i in abs(diff):
				_spawns_container.get_child(-1).queue_free()

# Called on wave timer's timeout
func _start_wave() -> void:
	wave_started.emit(current_wave)
	var tween := create_tween()
	for i in enemy_count:
		var chosen_enemy_path := Scenes.get_enemy_path(_pick_enemy())
		var spawn_delay := randf_range(spawn_rate / 2, spawn_rate)
		tween.tween_callback(_spawn_enemy.bind(chosen_enemy_path)).\
				set_delay(spawn_delay)
	tween.tween_callback(_end_wave)

func _end_wave() -> void:
	if current_wave == wave_count:
		are_waves_finished = true
		return
	current_wave += 1
	enemy_count += current_wave * 10
	_start_wave_countdown()

func _start_wave_countdown() -> void:
	wave_timer.start(INITIAL_WAIT)
	countdown_started.emit(INITIAL_WAIT)

func _spawn_enemy(enemy_path: String) -> void:
	# spawn an enemy
	var enemy: Attacker = load(enemy_path).instantiate()
	enemy_container.add_child(enemy)
	if enemy is RangedAttacker:
		# pick a random ranged marker and randomize its y axis
		var rang_spawn_pos := (ranged_spawns[randi() % ranged_spawns.size()] as Marker2D)
		rang_spawn_pos.global_position.y = randf_range(
				map_limits.position.y * cell_size.y,
				map_limits.end.y * cell_size.y)
		enemy.global_position = rang_spawn_pos.global_position
	else:
		# pick a random spawn location from the ground spawns
		enemy.global_position = (infantry_spawns[randi() % infantry_spawns.size()] as Marker2D).global_position
	enemy.dead.connect(_on_enemy_death.bind(enemy))
	if enemy is RangedAttacker:
		(enemy as RangedAttacker).shooter.projectile_instanced.connect(_on_enemy_projectile_instanced)
	enemy.move_to(objective_pos)

# Every time an enemy dies, we check if the player has just won.
# Note that waves will already be finished when the last enemy dies
func _on_enemy_death(enemy: Attacker) -> void:
	await enemy.tree_exited  # make sure enemy will already be freed when checking
	if enemy_container.get_child_count() == 0:
		are_enemies_finished = true
	if are_waves_finished and are_enemies_finished:
		enemies_defeated.emit()

func _on_enemy_projectile_instanced(projectile: Projectile) -> void:
	projectile_container.add_child(projectile, true)

# Implementation of the Cumulative Distribution Algorithm, used to spawn 
# things randomly based on weight
func _pick_enemy() -> String:
	var tot_probability: int = 0
	for key in enemies.keys():
		tot_probability += enemies[key]
	var rand_number = randi_range(0, tot_probability - 1)
	var item: String
	for key in enemies.keys():
		if rand_number < enemies[key]:
			item = key
			break
		rand_number -= enemies[key]
	return item
