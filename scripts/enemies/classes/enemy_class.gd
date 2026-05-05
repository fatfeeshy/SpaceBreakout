class_name Enemy
extends Area2D

# ENEMIES
var health : int
var enemy_name : String = ""
var small_drop_chance := 0.10
var medium_drop_chance := 0.20
var large_drop_chance := 1.0

# ENEMY BULLETS
var small_bullet = preload("res://scenes/enemies/bullets/small_bullet.tscn")
@onready var small_bullet_pos: Marker2D = $BulletPosition
var medium_bullet = preload("res://scenes/enemies/bullets/medium_bullet.tscn")
@onready var medium_bullet_pos: Marker2D = $BulletPosition
var large_bullet = preload("res://scenes/enemies/bullets/big_bullet.tscn")
@onready var large_bullet_pos: Marker2D = $BulletPosition

# ITEMS
var items = {
	1: preload("res://scenes/game/items/healthpack.tscn"), # health pack
	2: preload("res://scenes/game/items/fastrock.tscn"), # fast rock
}

# FUNCTIONS
func shoot(bullet_type = ""):
	match bullet_type:
		"small":
			var bullet_instance = small_bullet.instantiate()
			add_sibling(bullet_instance)
			bullet_instance.global_position = small_bullet_pos.global_position
		"medium":
			var bullet_instance = medium_bullet.instantiate()
			add_sibling(bullet_instance)
			bullet_instance.global_position = medium_bullet_pos.global_position
		"large":
			var bullet_instance = large_bullet.instantiate()
			add_sibling(bullet_instance)
			bullet_instance.global_position = large_bullet_pos.global_position

func take_damage():
	health -= 1
	match enemy_name:
		"small_enemy":
			die("small")
		"medium_enemy":
			die("medium")
		"big_enemy":
			die("large")

func drop_item(enemy_type = ""):
	var item_instance = items[randi_range(1, 2)].instantiate()
	randomize()
	match enemy_type:
		"small":
			if randf() > small_drop_chance:
				return
			add_sibling(item_instance)
			item_instance.global_position = small_bullet_pos.global_position
		"medium":
			if randf() > medium_drop_chance:
				return
			add_sibling(item_instance)
			item_instance.global_position = medium_bullet_pos.global_position
		"large":
			if randf() > large_drop_chance:
				return
			add_sibling(item_instance)
			item_instance.global_position = large_bullet_pos.global_position

func die(enemy_type = ""):
	if health != 0:
		return
	match enemy_type:
		# Code for item drops, particles, score
		"small":
			ScoreManager.wave_score += 10.0
			drop_item("small")
		"medium":
			ScoreManager.wave_score += 25.0
			drop_item("medium")
		"large":
			ScoreManager.wave_score += 50.0
			drop_item("large")
	queue_free()
