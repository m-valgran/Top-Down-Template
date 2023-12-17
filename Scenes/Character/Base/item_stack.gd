extends Node2D

class_name ItemStack

@onready var _items:Array[Node] = get_children()
@onready var _selected_item: Node = _items[0]

signal primary_action_started(character_anim: String, anim_len: float)
signal item_selected(character_anim: String)

func _ready():
	init_items()

func init_items():
	for item in _items:
		if item != _selected_item:
			item.visible = false
	await get_tree().process_frame # do this before emit signal
	item_selected.emit(_selected_item._character_anim)

func activate_primary_action():
	# if selected item is melee weapon...
	if _selected_item.try_attack():
		var speed_scale = _selected_item._animation_player.speed_scale
		primary_action_started.emit(_selected_item._character_anim,speed_scale)

func scroll_to_item(order: int):
	if order:
		var selected_item_index = _items.find(_selected_item)
		var last_item_index = _items.size() - 1
		select_item(clamp(selected_item_index + order, 0, last_item_index))

func select_item(index):
	_selected_item.visible = false
	_selected_item = _items[index]
	_selected_item.visible = true
	item_selected.emit(_selected_item._character_anim)
