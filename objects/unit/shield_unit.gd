extends "res://objects/player_swarm.gd"

func rule(i, center):
	var unit = units[i];
	var direction_to_center = center - unit.get_global_position();
	return direction_to_center;
