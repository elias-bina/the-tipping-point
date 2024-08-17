extends Node2D

signal ferme_ta_gueule

signal move_vertical_update(move_y : float)
signal move_horizontal_update(move_x : float)

signal activate_dash
signal activate_attack
signal activate_shoot
signal activate_parry


static var move_direction:Vector2 = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var timer = get_node("Timer")
	timer.timeout.connect(_on_timer_timeout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	update_vertical_input()
	update_horizontal_input()
	update_swarm_input()

func update_swarm_input():
	if Input.is_action_just_pressed("player_dash"):
		activate_dash.emit()
		return
	if Input.is_action_just_pressed("player_attack"):
		activate_attack.emit()
		return
	if Input.is_action_just_pressed("player_shoot"):
		activate_shoot.emit()
		return
	if Input.is_action_just_pressed("player_parry"):
		activate_parry.emit()
		return

func update_vertical_input() -> void:
	# TODO: Optim, do not launch an event if still (hardcore w analog) 
	if Input.is_action_pressed("player_up"):
		move_direction.y = -Input.get_action_strength("player_up")
		move_vertical_update.emit(move_direction.y)
	else:
		if Input.is_action_pressed("player_down"):
			move_direction.y = Input.get_action_strength("player_down")
			move_vertical_update.emit(move_direction.y)
		else:
			move_direction.y = 0
			move_vertical_update.emit(move_direction.y)



func update_horizontal_input() -> void:
	# TODO: Optim, do not launch an event if still (hardcore w analog) 
	if Input.is_action_pressed("player_left"):
		move_direction.x = -Input.get_action_strength("player_left")
		move_horizontal_update.emit(move_direction.x)
	else:
		if Input.is_action_pressed("player_right"):
			move_direction.x = Input.get_action_strength("player_right")
			move_horizontal_update.emit(move_direction.x)
		else:
			move_direction.x = 0
			move_horizontal_update.emit(move_direction.x)





func _on_button_pressed() -> void:
	print("Je print")

var big: bool = false

func _on_timer_timeout() -> void:
	ferme_ta_gueule.emit()
	if big:
		scale /= 1.5
	else:
		scale *= 1.5
	big = not big;


func _on_activate_dash() -> void:
	pass # Replace with function body.
