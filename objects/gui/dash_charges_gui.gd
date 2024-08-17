extends Control


var label = null
var picture = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label = $DashChargesNbLabel
	picture = $DashChargedIcon


func _on_player_swarm_dash_update(nb_charges: int) -> void:
	if label:
		label.text = "%d" % nb_charges
	if picture:
		if nb_charges:
			picture.modulate = Color(1, 1, 1, 1)	
		else:
			picture.modulate = Color(0.5, 0.5, 0.5, 1)
