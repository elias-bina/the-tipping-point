extends CharacterBody2D

class_name Enemy

signal spawn_corpse(pos: Vector2, type: int)


var max_speed: int = 20000
var max_hp: int = 1;
var corpse_spawn_probability: float = 0.5
var enemy_type = EnemyType.NONE;

var rng = RandomNumberGenerator.new()

var targetPos: Vector2 = Vector2(0,0)
var curr_hp: int = max_hp

func _init() -> void:
	rng.randomize()
	curr_hp = max_hp

func _physics_process(delta: float) -> void:
	velocity = (targetPos - global_position).normalized() * delta * max_speed
	move_and_slide()



func take_hit(nb_hp: int):
	curr_hp -= nb_hp
	if curr_hp <= 0:
		if(rng.randf_range(0,1) < corpse_spawn_probability):
			spawn_corpse.emit(self.position, enemy_type)
		$/root/GameRoom/EnemyDeathSound.play()
		queue_free()
	else :
		$/root/GameRoom/EnemyHurtSound.play()

func set_target(pos: Vector2):
	targetPos = pos

func is_melee():
	return false;
	
func is_ranged():
	return false;
	
func is_shield():
	return false;
