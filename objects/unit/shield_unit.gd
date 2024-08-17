extends "res://objects/unit/unit.gd"

func get_force_of_repulsion(i, units, center):
	var velocity_outwards_center = units[i].get_global_position() - center;
	var amount_of_wrong_neighbors = 0;
	
	for j in range(0, units.size()): 
		if i == j:
			continue;
			
		if units[j].is_melee():
			continue;
		
		var distance_between_boids = units[i].get_global_position() - units[j].get_global_position();
		if distance_between_boids.length() < 30:
			
			if units[j].is_shield():
				amount_of_wrong_neighbors += 0.8;
			else: amount_of_wrong_neighbors += 1;
		
	if(amount_of_wrong_neighbors >= 4):
		return velocity_outwards_center * amount_of_wrong_neighbors * 50;
		
	return Vector2(0, 0);

func is_shield():
	return true;
