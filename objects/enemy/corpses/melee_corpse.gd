extends Corpse

class_name MeleeCorpse

var finito = false

func try_kill_unit():
	if not finito:
		finito = true
		add_one_unit.emit(self.global_position, EnemyType.MELEE)
		queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body is Unit) and not finito:
		call_deferred("try_kill_unit")
