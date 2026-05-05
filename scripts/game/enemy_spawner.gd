extends Node2D

var grid := 25
var wall_adjustment_sm := Vector2(20, 20)
var wall_adjustment_med := Vector2(30, 30)
var wall_adjustment_large := Vector2(20, 30)
var enemies_spawnable : bool
var enemy_list := []
var small_enemy = preload("res://scenes/enemies/enemies/small_enemy.tscn")
var medium_enemy = preload("res://scenes/enemies/enemies/medium_enemy.tscn")
var large_enemy = preload("res://scenes/enemies/enemies/big_enemy.tscn")
@onready var enemy_spawn_timer: Timer = $EnemySpawnTimer

func enemy_spawner(setup_dict: Dictionary):
	for coordinate in setup_dict:
		if setup_dict[coordinate] == "small":
			var new_enemy = small_enemy.instantiate()
			new_enemy.global_position = (coordinate * grid) + wall_adjustment_sm
			add_child(new_enemy)
		if setup_dict[coordinate] == "medium":
			var new_enemy = medium_enemy.instantiate()
			new_enemy.global_position = (coordinate * grid) + wall_adjustment_med
			add_child(new_enemy)
		if setup_dict[coordinate] == "large":
			var new_enemy = large_enemy.instantiate()
			new_enemy.global_position = (coordinate * grid) + wall_adjustment_large
			add_child(new_enemy)

func _ready() -> void:
	var setup = SETUPS.setup_dict[randi_range(1, 1)]
	randomize()
	enemy_spawner(setup)
	print(enemy_spawner(setup))

func _process(_delta: float) -> void:
	SpawnEnemies()

func SpawnEnemies():
	if not enemy_list.is_empty():
		return
	# SCORE AND WAVE MANAGEMENT #
	ScoreManager.wave_started = false # not yet
	if enemy_spawn_timer.is_stopped():
		enemies_spawnable = true
		enemy_spawn_timer.start()

func _on_enemy_spawn_timer_timeout() -> void:
	var setup = SETUPS.setup_dict[randi_range(1, 3)]
	randomize()
	if enemies_spawnable:
		ScoreManager.DetermineScore()
		WaveTimer.start()
		enemy_spawner(setup)

func _on_enemy_checker_area_entered(area: Area2D) -> void:
	if area is not Enemy:
		return
	enemy_list.append("enemy")
	enemies_spawnable = false
	# WAVE MANAGEMENT #
	ScoreManager.wave_started = true

func _on_enemy_checker_area_exited(area: Area2D) -> void:
	# For when an enemy dies
	if area is Enemy:
		enemy_list.pop_back()
