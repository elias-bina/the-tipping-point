extends Enemy

class_name RangedEnemy


func _init():
	max_hp = 2
	curr_hp = max_hp
	enemy_type = EnemyType.RANGED
	corpse_spawn_probability = 0.8



func _ready() -> void:
	$AnimationPlayer.play("enfin_putain")
	
	
func is_ranged():
	return true;


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Unit:
		body.take_hit(1)
