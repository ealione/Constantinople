extends "res://entities/attackers/ranged/states/die.gd"


func enter() -> void:
	super()
	(owner as BulgarianArcher).rotor.hide()
	(owner as BulgarianArcher).explosion.play("default")
