extends Node

class_name PlayerController

var _direction: Vector2

signal primary_action_activated
signal scrolled_to_item(order: int)

func _process(_delta):
	input_direction()
	input_primary_action()
	input_item_scroll()

func input_direction():
	var input_x = Input.get_axis("ui_left", "ui_right")
	var input_y = Input.get_axis("ui_up", "ui_down")
	_direction = Vector2(input_x,input_y).normalized()

func input_primary_action():
	if Input.is_action_pressed("ui_attack"):
		primary_action_activated.emit()

func input_item_scroll():
	if Input.is_action_just_released("ui_scroll_up"):
		scrolled_to_item.emit(1)
	if Input.is_action_just_released("ui_scroll_down"):
		scrolled_to_item.emit(-1)
