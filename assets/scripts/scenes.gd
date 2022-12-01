extends Node
# Global helper class used to get information about game scenes.


# Monsters
const ZOMBY_T1 := "res://entities/monsters/infantry/zomby_t1.tscn"
const ZOMBY_T2 := "res://entities/monsters/infantry/zomby_t2.tscn"
const TANK := "res://entities/monsters/shooting/tanks/tank.tscn"
const DEMON := "res://entities/monsters/shooting/demons/helicopter.tscn"
# Humans
const KNIGHT_T1 := "res://entities/humans/infantry/knight_t1.tscn"
const KNIGHT_T2 := "res://entities/humans/infantry/knight_t2.tscn"
const SPEARMAN := "res://entities/humans/infantry/spearman.tscn"
const PEASANT := "res://entities/humans/infantry/peasant.tscn"
const ARCHER := "res://entities/humans/archer/archer.tscn"
const CAVALRY_KNIGHT := "res://entities/humans/cavalry/knight.tscn"
const CAVALRY_HUSSAR := "res://entities/humans/cavalry/hussar.tscn"
# BUILDINGS
const TOWER := "res://entities/buildings/tower/tower.tscn"
# Scenes
const MAIN_MENU := "res://interfaces/UI/menu/menu.tscn"
const MAP_TEMPLATE := "res://scenes/maps/map_template.tscn"


static func get_zomby_path(zomby_name: String) -> String:
	var zomby_path: String
	match zomby_name:
		"zomby_t1":
			zomby_path = ZOMBY_T1
		"zomby_t2":
			zomby_path = ZOMBY_T2
		"tank":
			zomby_path = TANK
		"demon":
			zomby_path = DEMON
		_:
			printerr("Cannot get zomby scene from name %s" % zomby_name)
	return zomby_path


static func get_human_path(human_name: String) -> String:
	var human_path: String
	match human_name:
		"knight_t1":
			human_path = KNIGHT_T1
		"knight_t2":
			human_path = KNIGHT_T2	
		"spearman":
			human_path = SPEARMAN
		"peasant":
			human_path = PEASANT
		"archer":
			human_path = ARCHER
		"cavalry_knight":
			human_path = CAVALRY_KNIGHT
		"cavalry_hussar":
			human_path = CAVALRY_HUSSAR
		_:
			printerr("Cannot get human scene from name %s" % human_name)
	return human_path


static func get_building_path(building_name: String) -> String:
	var building_path: String
	match building_name:
		"tower":
			building_path = TOWER
		_:
			printerr("Cannot get building scene from name %s" % building_name)
	return building_path


func change_scene(scene: String) -> void:
	var e = get_tree().change_scene_to_file(scene)
	if e != OK:
		push_error("Error while changing scene: %s" % str(e))
