extends Node2D

var swarmNode: Node = null
var enemySpawner: Node = null


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	swarmNode = get_node("PlayerSwarm");
	swarmNode.initialize_positions(get_viewport_rect().size, 10, 40, 20);
	enemySpawner = get_node("EnemySpawners");
	
	swarmNode.player_move.connect(_on_player_move)


func _on_player_move(pos: Vector2):
	if !enemySpawner:
		return;
	
	for spawner in enemySpawner.get_children():
		spawner.set_player_pos(pos)
