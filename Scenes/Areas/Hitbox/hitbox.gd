extends Area2D

class_name Hitbox

@onready var _collision_shape: CollisionShape2D = $CollisionShape2D
# exported so the animation player can activate and deactivate 
# the hitbox through the animation
@export var _activated: bool = false : set = set_activated
var _damage: int

func _ready():
	_activated = false

func set_activated(value: bool):
	_activated = value
	_collision_shape.set_deferred("disabled", !value)

func _on_area_entered(hurtbox: Hurtbox):
	var hit_info = {"damage":_damage}
	hurtbox.receive_hit(hit_info)
