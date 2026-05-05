extends ItemClass

func _process(_delta: float) -> void:
	move()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.heal()
		print("Got Health Pack!")
