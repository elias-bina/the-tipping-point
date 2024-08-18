extends Corpse

class_name MeleeCorpse


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Unit:
		add_one_unit.emit(self.global_position, EnemyType.MELEE)
		queue_free()
