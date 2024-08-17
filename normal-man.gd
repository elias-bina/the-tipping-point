extends Sprite2D

func _init() -> void:
	pass

const max_speed: int = 400
const acceleration_frames: int = 10

var depl_dir: Vector2 = Vector2(0,0)

var prev_velocity: Vector2 =  Vector2(0.0, 0.0)
var curr_velocity: Vector2 =  Vector2(0.0, 0.0)
var target_velocity: Vector2 =  Vector2(0.0, 0.0)


func _process(delta: float) -> void:
	curr_velocity = target_velocity
	#var velocity: Vector2 = Vector2.UP.rotated(rotation) * speed
	position += curr_velocity * delta



func _on_input_manager_move_vertical_update(move_y: int) -> void:
	depl_dir.y = move_y
	target_velocity = depl_dir.normalized() * max_speed


func _on_input_manager_move_horizontal_update(move_x: int) -> void:
	depl_dir.x = move_x
	target_velocity = depl_dir.normalized() * max_speed


func _on_input_manager_activate_dash() -> void:
	print("dash")


func _on_input_manager_activate_attack() -> void:
	print("attack")


func _on_input_manager_activate_parry() -> void:
	print("parry")


func _on_input_manager_activate_shoot() -> void:
	print("shoot")
