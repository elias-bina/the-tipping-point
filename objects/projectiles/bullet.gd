extends Node2D

var curr_velocity = Vector2(0,0)

func _on_bullet_duration_timer_timeout() -> void:
	queue_free()

var enemy_array = []



func _physics_process(delta: float) -> void:
	global_position += curr_velocity * delta
	global_rotation = curr_velocity.angle()

func set_velocity(target_velocity: Vector2):
	curr_velocity = target_velocity



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Enemy:
		body.take_hit(1);
