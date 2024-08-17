extends Node2D



func _on_slash_duration_timer_timeout() -> void:
	queue_free()



var enemy_array = []

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Enemy:
		body.take_hit(1);
