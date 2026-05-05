extends Enemy

@onready var shoot_timer: Timer = $ShootTimer

func _ready() -> void:
	enemy_name = "medium_enemy"
	health = 2

func _on_shoot_timer_timeout() -> void:
	if randf_range(0.0, 1.0) < 0.5:
		shoot("medium")
