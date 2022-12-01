extends Node

class_name GoapWorldState

var _priority: float             # useful if this is a goal state, to distinguish from other possible goals
var _name: String                # the human-readable name of the state
var _variables: Dictionary = {}  # the variables that in aggregate describe a worldstate


func _init(ws_name, priority=.0, variables=null):
	_name = ws_name
	_priority = priority
	_variables = variables


static func from_existing(other: GoapWorldState) -> GoapWorldState:
	return GoapWorldState.new(other._name, other._priority, other._variables)


func set_variable(id: int, value: bool):
	_variables[id] = value


func get_variable(id: int) -> bool:
	return _variables[id]


func is_equal_to(other: GoapWorldState) -> bool:
	return _variables == other._variables


func meets_goal(goal_state: GoapWorldState) -> bool:
	for key in goal_state._variables:
		if key not in _variables or _variables[key] != goal_state._variables[key]:
			return false
	return true


func distance_to(goal_state: GoapWorldState) -> int:
	var result = 0
	for key in goal_state._variables:
		if _variables[key] != goal_state._variables[key]:
			result += 1
	return result


func _to_string() -> String:
	return "::{name}[{priority}]".format({"name": _name.to_upper(), "priority": _priority})
