extends Node

var melee_unit = preload("res://objects/unit/melee_unit.tscn");
var ranged_unit = preload("res://objects/unit/ranged_unit.tscn");
var shield_unit = preload("res://objects/unit/shield_unit.tscn");
var units = [];
var nb_of_units = 0;

var unit_speed = 0.01;
var center_of_swarm = Vector2(400, 400);

# ------------- Movement vars -------------

## ------------- Swarm vars -------------

const swarm_attrction_factor = 4

## ------------- Cursor vars -------------

const base_speed: int = 400
const dash_speed: int = 2500
var curr_speed: int = 400

const acceleration_frames: int = 10

var depl_dir: Vector2 = Vector2(0,0)

var prev_velocity: Vector2 =  Vector2(0.0, 0.0)
var curr_velocity: Vector2 =  Vector2(0.0, 0.0)
var target_velocity: Vector2 =  Vector2(0.0, 0.0)

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

var cursorNode : Node = null

func _ready(): 
	cursorNode = get_node("PlayerCursor");
	set_process(true);
	

func rule(i: int, center: Vector2):
	var unit = units[i];
	var direction_to_center = center - unit.get_global_position();
	return direction_to_center;
	
	
func _process(delta: float):
	update_center_of_swarm(delta);
	for i in range(0, nb_of_units):
		var velocity = rule(i, center_of_swarm) * swarm_attrction_factor;
		units[i].set_linear_velocity(velocity);


func update_center_of_swarm(delta: float):
	if(curr_velocity.length() <= base_speed):
		curr_velocity = target_velocity
	else:
		curr_velocity += (target_velocity - curr_velocity) / acceleration_frames
	
	center_of_swarm += curr_velocity * delta
	cursorNode.position = center_of_swarm


func _on_input_manager_move_vertical_update(move_y: float) -> void:
	depl_dir.y = move_y
	target_velocity = depl_dir.normalized() * curr_speed


func _on_input_manager_move_horizontal_update(move_x: float) -> void:
	depl_dir.x = move_x
	target_velocity = depl_dir.normalized() * curr_speed


func _on_input_manager_activate_dash() -> void:
	curr_velocity = depl_dir.normalized() * dash_speed


func _on_input_manager_activate_attack() -> void:
	print("attack")


func _on_input_manager_activate_parry() -> void:
	print("parry")


func _on_input_manager_activate_shoot() -> void:
	print("shoot")
