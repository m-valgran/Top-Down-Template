extends CharacterBody2D

class_name Character

#enum State { IDLE, MOVING, DYING }
#var _state: State = State.IDLE

@export var _max_health: int
@export var _health: int : set = set_health
@export var _speed: int
@export var _acceleration: int
@export var _friction: int

@onready var _character_controller = $CharacterController
@onready var _is_player := _character_controller is PlayerController
@onready var _hurtbox: Hurtbox = $Hurtbox
@onready var _animation_player: AnimationPlayer = $AnimationPlayer
@onready var _item_stack: ItemStack = $ItemStack
@onready var _soft_collision: Area2D = $SoftCollision

func set_health(value: int):
	_health = clamp(value,0,_max_health)
	if _health <= 0: 
		# _state = State.DYING
		_animation_player.play("die")
	if _is_player: PlayerInfo._health = _health

func _ready():
	if _is_player: PlayerInfo._health = _health
	_hurtbox.connect("hit_received", 
	on_hurtbox_hit_received)
	_character_controller.connect("primary_action_activated",
	on_character_controller_primary_action_activated)
	_character_controller.connect("scrolled_to_item",
	on_character_controller_scrolled_to_item)
	_item_stack.connect("item_selected", 
	on_item_stack_item_selected)
	_item_stack.connect("primary_action_started", 
	on_item_stack_primary_action_started)
	_animation_player.connect("animation_finished",
	on_animation_player_animation_finished)

func _physics_process(_delta):
	move()

func move():
	var to; var delta
	var direction = _character_controller._direction
	if direction != Vector2.ZERO:
		# _state = State.MOVING
		to = direction * _speed
		delta = _acceleration
		rotation = direction.angle() + PI / 2
	else:
		# _state = State.IDLE
		to = Vector2.ZERO
		delta = _friction
	velocity = velocity.move_toward(to,delta)
	velocity += _soft_collision.get_repulsion_vector()
	move_and_slide()

func on_hurtbox_hit_received(hit_info: Dictionary):
	_health -= hit_info["damage"]

func on_character_controller_scrolled_to_item(order: int):
	_item_stack.scroll_to_item(order)

func on_item_stack_item_selected(character_anim: String):
	_animation_player.play("idle_" + character_anim)

func on_character_controller_primary_action_activated():
	# TODO: Only if the state is NOT "DYING"
	_item_stack.activate_primary_action()

func on_item_stack_primary_action_started(character_anim: String, speed_scale: float):
	_animation_player.speed_scale = speed_scale
	# _animation_player.stop()
	# TODO: Make a blend for primary + moving and primary + idle. Varying on the state, 
	# play either one or the other.
	_animation_player.play("primary_" + character_anim)

func on_animation_player_animation_finished(anim_name: String):
	if anim_name == "die":
		queue_free()
