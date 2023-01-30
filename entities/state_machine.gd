class_name StateMachine
extends Node


signal state_changed(states_stack: Array)


@export var START_STATE: NodePath


var states_map := {}
var states_stack: Array[Object] = []
var current_state: State = null


func _ready() -> void:
	for state_node in get_children():
		state_node.finished.connect(_change_state)
	initialize(START_STATE)


func _physics_process(delta: float) -> void:
	current_state.update(delta)


func _unhandled_input(event: InputEvent) -> void:
	current_state.handle_input(event)


func set_processing(value: bool) -> void:
	set_process_unhandled_input(value)


func initialize(start_state: NodePath) -> void:
	states_stack.push_front(get_node(start_state))
	current_state = states_stack[0]
	current_state.enter()


func _change_state(_state_name: String) -> void:
	pass


func _on_Sprite_animation_finished() -> void:
	current_state.on_animation_finished()
