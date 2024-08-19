extends Unit

class_name RangedUnit


var bullet_preload = preload("res://objects/projectiles/bullet.tscn");
var bullet_speed: float = 3000

func _ready() -> void:
	max_hp = 3
	curr_hp = max_hp
	$AnimationPlayer.play("filsdepute")

func get_velocity_modifier(center):
	return Vector2(0,0)
		
func shoot(target_direction: Vector2):
	var bullet = bullet_preload.instantiate()
	bullet.set_global_position(position)
	
	bullet.set_velocity(linear_velocity + target_direction.normalized() * bullet_speed )
	get_parent().add_child(bullet)
