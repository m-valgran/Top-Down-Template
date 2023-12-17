extends CanvasLayer

class_name HUD

@onready var _health_label = $VBoxContainer/HealthLabel

func _ready():
	PlayerInfo.connect("health_changed",display_health)
	display_health()

func display_health():
	_health_label.text = "Health: " + str(PlayerInfo._health)
