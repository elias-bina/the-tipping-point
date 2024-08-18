extends CharacterBody2D

class_name Enemy

signal spawn_corpse(pos: Vector2, type: int)


const max_speed: int = 200
var max_hp: int = 1;

var targetPos: Vector2 = Vector2(0,0)
var curr_hp: int = max_hp

func _init() -> void:
	curr_hp = max_hp

func _physics_process(delta: float) -> void:
	velocity = (targetPos - position).normalized() * max_speed
	move_and_slide()



func take_hit(nb_hp: int):
	var enemy_type = EnemyType.MELEE
	curr_hp -= nb_hp
	if curr_hp <= 0:
		if self is RangedEnemy:
			enemy_type = EnemyType.RANGE
		elif self is ShieldEnemy:
			enemy_type = EnemyType.SHIELD
		
		spawn_corpse.emit(self.position, EnemyType.MELEE)
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
