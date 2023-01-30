extends Node
# Global helper class used to get information about game scenes.

#########
# ATTACKERS
#########

#crusader troops
const KNIGHT := "res://entities/attackers/infantry/knight.tscn" #melee
const CROSSBOWMAN := "res://entities/attackers/infantry/crossbowman.tscn"
const CRUSADER := "res://entities/attackers/ranged/tanks/crusader.tscn" #melee
# ottoman troops
const JANISSARY := "res://entities/attackers/shooting/demons/janissary.tscn"
const AZAB := "res://entities/attackers/infantry/azab.tscn"  #melee
const SIPAHI := "res://entities/attackers/infantry/sipahi.tscn"  #melee
const QAPUKULU := "res://entities/attackers/shooting/tanks/qapukulu.tscn"  #melee
# bulgarian troops
const BULGARIAN_HEAVY := "res://entities/attackers/shooting/demons/bulgarianheavy.tscn" #melee
const BULGARIAN_LIGHT := "res://entities/attackers/infantry/bulgarianlight.tscn" #melee
const BULGARIAN_ARCHER := "res://entities/attackers/infantry/bulgarianarcher.tscn"
# sassanid troops
const PAYGAN := "res://entities/attackers/shooting/tanks/paygan.tscn" #melee
const SASSANID_AARCHER := "res://entities/attackers/shooting/demons/sassaarcher.tscn"
const CLIBINARII := "res://entities/attackers/infantry/clibinarii.tscn" #melee
const WAR_ELEPHANT := "res://entities/attackers/infantry/warelephant.tscn" #melee
# slavic troops
const SLAV_SPEARMAN := "res://entities/attackers/shooting/tanks/slavspearman.tscn" #melee
const SLAV_ARCHER := "res://entities/attackers/shooting/demons/slavarcher.tscn"


###########
# DEFENDERS
###########

const MILITIA := "res://entities/defenders/infantry/militia.tscn" #melee
const BYZANTINE_INFANTRY := "res://entities/defenders/infantry/byzantineinf.tscn" #melee
const PARAMONAI := "res://entities/defenders/infantry/paramonai.tscn" #melee
const VARANGIAN := "res://entities/defenders/infantry/varangianpeasant.tscn" #melee
const CATAPHRAKTOI := "res://entities/defenders/archer/cataphraktoi.tscn" #melee
const MILITIA_ARCHER := "res://entities/defenders/cavalry/militiaarcher.tscn"
const AKRITES := "res://entities/defenders/cavalry/akrites.tscn"
const VARDARIOTAI := "res://entities/defenders/cavalry/vardariotai.tscn"
const TZANGATOROS := "res://entities/defenders/cavalry/tzangatoros.tscn"
const MERCENERY_CROSSBOWMAN := "res://entities/defenders/cavalry/merccrossbow.tscn"
const LATIN_KNIGHT := "res://entities/defenders/cavalry/latinknight.tscn" #melee
const BALISTA := "res://entities/defenders/cavalry/balista.tscn"
const ONAGER := "res://entities/defenders/cavalry/onager.tscn"
const CANNON := "res://entities/defenders/cavalry/cannon.tscn"


###########
# BUILDINGS
###########

const WALL := "res://entities/buildings/tower/tower.tscn"
const DOMESTIKOS := "res://entities/buildings/tower/domestikos.tscn"
const LOGOTHETES := "res://entities/buildings/tower/logothetes.tscn"
const BLACKSMITH := "res://entities/buildings/tower/blacksmith.tscn"
const TAVERNAE := "res://entities/buildings/tower/tavernae.tscn"
const FLETCHERS := "res://entities/buildings/tower/fletchers.tscn"
const ARMOURY := "res://entities/buildings/tower/armoury.tscn"
const SIEGE_WORKSHOP := "res://entities/buildings/tower/siegeworkshop.tscn"
const NOSOKOMEION := "res://entities/buildings/tower/nosokomeion.tscn"
const STONEMASON := "res://entities/buildings/tower/stonemason.tscn"
const BARRACKS := "res://entities/buildings/tower/barracks.tscn"
const ARCHERY_RANGE := "res://entities/buildings/tower/archeryrange.tscn" 

#######
# CARDS
#######

# TODO: Define cards here!!!

# Scenes
const MAIN_MENU := "res://interfaces/UI/menu/menu.tscn"
const MAP_TEMPLATE := "res://scenes/maps/map_template.tscn"

static func get_attacker_path(attacker_troop: String) -> String:
	var attacker_path: String
	match attacker_troop:
		"crusader":
			attacker_path = CRUSADER 
		"crossbowman":
			attacker_path = CROSSBOWMAN
		"knight":
			attacker_path = KNIGHT
		"janissary":
			attacker_path = JANISSARY
		"azab":
			attacker_path = AZAB
		"sipahi":
			attacker_path = SIPAHI
		"qapukulu":
			attacker_path = QAPUKULU
		"bulgarian heavy":
			attacker_path = BULGARIAN_HEAVY
		"bulgarian light":
			attacker_path = BULGARIAN_LIGHT
		"bulgarian archer":
			attacker_path = BULGARIAN_ARCHER
		"paygan":
			attacker_path = PAYGAN
		"sassanid aarcher":
			attacker_path = SASSANID_AARCHER
		"clibinarii":
			attacker_path = CLIBINARII
		"war elephant":
			attacker_path = WAR_ELEPHANT
		"slav spearman":
			attacker_path = SLAV_SPEARMAN
		"slav archer":
			attacker_path = SLAV_ARCHER
		_:
			printerr("Cannot get attacker scene from name %s" % attacker_troop)
	return attacker_path


static func get_defender_path(defender_name: String) -> String:
	var defender_path: String
	match defender_name:
		"militia":
			defender_path = MILITIA
		"byzantine infantry":
			defender_path = BYZANTINE_INFANTRY	
		"paramonai":
			defender_path = PARAMONAI
		"varangian":
			defender_path = VARANGIAN
		"cataphraktoi":
			defender_path = CATAPHRAKTOI
		"militia archer":
			defender_name = MILITIA_ARCHER
		"akrites":
			defender_path = AKRITES
		"vardariotai":
			defender_path = VARDARIOTAI
		"tzangatoros":
			defender_path = TZANGATOROS
		"mercenery crossbow":
			defender_path = MERCENERY_CROSSBOWMAN
		"balista":
			defender_path = BALISTA
		"onager":
			defender_path = ONAGER
		"cannon":
			defender_path = CANNON
		_:
			printerr("Cannot get human scene from name %s" % defender_name)
	return defender_path


static func get_building_path(building_name: String) -> String:
	var building_path: String
	match building_name:
		"tower":
			building_path = WALL
			building_path = DOMESTIKOS
			building_path = LOGOTHETES
			building_path = BLACKSMITH
			building_path = TAVERNAE
			building_path = FLETCHERS
			building_path = ARMOURY
			building_path = SIEGE_WORKSHOP
			building_path = NOSOKOMEION
			building_path = STONEMASON
			building_path = BARRACKS
			building_path = ARCHERY_RANGE
		_:
			printerr("Cannot get building scene from name %s" % building_name)
	return building_path


func change_scene(scene: String) -> void:
	var e = get_tree().change_scene_to_file(scene)
	if e != OK:
		push_error("Error while changing scene: %s" % str(e))
