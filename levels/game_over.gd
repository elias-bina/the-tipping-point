extends Control


var label = null
var progress_bar = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label = $EndGameLabel


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		get_tree().paused = false
		get_tree().reload_current_scene()


func _on_swarm_charge_bar_game_lost(time: int) -> void:
	get_tree().paused = true
	$MusicFail.play()
	label.text = "GAME OVER IN ONLY %d SEC !!!!!\nPress R / Start to Retry" % time


func _on_swarm_charge_bar_game_won(time: int) -> void:
	get_tree().paused = true
	$MusiqueReussit.play()
	label.text = "You WON in %d Seconds !!!!!\nPress R / Start to Retry with a better score" % time
