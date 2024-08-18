extends Enemy

class_name MeleeEnemy

func _init():
	max_speed = 30000
	max_hp = 2
	curr_hp = max_hp
	enemy_type = EnemyType.MELEE
	corpse_spawn_probability = 0.2
	
func _ready() -> void:
	$AnimationPlayer.play("zenfjskelf")

func is_melee():
	return true;
