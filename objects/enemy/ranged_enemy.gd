extends Enemy

class_name RangedEnemy


func _init():
	max_hp = 2
	curr_hp = max_hp
	enemy_type = EnemyType.RANGED


func is_ranged():
	return true;
