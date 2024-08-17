extends Node

var melee_unit = preload("res://objects/unit/melee_unit.tscn");
var ranged_unit = preload("res://objects/unit/ranged_unit.tscn");
var shield_unit = preload("res://objects/unit/shield_unit.tscn");
var units = [];
var nb_of_units = 0;

var unit_speed = 0.01;
var center_of_swarm = Vector2(200, 200);

func initialize_positions(screen_range, nb_of_melee, nb_of_ranged, nb_of_shield):
	randomize();
	nb_of_units = nb_of_melee + nb_of_ranged + nb_of_shield;
	print(nb_of_units);
	for i in range(0, nb_of_units):
		if(i < nb_of_melee):
			units.append(melee_unit.instantiate());
		elif(i < nb_of_melee + nb_of_ranged):
			units.append(ranged_unit.instantiate());
		elif(i < nb_of_melee + nb_of_ranged + nb_of_shield):
			units.append(shield_unit.instantiate());
			
		units[i].set_global_position(Vector2(randi_range(0, screen_range.x), randi_range(0, screen_range.y)));
		add_child(units[i]);
		
		
func rule(i, center):
	var unit = units[i];
	var direction_to_center = center - unit.get_global_position();
	return direction_to_center;
	
	
func _ready(): 
	set_process(true);
	
	
func _process(delta):
	for i in range(0, nb_of_units):
		var velocity = rule(i, center_of_swarm);
		units[i].set_linear_velocity(velocity);
