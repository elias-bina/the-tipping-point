extends "res://objects/unit/unit.gd"

func get_force_of_repulsion(i, units, center):
	var velocity_outwards_center = units[i].get_global_position() - center;
	var amount_of_wrong_neighbors = 0;
	
	for j in range(0, units.size()): 
		if i == j:
			continue;
		
		var distance_between_boids = units[i].get_global_position() - units[j].get_global_position();
		if distance_between_boids.length() < 30:
			amount_of_wrong_neighbors += 1;
		
	if(amount_of_wrong_neighbors >= 4):
		return velocity_outwards_center * 50 * -1;
		
	return Vector2(0, 0);

func is_ranged():
	return true;
