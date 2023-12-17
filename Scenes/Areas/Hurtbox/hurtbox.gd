extends Area2D

class_name Hurtbox

signal hit_received(hit_info: Dictionary)

func receive_hit(hit_info: Dictionary):
	hit_received.emit(hit_info)
