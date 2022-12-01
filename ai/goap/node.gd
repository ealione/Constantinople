extends Node

class_name GoapNode

var _ws: GoapWorldState  # the state of the world at this node
var _id: int             # the unique ID of this node
var _parent_id: int      # the ID of this node's immediate predecessor
var _g: int              # the A* cost from `start` to here
var _h: int              # the estimated remaining cost to `goal` from here
var _action: GoapAction  # the action that got us here


func _init(state: GoapWorldState, g: int, h: int, parent_id: int, action: GoapAction):
	_ws = state
	_g = g
	_h = h
	_parent_id = parent_id
	_action = action
	# _id = self.get_instance_id()  # TODO: create an incrementing counter
	

func get_class() -> String: 
	return "GoapNode"


func cost() -> int:
	return _g + _h


func is_less_than(other: GoapNode) -> bool:
	return cost() < other.cost()


func _to_string() -> String:
	return "::Node[{id}]-[{parent_id}]".format({"id": _id, "parent_id": _parent_id})
