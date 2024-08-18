extends Control

signal game_won(time: int)
signal game_lost(time: int)

var label = null
var progress_bar = null

var time_start = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label = $SwarmChargeLabel
	progress_bar = $SwarmChargeProgressBar
	time_start = Time.get_unix_time_from_system()


func _on_player_swarm_enroll_update(nb_people: int, max_people: int) -> void:
	if label:
		label.text = "%d Enrolled people / %d" % [nb_people, max_people]
	if progress_bar:
		progress_bar.value = nb_people
		progress_bar.max_value = max_people

	if	nb_people <= 0:
		game_lost.emit(Time.get_unix_time_from_system() - time_start)
	
	if nb_people >= max_people:
		game_won.emit(Time.get_unix_time_from_system() - time_start)
