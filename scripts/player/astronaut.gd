class_name Player
extends CharacterBody2D
signal respawn

var speed := 300.0
var health := 3
var bullet = preload("res://scenes/player/player_bullet.tscn")
const ACCELERATION := 100.0
var god_mode : bool
var respawn_pos := Vector2(243, 608)
@onready var bullet_position: Marker2D = $BulletPosition

func _ready() -> void:
	ObjectAccessor.astronaut = self

func _physics_process(_delta: float) -> void:
	Movement()
	Shoot()
	GodMode()
	RockMovement()
	move_and_slide()

func Movement():
	if Globals.died:
		return
	var inputs = Input.get_vector("left", "right", "up", "down")
	velocity = velocity.move_toward(speed * inputs, ACCELERATION)

func Shoot():
	if Globals.died:
		return
	if Input.is_action_just_pressed("shoot"):
		var bullet_instance = bullet.instantiate()
		add_sibling(bullet_instance)
		bullet_instance.global_position = bullet_position.global_position

func take_damage():
	if Globals.died:
		return
	health -= 1
	
	# Dying
	if health != 0:
		return
	visible = false # Replace with death AnimationPlayer
	Globals.died = true

func _on_respawn() -> void:
	Globals.died = false
	health = 3
	visible = true

func heal():
	if health == 3:
		return
	health += 1

func GodMode():
	if Input.is_action_just_pressed("god mode"):
		if not god_mode:
			god_mode = true
		else:
			health = 3
			god_mode = false
	
	if not god_mode:
		return
	health = 999

func RockMovement(): # redundant, but just keep it for now
	var rock_push_force := 0.5
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var body = collision.get_collider()
		
		if body is RigidBody2D:
			var push_direction = -collision.get_normal()
			body.apply_force(push_direction * rock_push_force)
