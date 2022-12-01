extends Node

class_name GoapPlanner

var _open: Array[GoapNode] = []    # the A* open list
var _closed: Array[GoapNode] = []  # the A* closed list


# Is the given worldstate a member of the closed list? (And by that we mean,
# does any node on the closed list contain an equal worldstate.)
func member_of_closed(ws: GoapWorldState) -> bool:
	return not _closed.filter(func(n): return n._ws.is_equal_to(ws)).is_empty()


# Is the given worldstate a member of the open list? (And by that we mean,
# does any node on the open list contain an equal worldstate.)
#
# returns Array of `GoapNode`s that satisfy the worldstate
func member_of_open(ws: GoapWorldState) -> Array[GoapNode]:
	return _closed.filter(func(n): return n._ws.is_equal_to(ws))


# Pops the first Node from the 'open' list, moves it to the 'closed' list, and
# returns a reference to this newly-closed Node. Its behavior is undefined if
# you call on an empty list.
func pop_and_close() -> GoapNode:
	if len(_open):
		_closed.append(_open.pop_front())
	return _closed[-1]


func add_to_open(node: GoapNode) -> void:
	_open.append(node)


# Given two worldstates, calculates an estimated distance (the A* 'heuristic') between the two.
# `current` the present worldstate
# `goal` the desired worldstate
#
# returns an estimated distance between them
func calculate_heuristic(current: GoapWorldState, goal: GoapWorldState) -> int:
	return current.distance_to(goal)


# Actually attempt to formulate a plan to get from start to goal, given a pool of
# available actions.
# `start` the starting worldstate
# `goal` the goal worldstate
# `actions` the available action pool
#
# returns a vector of Actions in REVERSE ORDER
func plan(start: GoapWorldState, goal: GoapWorldState, actions: Array[GoapAction]) -> Array[GoapAction]:
	if start.meets_goal(goal):
		return []
	
	# clear prior results, in case we had used this planner before
	_open.clear()
	_closed.clear()
	
	var starting_node = GoapNode.new(start, 0, calculate_heuristic(start, goal), 0, null)
	_open.append(starting_node)

	while not _open.is_empty():
		var current = pop_and_close()
		if current._ws.meets_goal(goal):
			var current_plan = []
			while current._parent_id != 0:
				current_plan.append(current._action)
				var itr = _open.filter(func(n): return n._id.is_equal_to(current._parent_id))
				if itr.is_empty():
					itr = _closed.filter(func(n): return n._id.is_equal_to(current._parent_id))
				current = itr[0]
			return current_plan

		for potential_action in actions:
			if potential_action._operable_on(current._ws):
				var outcome = potential_action._act_on(current._ws)

				if member_of_closed(outcome):
					continue
				
				var p_outcome_node = member_of_open(outcome)
				if p_outcome_node.is_empty():
					var found = GoapNode.new(outcome, current._g + potential_action.cost, calculate_heuristic(outcome, goal), current._id, potential_action)
					add_to_open(found)
				else:
					p_outcome_node = p_outcome_node[0]
					if current._g + potential_action.cost < p_outcome_node._g:
						p_outcome_node._parent_id = current._id
						p_outcome_node._g = current._g + potential_action.cost
						p_outcome_node._h = calculate_heuristic(outcome, goal)
						p_outcome_node._action = potential_action

						_open.sort()

	return []
