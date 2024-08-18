extends RigidBody2D

class_name Unit

func is_melee():
	return false;
	
func is_ranged():
	return false;
	
func is_shield():
	return false;

var curr_hp = 3
var max_hp = 3

var should_die = false

func take_hit(nb_hp: int):
	curr_hp -= nb_hp
	if curr_hp <= 0:
		$/root/GameRoom/EnemyDeathSound.play()
		should_die = true
	else :
		$/root/GameRoom/EnemyHurtSound.play()

#var angular_force = 50
#var target = position + Vector2.RIGHT
#
#func _physics_process(delta):
	#var dir = transform.y.dot(position.direction_to(target))
	#angular_velocity = - dir * angular_force
