extends Sprite2D

func _init() -> void:
	print("Te mere en slip")

const max_speed: int = 400
const acceleration_frames: int = 10

var depl_dir: Vector2i = Vector2i(0,0)

var prev_velocity: Vector2 =  Vector2(0.0, 0.0)
var curr_velocity: Vector2 =  Vector2(0.0, 0.0)
var target_velocity: Vector2 =  Vector2(0.0, 0.0)

func _process(delta: float) -> void:


	print(target_velocity)

	if sign(target_velocity.x - curr_velocity.x) == sign(target_velocity.x - prev_velocity.x) and sign(target_velocity.y - curr_velocity.y) == sign(target_velocity.y - prev_velocity.y):
		curr_velocity += (target_velocity - prev_velocity) / acceleration_frames

	#var velocity: Vector2 = Vector2.UP.rotated(rotation) * speed
	position += curr_velocity * delta



func _on_input_manager_move_vertical_update(move_y: int) -> void:
	print("BOUGE GERALDINE : %d" % move_y)
	depl_dir.y = move_y
	target_velocity.y = depl_dir.y * max_speed


func _on_input_manager_move_horizontal_update(move_x: int) -> void:
	print("BOUGE GERMAIN : %d" %move_x)
	depl_dir.x = move_x
	target_velocity.x = depl_dir.x * max_speed
