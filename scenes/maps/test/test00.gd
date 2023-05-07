extends Node2D

const STARTING_SOLIDUS := 1000

@onready var objective := $Objective as Objective
@onready var spawner := $Spawner as Spawner

func _ready():
	randomize()
	# initialize money
	Global.solidus = STARTING_SOLIDUS
	
	# connect signals
	
	# start spawning attackers
	spawner.initialize(objective.global_position)
