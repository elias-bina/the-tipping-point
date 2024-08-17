extends Sprite2D

func _init() -> void:
	print("Te mere en slip")

const min_speed = 50
const max_speed = 400
const acceleration_frames = 10

var speed = 20
var prev_speed = min_speed
var target_speed = min_speed

var accelerate = false
var decelerate = false

var angular_speed = PI * 3

func _process(delta: float) -> void:
	var direction = 0
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("player_left"):
		direction = -1
	if Input.is_action_pressed("ui_right") or Input.is_action_pressed("player_right"):
		direction = 1
		
		
	if Input.is_action_pressed("ui_up") or Input.is_action_pressed("player_up"):
		if not accelerate:
			prev_speed = speed
			target_speed = max_speed
			decelerate = false
			accelerate = true
	else:
		if Input.is_action_pressed("ui_down") or Input.is_action_pressed("player_down"):
			if not decelerate:
				prev_speed = speed
				target_speed = -max_speed
				decelerate = true
				accelerate = false
		else:
			if accelerate or decelerate:
				prev_speed = speed
				target_speed = min_speed
				decelerate = false
				accelerate = false
	
	
	if sign(target_speed - speed) == sign(target_speed - prev_speed):
		speed += (target_speed - prev_speed) / acceleration_frames


	rotation += angular_speed * direction * delta

	var velocity = Vector2.UP.rotated(rotation) * speed
	position += velocity * delta
	
