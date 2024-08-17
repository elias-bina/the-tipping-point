extends RigidBody2D

class_name Unit

func is_melee():
	return false;
	
func is_ranged():
	return false;
	
func is_shield():
	return false;




#var angular_force = 50
#var target = position + Vector2.RIGHT
#
#func _physics_process(delta):
	#var dir = transform.y.dot(position.direction_to(target))
	#angular_velocity = - dir * angular_force
