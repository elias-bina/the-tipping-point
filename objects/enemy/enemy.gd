extends CharacterBody2D

class_name Enemy

const max_speed = 200

var targetPos: Vector2 = Vector2(0,0)
var angular_force = 50000
var linear_force = 5

func _physics_process(delta: float) -> void:
	velocity = (targetPos - position).normalized() * max_speed
	move_and_slide()

func set_target(pos: Vector2):
	targetPos = pos

func is_melee():
	return false;
	
func is_ranged():
	return false;
	
func is_shield():
	return false;
