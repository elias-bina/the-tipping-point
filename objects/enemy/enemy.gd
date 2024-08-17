extends CharacterBody2D

class_name Enemy

const max_speed = 200
const max_hp = 1;

var targetPos: Vector2 = Vector2(0,0)
var curr_hp = max_hp

func _init() -> void:
	curr_hp = max_hp

func _physics_process(delta: float) -> void:
	velocity = (targetPos - position).normalized() * max_speed
	move_and_slide()



func take_hit(nb_hp: int):
	queue_free()

func set_target(pos: Vector2):
	targetPos = pos

func is_melee():
	return false;
	
func is_ranged():
	return false;
	
func is_shield():
	return false;
