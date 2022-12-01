extends Node

class_name GoapAction

const DEFAULT_COST = 1000

var _name: String = "Default Action"  # human readable name of a class
var conditions: Dictionary            # world state conditions that must be satisfied before this action can be taken.
var effects: Dictionary               # expected world state after this action takes place.
var cost: int = DEFAULT_COST          # cost of performing this action.


func _init(action_name: String):
	_name = action_name


func get_class() -> String: 
	return "GoapAction"


func _operable_on(ws: GoapWorldState) -> bool:
	if conditions.hash() == ws._variables.hash():
		return true
	for condition in conditions:
		if condition not in ws._variables or ws._variables[condition] != conditions[condition]:
			return false
	return true


func _act_on(ws: GoapWorldState) -> GoapWorldState:
	var tmp_ws = GoapWorldState.from_existing(ws)
	for effect in effects:
		tmp_ws.set_variable(effect, effects[effect])
	return tmp_ws


# This indicates if the action should be considered or not.
# Currently I'm using this method only during planning, but it could
# also be used during execution to abort the plan in case the world state
# does not allow this action anymore.
func is_valid() -> bool:
	return true


# Action Cost. This is a function so it handles situational costs, when the world
# state is considered when calculating the cost.
func get_cost(_blackboard) -> int:
	return DEFAULT_COST


func set_condition(key: int, value: bool) -> void:
	conditions[key] = value


func get_condition(key: int) -> bool:
	return conditions[key]


# Action requirements.
func get_conditions() -> Dictionary:
	return {}


func set_effect(key: int, value: bool) -> void:
	effects[key] = value


func get_effect(key: int) -> bool:
	return effects[key]


# What conditions this action satisfies.
func get_effects() -> Dictionary:
	return {}

# Action implementation called on every loop.
# "actor" is the NPC using the AI
# "delta" is the time in seconds since last loop.

# Returns true when the task is complete.
func perform(_actor, _delta) -> bool:
	return false


func _to_string() -> String:
	return "::{name}".format({"name": _name.to_upper()})
