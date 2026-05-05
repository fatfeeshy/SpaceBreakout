extends Control

func _process(_delta: float) -> void:
	if Globals.died:
		visible = true
	else:
		visible = false

func _on_restart_pressed() -> void:
	ObjectAccessor.astronaut.respawn.emit()

func _on_back2menu_pressed() -> void:
	# temporary for now
	get_tree().quit()
