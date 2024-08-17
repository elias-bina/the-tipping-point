extends Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


var count: int = 0
func _on_input_manager_ferme_ta_gueule() -> void:
	text = "HEH : %d" % count 
	count += 1 
