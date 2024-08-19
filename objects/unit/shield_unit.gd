extends Unit

class_name ShieldUnit

var units_neighbors = []

const repulstion_rate: int = 180
const reposition_rate: int = 200



func get_velocity_modifier(center):
	var dir_to_center: Vector2 = center - position
	var nb_wrong_neighbor: int = 0
	var nb_meh_neighbor: int = 0
	for unit in units_neighbors:
		if unit is not ShieldUnit:
			if dir_to_center.dot(unit.position - position) < 0:
				nb_wrong_neighbor += 1
		else:
			if dir_to_center.dot(unit.position - position) < 0:
				nb_meh_neighbor = 1
	
	
	return -dir_to_center.normalized() * nb_wrong_neighbor * repulstion_rate + \
		   -dir_to_center.normalized().rotated(- PI / 3) * nb_meh_neighbor * reposition_rate;


func _on_entity_detection_range_body_entered(body: Node2D) -> void:
	if body is Enemy:
		look_at(body.global_position)
	
	if body is Unit and body != self:
		units_neighbors.append(body)



func _on_entity_detection_range_body_exited(body: Node2D) -> void:
	if body is Unit and body != self:
		units_neighbors.erase(body)
