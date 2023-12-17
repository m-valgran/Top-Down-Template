extends Area2D

var _multiplier = 25

func get_repulsion_vector():
	var areas = get_overlapping_areas()
	if areas.size() > 0:
		var repulsion_vector = areas[0].global_position
		repulsion_vector = repulsion_vector.direction_to(global_position)
		return repulsion_vector * _multiplier
	return Vector2.ZERO
