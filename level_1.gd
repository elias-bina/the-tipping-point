extends Node2D

var swarmNode: Node = null
var enemySpawner: Node = null


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	swarmNode = get_node("PlayerSwarm");
	swarmNode.initialize_positions(get_viewport_rect().size, 10, 5, 5);
	enemySpawner = get_node("EnemySpawner");
	
	swarmNode.player_move.connect(_on_player_move)


func _on_player_move(pos: Vector2):
	if enemySpawner:
		enemySpawner.set_player_pos(pos)
 
 
