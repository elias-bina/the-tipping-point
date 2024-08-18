extends Control


var label = null
var progress_bar = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label = $SwarmChargeLabel
	progress_bar = $SwarmChargeProgressBar


func _on_player_swarm_enroll_update(nb_people: int, max_people: int) -> void:
	if label:
		label.text = "%d Enrolled people / %d" % [nb_people, max_people]
	if progress_bar:
		progress_bar.value = nb_people
		progress_bar.max_value = max_people
