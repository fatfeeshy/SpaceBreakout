extends EnemyBullet

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	move()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.take_damage()
