extends Node

#var _max_health: int
var _health: int : set = set_health

signal health_changed()

func set_health(value: int):
	_health = value
	health_changed.emit()
