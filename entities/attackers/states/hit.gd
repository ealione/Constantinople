extends Motion


@export var state_duration: float = 0.5
@export var slowdown_percentage: float = 0.2  # percentage of diminished speed

var prev_state: State

@onready var timer := Timer.new()
@onready var prev_speed := (owner as Attacker).speed


func _ready() -> void:
	timer.timeout.connect(_on_Timer_timeout)
	timer.one_shot = true
	add_child(timer)


func enter() -> void:
	(owner as Attacker).speed -= int((owner as Attacker).speed * slowdown_percentage)
	prev_state = (owner as Attacker).state_machine.states_stack.back()
	timer.start(state_duration)


func exit() -> void:
	timer.stop()
	(owner as Attacker).speed = prev_speed


func update(_delta: float) -> void:
	if prev_state is Motion:
		_move()


func _on_Timer_timeout() -> void:
	finished.emit((prev_state.name as String).to_lower())
