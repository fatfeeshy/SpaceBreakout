class_name PlayerBullet
extends RigidBody2D

func _ready() -> void:
	linear_velocity = Vector2(0, -300)

func _process(_delta: float) -> void:
	pass
