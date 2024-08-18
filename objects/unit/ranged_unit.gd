extends Unit

class_name RangedUnit


var bullet_preload = preload("res://objects/projectiles/bullet.tscn");
var bullet_speed: float = 3000

func _ready() -> void:
	var max_hp = 2
	var curr_hp = 2
	$AnimationPlayer.play("filsdepute")

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

func shoot(target_direction: Vector2):
	var bullet = bullet_preload.instantiate()
	bullet.set_global_position(position)
	
	bullet.set_velocity(linear_velocity + target_direction.normalized() * bullet_speed )
	get_parent().add_child(bullet)
