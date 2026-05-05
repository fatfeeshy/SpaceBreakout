extends RigidBody2D
signal fast_rock_picked_up

var default_bounce = 0.80
var fast_rock_bounce = 0.92
@onready var fast_rock_timer: Timer = $FastRockTimer

func _ready() -> void:
	ObjectAccessor.rock = self
	physics_material_override.bounce = default_bounce
	linear_velocity.x = randf_range(-30.0, 30.0)
	linear_velocity.y = randf_range(-30.0, 30.0)
	angular_velocity = randf_range(-5.0, 5.0)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is Enemy:
		area.take_damage()

func _on_fast_rock_picked_up() -> void:
	physics_material_override.bounce = fast_rock_bounce
	fast_rock_timer.start()

func _on_fast_rock_timer_timeout() -> void:
	physics_material_override.bounce = default_bounce
