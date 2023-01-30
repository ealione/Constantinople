class_name AttackerFSM
extends StateMachine


const STATES_STACK_COUNT := 2


func _ready():
	super()
	for node in get_children():
		states_map[String(node.name).to_lower()] = node


func is_hit(damage: int) -> void:
	if String(current_state.name) in ["Hit", "Die"]:
		return
	(owner as Attacker).health -= damage
	current_state.finished.emit("die" if (owner as Attacker).health == 0 else "hit")


func _change_state(state_name: String) -> void:
	current_state.exit()
	states_stack.push_front(states_map[state_name])
	if states_stack.size() > STATES_STACK_COUNT:
		states_stack.pop_back()
	current_state = states_stack[0]
	state_changed.emit(states_stack)
	current_state.enter()
