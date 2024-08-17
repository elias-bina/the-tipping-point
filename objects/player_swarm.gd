extends Node

var unitNode = preload("res://objects/unit.tscn");
var units = [];
var units_number = 30;

var unit_speed = 0.01;
var center_of_swarm = Vector2(200, 200);

func initialize_positions(screen_range):
	randomize();
	for i in range(0, units_number):
		units.append(unitNode.instantiate());
		units[i].set_global_position(Vector2(randi_range(0, screen_range.x), randi_range(0, screen_range.y)));
		add_child(units[i]);
		
		
func rule(i, center):
	var unit = units[i];
	var direction_to_center = center - unit.get_global_position();
	return direction_to_center;
	
	
func _ready(): 
	initialize_positions(Vector2(500, 500));
	set_process(true);
	
	
func _process(delta):
	for i in range(0, units_number):
		var velocity = rule(i, center_of_swarm);
		units[i].set_linear_velocity(velocity);
