extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var swarmNode = get_node("PlayerSwarm");
	swarmNode.initialize_positions(get_viewport_rect().size, 10, 20, 10);
