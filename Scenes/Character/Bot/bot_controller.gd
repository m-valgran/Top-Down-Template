extends Node2D

class_name BotController

@onready var _raycasts: Array[Node] = get_children()
var _current_target = null : set = set_current_target
var _direction: Vector2

signal primary_action_activated
signal scrolled_to_item(order: int) # currently does nothing

func _process(_delta):
	calculate_direction()
	detect_target()

func calculate_direction():
	if _current_target != null:
		var target_pos = _current_target.global_position
		_direction = global_position.direction_to(target_pos)
	else:
		_direction = Vector2.ZERO

func set_current_target(value):
	if value is Character: _current_target = value
	else: _current_target = null

func detect_target():
	for raycast in _raycasts:
		if raycast.is_colliding():
			if raycast.get_collider() == _current_target:
				primary_action_activated.emit()
