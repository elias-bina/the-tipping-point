extends Node2D

var swarmNode = preload("res://objects/player_swarm.tscn");


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var swarm = swarmNode.instantiate();
	swarm.initialize_positions(get_viewport_rect().size, 10, 20, 10);
	add_child(swarm);
