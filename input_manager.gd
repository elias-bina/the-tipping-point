extends Node2D

signal ferme_ta_gueule

signal move_vertical_update(move_y : int)
signal move_horizontal_update(move_x : int)


static var move_direction:Vector2i = Vector2i(0,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var timer = get_node("Timer")
	timer.timeout.connect(_on_timer_timeout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	update_vertical_input()
	update_horizontal_input()
	update_swarm_input()
	

func update_swarm_input() -> void:
	pass

func update_vertical_input() -> void:
			
	if Input.is_action_pressed("ui_up") or Input.is_action_pressed("player_up"):
		if(move_direction.y > -1):
			move_vertical_update.emit(-1)
			move_direction.y = -1
	else:
		if Input.is_action_pressed("ui_down") or Input.is_action_pressed("player_down"):
			if(move_direction.y < 1):
				move_vertical_update.emit(1)
				move_direction.y = 1
		else:
			if(move_direction.y != 0):
				move_vertical_update.emit(0)
				move_direction.y = 0



func update_horizontal_input() -> void:
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("player_left"):
		if(move_direction.x > -1):
			move_horizontal_update.emit(-1)
			move_direction.x = -1
	else:
		if Input.is_action_pressed("ui_right") or Input.is_action_pressed("player_right"):
			if(move_direction.x < 1):
				move_horizontal_update.emit(1)
				move_direction.x = 1
		else:
			if(move_direction.x != 0):
				move_horizontal_update.emit(0)
				move_direction.x = 0





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
	print("Jaag")
