extends Node

var _action_planner =  GoapPlanner.new()

func _ready():
	_action_planner.set_actions([
		BuildFirepitAction.new(),
		ChopTreeAction.new(),
		CollectFromWoodStockAction.new(),
		CalmDownAction.new(),
		FindCoverAction.new(),
		FindFoodAction.new(),
	])


func get_action_planner() -> GoapPlanner:
	return _action_planner
