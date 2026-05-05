extends ItemClass
func _process(_delta: float) -> void:
	move()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		ObjectAccessor.rock.fast_rock_picked_up.emit()
		print("Got Fast Rock!")
