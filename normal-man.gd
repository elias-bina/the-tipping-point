extends Sprite2D

func _init() -> void:
	pass

const base_speed: int = 400
const dash_speed: int = 2500
var curr_speed: int = 400


const acceleration_frames: int = 10

var depl_dir: Vector2 = Vector2(0,0)

var prev_velocity: Vector2 =  Vector2(0.0, 0.0)
var curr_velocity: Vector2 =  Vector2(0.0, 0.0)
var target_velocity: Vector2 =  Vector2(0.0, 0.0)


func _process(delta: float) -> void:
	if(curr_velocity.length() <= base_speed):
		curr_velocity = target_velocity
	else:
		curr_velocity += (target_velocity - curr_velocity) / acceleration_frames

	position += curr_velocity * delta



func _on_input_manager_move_vertical_update(move_y: float) -> void:
	depl_dir.y = move_y
	target_velocity = depl_dir.normalized() * curr_speed


func _on_input_manager_move_horizontal_update(move_x: float) -> void:
	depl_dir.x = move_x
	target_velocity = depl_dir.normalized() * curr_speed


func _on_input_manager_activate_dash() -> void:
	curr_velocity = depl_dir.normalized() * dash_speed


func _on_input_manager_activate_attack() -> void:
	print("attack")


func _on_input_manager_activate_parry() -> void:
	print("parry")


func _on_input_manager_activate_shoot() -> void:
	print("shoot")
