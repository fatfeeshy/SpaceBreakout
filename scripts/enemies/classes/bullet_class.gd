class_name EnemyBullet
extends Area2D

func move():
	var move_speed = 2.5
	self.global_position.y += move_speed
