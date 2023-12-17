extends Node2D

class_name  MeleeWeapon

enum State { IDLE, ATTACKING }

@export var _damage: int
@export var _character_anim: String
@export var _animation_player: AnimationPlayer
@export var _attack_speed: float = 1
@onready var _hitbox: Hitbox = $Hitbox
var _state := State.IDLE

func _ready():
	_animation_player.connect("animation_finished", 
	_on_animation_player_animation_finished)
	_hitbox._damage = _damage

func try_attack():
	var attack_started = false
	if _state == State.IDLE:
		_state = State.ATTACKING
		_animation_player.speed_scale = _attack_speed
		_animation_player.play("attack")
		attack_started = true
	return attack_started

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "attack":
		_state = State.IDLE
