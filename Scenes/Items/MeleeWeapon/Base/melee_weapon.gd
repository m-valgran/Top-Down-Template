extends Node2D

class_name MeleeWeapon

@export var _damage: int
@export var _character_anim: String
@export var _attack_speed: float
#@onready var _animation_player: AnimationPlayer = $AnimationPlayer
@onready var _animation_tree: AnimationTree = $AnimationTree
@onready var _hitbox: Hitbox = $Hitbox

func _ready():
	_hitbox._damage = _damage
	_animation_tree.set("parameters/TimeScale/scale", _attack_speed)

func try_attack():
	var attack_started = !_animation_tree.get("parameters/OneShot/active")
	var request = AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE
	if attack_started: _animation_tree.set("parameters/OneShot/request",request)
	return attack_started
