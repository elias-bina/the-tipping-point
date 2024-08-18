extends Node

signal player_move(pos: Vector2)
signal dash_update(nb_charges: int)
signal sword_update(nb_charges: int)
signal gun_update(nb_charges: int)
signal enroll_update(nb_charges: int, max_people: int)

var melee_unit = preload("res://objects/unit/melee_unit.tscn");
var ranged_unit = preload("res://objects/unit/ranged_unit.tscn");
var shield_unit = preload("res://objects/unit/shield_unit.tscn");
var units = [];

var unit_speed = 0.01;

# ------------- Movement vars -------------

## ------------- Swarm vars -------------

const swarm_attrction_factor = 5

## ------------- Cursor vars -------------

const base_speed: int = 400
const dash_speed: int = 2500
var curr_speed: int = 400

const acceleration_frames: int = 10

var depl_dir: Vector2 = Vector2(0,0)

var prev_velocity: Vector2 =  Vector2(0.0, 0.0)
var curr_velocity: Vector2 =  Vector2(0.0, 0.0)
var target_velocity: Vector2 =  Vector2(0.0, 0.0)

## ------------- Actions vars -------------

var max_dash_charges: int = 3
var dash_charges: int = 3

var max_sword_charges: int = 3
var sword_charges: int = 3

var max_gun_charges: int = 3
var gun_charges: int = 3

var max_people_army = 50

func initialize_positions(screen_range, nb_of_melee, nb_of_ranged, nb_of_shield):
	randomize();
	var nb_of_units = nb_of_melee + nb_of_ranged + nb_of_shield;
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
	dash_update.emit(dash_charges)


func rule(i: int, center: Vector2):
	var unit = units[i];
	var direction_to_center = center - unit.get_global_position();
	return direction_to_center;
	

func get_force_of_repulsion(_i, _units):
	printerr("ABSTRACT FUNCTION CALLED");

	
func _process(delta: float):
	update_center_of_swarm(delta);
	for i in range(0, units.size()):
		var velocity = rule(i, cursorNode.position) * swarm_attrction_factor;
		units[i].set_linear_velocity(velocity);
		
		var force_of_repulsion = units[i].get_force_of_repulsion(i, units, cursorNode.position);
		units[i].apply_central_force(force_of_repulsion);


func update_center_of_swarm(delta: float):
	if(curr_velocity.length() <= base_speed):
		curr_velocity = target_velocity
	else:
		curr_velocity += (target_velocity - curr_velocity) / acceleration_frames
	
	cursorNode.move_and_collide(curr_velocity * delta);
	player_move.emit(cursorNode.position)


func _on_input_manager_move_vertical_update(move_y: float) -> void:
	depl_dir.y = move_y
	target_velocity = depl_dir.normalized() * curr_speed


func _on_input_manager_move_horizontal_update(move_x: float) -> void:
	depl_dir.x = move_x
	target_velocity = depl_dir.normalized() * curr_speed


func _on_input_manager_activate_dash() -> void:
	if dash_charges > 0 :
		$DashSound.play()
		curr_velocity = depl_dir.normalized() * dash_speed
		dash_charges -= 1
		dash_update.emit(dash_charges)
		$DashCooldown.start()


func _on_input_manager_activate_attack() -> void:
	if sword_charges > 0:
		$SlashSound.play()
		for unit in units:
			if unit is MeleeUnit:
				#TODO: Viser ennemi
				unit.attack()
		sword_charges -= 1
		sword_update.emit(sword_charges)
		$SwordCooldown.start()


func _on_input_manager_activate_parry() -> void:
	$ParrySound.play()
	print("parry")


func _on_input_manager_activate_shoot() -> void:
	if gun_charges > 0:
		$ShotSound.play()
		for unit in units:
			if unit is RangedUnit:
				unit.shoot(target_velocity.normalized())
		gun_charges -= 1
		gun_update.emit(gun_charges)
		$GunCooldown.start()


func _on_dash_cooldown_timeout() -> void:
	dash_charges += 1
	$DashChargeGainSound.play()
	if dash_charges < max_dash_charges:
		$DashCooldown.start()
	dash_update.emit(dash_charges)


func _on_sword_cooldown_timeout() -> void:
	sword_charges += 1
	$SwordChargeGainSound.play()
	if sword_charges < max_sword_charges:
		$SwordCooldown.start()
	sword_update.emit(sword_charges)


func _on_gun_cooldown_timeout() -> void:
	gun_charges += 1
	$GunChargeGainSound.play()
	if gun_charges < max_gun_charges:
		$GunCooldown.start()
	gun_update.emit(gun_charges)



func _on_enemy_spawner_add_one_unit(pos: Vector2, enemy_type: int) -> void:
	if units.size() < max_people_army:
		var enemy_converted = null
		match enemy_type:
			EnemyType.MELEE:
				enemy_converted = melee_unit.instantiate()
			EnemyType.RANGED:
				enemy_converted = ranged_unit.instantiate()

		if enemy_converted :
			$EnrollEnnemySound.play()
			enemy_converted.set_global_position(pos)
			call_deferred("add_child", enemy_converted)
			units.append(enemy_converted)
			enroll_update.emit(units.size(), max_people_army)
