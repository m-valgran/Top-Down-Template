extends ParallaxBackground
@onready var _texture_rect = $ParallaxLayer/TextureRect
@onready var _texture_size = _texture_rect.texture.get_size()
@onready var _parallax_layer = $ParallaxLayer

func _ready():
	draw_ground()
	get_tree().get_root().connect("size_changed", draw_ground)

func draw_ground():
	var viewport_size = _parallax_layer.get_viewport_rect().size
	var texture_area = _texture_size * ceil(viewport_size/_texture_size)
	_parallax_layer.motion_mirroring = texture_area
	_texture_rect.size = texture_area
