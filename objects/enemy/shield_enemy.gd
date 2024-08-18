extends Enemy

class_name ShieldEnemy

func _init():
	max_hp = 2
	curr_hp = max_hp
	enemy_type = EnemyType.SHIELD


func is_ranged():
	return true;
