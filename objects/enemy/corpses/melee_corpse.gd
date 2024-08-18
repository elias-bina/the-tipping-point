extends Corpse

class_name MeleeCorpse

var finito = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body is Unit) and not finito:
		finito = true
		add_one_unit.emit(self.global_position, EnemyType.MELEE)
		queue_free()
