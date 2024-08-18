extends Node2D

signal add_one_unit(pos:Vector2, enemy_type: int)

var player_pos : Vector2 = Vector2(0,0)

var melee_enemy = preload("res://objects/enemy/melee_enemy.tscn");
var ranged_enemy = preload("res://objects/enemy/ranged_enemy.tscn");
var shield_enemy = preload("res://objects/enemy/shield_enemy.tscn");

var melee_corpse = preload("res://objects/enemy/corpses/melee_corpse.tscn");



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var timer = get_node("SpawnTimer")
	timer.timeout.connect(_on_timer_timeout)


func set_player_pos(pos : Vector2):
	player_pos = pos
	var list_child = get_children()
	for child in list_child:
		if child is Enemy:
			child.set_target(pos)

func _on_timer_timeout():
	
	if((self.global_position - player_pos).length() < 500):
		return;
		
	var enemy = melee_enemy.instantiate()
	enemy.set_global_position(Vector2(randi_range(0, 400), randi_range(0, 400)))
	enemy.spawn_corpse.connect(_on_spawn_corpse)
	call_deferred("add_child", enemy)


func _on_spawn_corpse(pos:Vector2, enemy_type: int):
	var corpse = null
	if(enemy_type == EnemyType.MELEE):
		corpse = melee_corpse.instantiate()
		corpse.set_global_position(pos);
	
	corpse.add_one_unit.connect(_on_unit_add_request)
	call_deferred("add_child", corpse)
	

func _on_unit_add_request(pos:Vector2, enemy_type: int):
	add_one_unit.emit(pos, enemy_type)
