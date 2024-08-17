extends Enemy

class_name MeleeEnemy

func _init():
	max_hp = 3
	curr_hp = max_hp


func is_melee():
	return true;
