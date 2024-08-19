extends Unit

class_name MeleeUnit

var sword_slash = preload("res://objects/projectiles/sword_slash.tscn");

var units_neighbors = []

const repulstion_rate: int = 80
const reposition_rate: int = 50

func _ready() -> void:
	$AnimationPlayer.play("down")

func get_velocity_modifier(center):
	var dir_to_center: Vector2 = center - position
	var nb_wrong_neighbor: int = 0
	var nb_meh_neighbor: int = 0
	for unit in units_neighbors:
		if unit is RangedUnit:
			if dir_to_center.dot(unit.position - position) < 0:
				nb_wrong_neighbor += 1
		if unit is MeleeUnit:
			if dir_to_center.dot(unit.position - position) < 0:
				nb_meh_neighbor = 1
	
	
	return -dir_to_center.normalized() * nb_wrong_neighbor * repulstion_rate + \
		   -dir_to_center.normalized().rotated(PI / 3) * nb_meh_neighbor * reposition_rate;

func attack():
	var slash = sword_slash.instantiate()
	slash.set_global_position(Vector2(40,0))
	add_child(slash)


func _on_entity_detection_range_body_entered(body: Node2D) -> void:
	if body is Enemy:
		look_at(body.global_position)
	
	if body is Unit and body != self:
		units_neighbors.append(body)



func _on_entity_detection_range_body_exited(body: Node2D) -> void:
	if body is Unit and body != self:
		units_neighbors.erase(body)
