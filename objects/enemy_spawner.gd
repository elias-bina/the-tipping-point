extends Node2D

var player_pos : Vector2 = Vector2(0,0)
var max_spawn_range = 1000;

var melee_enemy = preload("res://objects/enemy/melee_enemy.tscn");
var ranged_enemy = preload("res://objects/enemy/ranged_enemy.tscn");
var shield_enemy = preload("res://objects/enemy/shield_enemy.tscn");
var units = [];


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var timer = get_node("SpawnTimer")
	timer.timeout.connect(_on_timer_timeout)
	print(get_tree_string())



func set_player_pos(pos : Vector2):
	player_pos = pos
	var list_child = get_children()
	for child in list_child:
		if child is Enemy:
			child.set_target(pos)

func _on_timer_timeout():
	if((self.global_position - player_pos).length() < max_spawn_range):
		return;

	var enemy = melee_enemy.instantiate()
	enemy.set_global_position(Vector2(0, 0));
	add_child(enemy);
	units.append(enemy)
