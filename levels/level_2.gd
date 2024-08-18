extends Node2D

var swarmNode: Node = null
var enemySpawners: Node = null


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	swarmNode = get_node("PlayerSwarm");
	swarmNode.initialize_positions(Vector2(200,200), 1, 1, 0);
	enemySpawners = get_node("EnemySpawners");
	
	for spawner in enemySpawners.get_children():
		spawner.add_one_unit.connect(swarmNode._on_enemy_spawner_add_one_unit)
	
	swarmNode.player_move.connect(_on_player_move)


func _on_player_move(pos: Vector2):
	if !enemySpawners:
		return;
	
	for spawner in enemySpawners.get_children():
		spawner.set_player_pos(pos)
